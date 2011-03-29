# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def euros
    return '€'
  end
  
  def tr_text(key, value, unit=nil)
    out = ''
    out += '<tr><td class="td-left">'
    out += key.to_s
    out += ' : </td>'
    out += '<td class="td-right">'
    out += value.to_s
    if unit
      out += ' ' + unit
    end
    out += '</td></tr>'
    return out
  end

  def form_tr_text(form, name, col)
    out = ''
    out += '<tr><td>'
    out += form.label col, name
    out += ' : </td>'
    out += '<td>'
    out += form.text_field col.to_sym
    out += '</td></tr>'
    return out
  end

  def form_tr_text_area(form, name, col, options=nil)
    out = ''
    out += '<tr><td>'
    out += form.label col, name
    out += ' : </td>'
    out += '<td>'
    if options
      out += form.text_area col, :size => options[:size]
    else
      out += form.text_area col
    end
    out += '</td></tr>'
    return out
  end
  
  def form_tr_date(form, name, col)
    out = ''
    out += '<tr><td>'
    out += form.label col.to_sym, name
    out += ' : </td>'
    out += '<td>'
    out += form.date_select(col.to_sym, :start_year => 2008, :order => [:day, :month, :year]) 
    out += '</td></tr>'
    return out
  end
  
  def form_tr_select(form, name, col, collection, id, display, options = nil)
    out = ''
    out += '<tr><td>'
    out += form.label col.to_sym, name
    out += ' : </td>'
    out += '<td>'
    unless options.nil?
      out += form.collection_select(col, collection, id, display, :selected => options[:selected]) 
    else
      out += form.collection_select(col, collection, id, display) 
    end
    out += '</td></tr>'
    return out
  end
  
  def form_tr_check(form, name, col)
    out = ''
    out += '<tr><td>'
    out += form.label col, name
    out += ' : </td>'
    out += '<td>'
    out += form.check_box col 
    out += '</td></tr>'
    return out
  end

  def form_tr_check_tag(name, col)
    out = ''
    out += '<tr><td>'
    out += name
    out += ' : </td>'
    out += '<td>'
    out += check_box_tag col 
    out += '</td></tr>'
    return out
  end

  def link_to_star(model, id, adu)
    element = model.find(id)
    if (adu == true)
      link_to_remote  display_adu(element.adu), 
                      :url => { :action => "toggle_adu", :id => element.id } 
                      #, :update => 'list_facture'

    else
      link_to_remote  display_star(element.star), 
                      :url => { :action => "toggle_star", :id => element.id }
    end
  end

  def display_star(star)
    if (star == 1)
      return image_tag('star-yellow.jpg')
    else
      return image_tag('star-white2.jpg')
    end
  end

  def display_adu(adu)
    if (adu == 1)
      return image_tag('star-green.jpg')
    else
      return image_tag('star-white2.jpg')
    end
  end

  def observe_fields(fields, frequency, update, url_action)
    out = ""
    fields.each do |field|
      out += observe_field field,  
              :frequency => frequency, 
              :update => update, 
              :url => {:action => url_action},
              :with => field
    end
    return out
  end

  def admin?
    session[:admin] == (true)
  end
  
  def root?
    session[:root] == (true)
  end
  
  def logged_in?
    return session[:user_id]
  end

  def update_saison() 
    remote_function(:url => { :controller => "settings", :action => "update_saison" },
                    :method => :put)
  end

  def toggle_value(object) 
    remote_function(:url => { :controller => "settings", :action => "update_saison" },
                    :method => :put,
                    :with => "this.name + '=' + this.checked")
  end

  def shortstring(text)
    truncate(text, :length => 11, :omission => '...')
  end

  def odd(id)
    if( id%2 == 0)
      return "even"
    elsif( id%2 > 0)
      return "odd"
    end
  end
  
  def popup(screen, popup)
    link = "#"
    if (screen.nil? || popup.nil?)
      out = "erreur"
    else
      out = '<a href="#" class="tip">'+ (screen.to_s) + '<span>'+ (popup.to_s) +'</span></a>'
    end
    return out
  end

  #retourne une valeur tronquée d'un int
  # TODO : "precision" devrait etre defini par l'utilisateur dans les parametres de l'appli
  # TODO : number_with_precision(1111.2345, :precision => 2, :separator => ',', :delimiter => '.')
  def get_value_or_blank(var, value)
    val = var[value.to_sym]
    return (pretty(val))
  end

  # marche pas
  # retourne 0.0 si valeur nulle
  # (pourquoi?)
  def pretty2(val)
    precision = 1
    out = "" if (val.equal?(0))
    out = "" if (val == 0.0)
    out = val.to_i if (val == val.to_i)
    out = val if precision == 0
    out = (val * 10 ** precision).round.to_f / 10 ** precision
    out
  end
  
  def pretty(val)
    precision = 1
    return "" if (val.equal?(0))
    return "" if (val == 0.0)
    return val.to_i if (val == val.to_i)
    return val if precision == 0
    return (val * 10 ** precision).round.to_f / 10 ** precision
  end
  
  
  # h_to_s : affiche correctement un Hash en string  
  def h_to_s(parcelle)
    out = "debut<br>"
    if(parcelle.class.equal?(Hash))
      parcelle.each do |key, value|
        out+= "#{key} => {"
        out+= print_value(value, 1)
        out+= "<br>"
      end
    else
      out+= parcelle
    end
    out+= "<br>"
    return out
  end
  
  def print_value(val, n)
    dd = "<dd>"
    out=""
    if(val.class.equal?(Hash))
     out+=""
     val.each do |key, value|
        n.times {out += dd}
        out += "#{key} => "
        (n+1).times {out += dd}
        out += "{"
        out += print_value3(value)
        #out += value.to_s
        
        (n+1).times {out += dd}
        out += "}"
      end
      n.times {out += dd}
    else
      out += "#{val}"
    end
    out += ""
  end

  def print_value3(val)
    out=""
    if(val.class.equal?(Hash))
      val.each do |key, value|
        out+= "<dd><dd>"
        out += "#{key} => #{value}"
      end
    else
      out += "#{val.to_s}"
    end
    out+= ""
  end
  
# ----- Nested Forms -----
  
  def remove_link_unless_new_record(fields)
    out = ''
    out << fields.hidden_field(:_delete)  unless fields.object.new_record?
    out << link_to("supprimer", "##{fields.object.class.name.underscore}", :class => 'remove')
    out
  end

  # This method demonstrates the use of the :child_index option to render a
  # form partial for, for instance, client side addition of new nested
  # records.
  #
  # This specific example creates a link which uses javascript to add a new
  # form partial to the DOM.
  #
  #   <% form_for @project do |project_form| -%>
  #     <div id="tasks">
  #       <% project_form.fields_for :tasks do |task_form| %>
  #         <%= render :partial => 'task', :locals => { :f => task_form } %>
  #       <% end %>
  #     </div>
  #   <% end -%>
  def generate_html(form_builder, method, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
    options[:partial] ||= method.to_s.singularize
    options[:form_builder_local] ||= :f  

    form_builder.fields_for(method, options[:object], :child_index => 'NEW_RECORD') do |f|
      render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })
    end
  end

  def generate_template(form_builder, method, options = {})
    escape_javascript generate_html(form_builder, method, options)
  end

end