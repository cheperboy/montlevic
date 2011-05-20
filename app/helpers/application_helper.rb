# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  HEADER_KEY = 0
  HEADER_VALUE = 1
  HEADER_UNIT = 2
  HEADER_FILTER = 3

  def euros
    return '€'
  end

  def draw_table_with_find(headers, elements, controller, action, print_stars=false)
    head_size = headers.count
    link_size = 3    
    out = ""
    #Formulaire de tri
    out += form_tag :action => 'index'
#    out += check_box_tag 'test', value = true, checked = false, options = {:id => 'test'}
    out += submit_tag :'Filtrer'
    out += '<table class="table_list">'
    
    #Head - TH
    out += '<tr>'
    headers.each do |key, value|
      out += '<td><b>'+ value.to_s.capitalize + '</b></td>'    
    end
    out += "<td colspan='#{link_size.to_s}'></td>"
    
    #Formulaire - tetes de colonnes
    out += '<tr>'
    headers.each do |header|
      #TODO
      # faire un switch/case sur la valeur de header[HEADER_FILTER]
       # - soit checkbox
       # - soit text-field
       # - soit rien
      if header[HEADER_FILTER]
        out += '<td>'
        out += text_field 'filter', header[HEADER_KEY].to_sym, :size => 4
        out += '</td>'
      else
        out += '<td></td>'
      end
    end
    out += "<td colspan='#{link_size.to_s}'></td>"
    out += '</tr>'

    #Elements
    elements.each do |element|
      # determination de la class du model pour les liens show/edit/delete
      element_class = element.class.to_s.downcase
      if (element_class == "debit" ||
          element_class == "diverse" ||
          element_class == "reportable")
          element_class = "facture"  
      end
      # Premier tr de l'element  
      out += "<tr class='list-row'>"
      headers.each do |header|
        value = element.send(header[HEADER_KEY])
        #gestion des cas particuliers star et adu : appel de methode link_to_star(model, id, adu)
        if header[HEADER_KEY].eql?("star")
          out += "<td>"
          out += link_to_star(element.class, element.id, false)
          out += "</td>"
        elsif header[HEADER_KEY].eql?("adu")
            out += "<td>"
            out += link_to_star(element.class, element.id, true)
            out += "</td>"
        else  
          #class css du td : align_right ou align_left
          td_class = "list-elt-right"
            if    value.class == String then td_class = "list-elt-left"
            elsif value.class.eql?(Float) then td_class = "list-elt-right"
            elsif value.class.eql?(Fixnum) then td_class = "list-elt-right"
          end
          out += "<td class='#{td_class}'>"
          out += "#{value} #{header[HEADER_UNIT]}"
          out += '</td>'
        end
      end
      
      #Liens
      url = element_class.pluralize
      id = element.id
      out += '<td>'+ link_to_show(element_class, element.id) +'</td>'
      out += '<td>'+ link_to_edit(element_class, element.id) +'</td>'
      out += '<td>'+ link_to_delete(element_class, element.id) +'</td>'
      out += '</tr>'    
    end
    out += '</table>'
  end  
  
  def draw_table(headers, elements, print_stars=false)

    out = ''
    head_size = headers.count
    link_size = 3    
    out += '<table class="table_list">'
    #Head
    out += '<tr>'
    headers.each do |key, value|
      out += '<td><b>'+ value.to_s.capitalize + '</b></td>'    
    end
    out += "<td colspan='#{link_size.to_s}'></td>"
    
    #Elements
    elements.each do |element|
      # determination de la class du model pour les liens show/edit/delete
      element_class = element.class.to_s.downcase
      if (element_class == "debit" ||
          element_class == "diverse" ||
          element_class == "reportable")
          element_class = "facture"  
      end
      # Premier tr de l'element  
      out += "<tr class='list-row'>"
      headers.each do |header|
        value = element.send(header[HEADER_KEY])
        #gestion des cas particuliers star et adu : appel de methode link_to_star(model, id, adu)
        if header[HEADER_KEY].eql?("star")
          out += "<td>"
          out += link_to_star(element.class, element.id, false)
          out += "</td>"
        elsif header[HEADER_KEY].eql?("adu")
            out += "<td>"
            out += link_to_star(element.class, element.id, true)
            out += "</td>"
        else  
          #class css du td : align_right ou align_left
          td_class = "list-elt-right"
            if    value.class == String then td_class = "list-elt-left"
            elsif value.class.eql?(Float) then td_class = "list-elt-right"
            elsif value.class.eql?(Fixnum) then td_class = "list-elt-right"
          end
          out += "<td class='#{td_class}'>"
          out += "#{value} #{header[HEADER_UNIT]}"
          out += '</td>'
        end
      end
      
      #Liens
      url = element_class.pluralize
      id = element.id
      out += '<td>'+ link_to_show(element_class, element.id) +'</td>'
      out += '<td>'+ link_to_edit(element_class, element.id) +'</td>'
      out += '<td>'+ link_to_delete(element_class, element.id) +'</td>'
      out += '</tr>'    
    end
    out += '</table>'
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

  def link_to_show(modele, id)
    url = modele.to_s.downcase.pluralize + '/' + id.to_s
    return (link_to image_tag('img-voir.png'), url)
  end

  def link_to_edit(modele, id)
    url = modele.to_s.downcase.pluralize + '/' + id.to_s + '/edit'
    return (link_to image_tag('img-modif.png'), url)
  end

  def link_to_delete(modele, id)
    url = modele.to_s.downcase.pluralize + '/' + id.to_s
    return (link_to image_tag('img-delete.png'), url, :confirm => 'Are you sure?', :method => :delete)
  end
  	
  def tr_text(key, value, unit=nil)
    out = ''
    out += '<tr><td class="td-left">'
    out += key.to_s
    out += ' : </td>'
    out += '<td class="td-left">'
    out += value.to_s
    if unit
      out += ' ' + unit.to_s
    end
    out += '</td></tr>'
    return out
  end


  def form_tr_text(form, name, col, options=nil)
    value = ''
    size = 25
    unit = ''
    if options
      size = options[:size] if options[:size]
      value = options[:value].to_s if options[:value]
      unit = ' ' + options[:unit].to_s  if options[:unit]
    end
    out = ''
    out += '<tr><td>'
    out += form.label col, name
    out += ' : </td>'
    out += '<td class="td-left">'
    if options && options[:value]
      out += form.text_field col.to_sym, :value => value, :size => size
    else 
      out += form.text_field col.to_sym, :size => size
    end
    out += unit
    out += '</td></tr>'
    return out
  end

  def form_tr_text_area(form, name, col, options=nil)
    out = ''
    out += '<tr><td>'
    out += form.label col, name
    out += ' : </td>'
    out += '<td class="td-left">'
    if options
      out += form.text_area col, :size => options[:size]
    else
      out += form.text_area col
    end
    out += '</td></tr>'
    return out
  end
  
  def form_tr_date(form, name, col, options=nil)
    # start_year = 1999
    # if options && options[:start_year]
    #   start_year = options[:start_year]
    # end
    out = ''
    out += '<tr><td>'
    out += form.label col.to_sym, name
    out += ' : </td>'
    out += '<td class="td-left">'
    out += form.date_select(col.to_sym, :start_year => 2008, :order => [:day, :month, :year]) 
    out += '</td></tr>'
    return out
  end
  
  def form_tr_select(form, name, col, collection, id, display, options = nil)
    out = ''
    out += '<tr><td>'
    out += form.label col.to_sym, name
    out += ' : </td>'
    out += '<td class="td-left">'
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

#  def my_saison
#    session[:current_saison_id] || Setting.find(:first).saison_id
#  end
  
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
  def h_to_s(h)
    out = "<br>"
    out += "DEBUG Hash<br><br>"
    if(h.class.equal?(Hash))
      h.each do |key, value|
        out += "{#{key} => #{value}}"
      end
    else
      out += h.to_s
    end
    out += "<br><br>FIN DEBUG Hash<br>inspect : <br>"
    out += h.inspect
  end

  def p_sym(sym)
    if sym.is_a?(Symbol)
      return (':' + sym.to_s) 
    elsif sym.is_a?(String)
      return ('"' + sym.to_s + '"') 
    else
      return (sym.to_s) 
    end
  end

  def out_hash1(data)
    data.each do |key, value|
      if value.is_a?(Hash)
        logger.error "   #{p_sym(key)} => "
        logger.error "    {"
        out_hash2(value)
        logger.error "    }"
      elsif value.is_a?(Array)
        out = "   #{p_sym(key)} => ["
        value.each do |val|
          out += p_sym(val) + ', '
        end
        out += ']'
        logger.error out    
      else
        logger.error "   #{p_sym(key)} => #{p_sym(value)}, "
      end
    end
  end
  
  def out_hash2(data)
    data.each do |key, value|
      if value.is_a?(Hash)
        logger.error "     #{p_sym(key)} => "
        logger.error "      {"
        out_hash2(value)
        logger.error "      }"
      elsif value.is_a?(Array)
        out = "     #{p_sym(key)} => ["
        value.each do |val|
          out += p_sym(val) + ', '
        end
        out += ']'
        logger.error out    
      else
        logger.error "     #{p_sym(key)} => #{p_sym(value)}, "
      end
    end
  end  
  
  def h_to_s_console(h)
    logger.error("DEBUG Hash")
    if(h.class.equal?(Hash))
      logger.error("{")
      h.each do |key, value|
        if value.is_a?(Hash)
          logger.error " #{p_sym(key)} => "
          logger.error "  {"
          out_hash1(value)
          logger.error "  }"
        elsif value.is_a?(Array)
          out = " #{p_sym(key)} => ["
          value.each do |val|
            out += p_sym(val) + ', '
          end
          out += '], '
          logger.error out
        else
          logger.error " #{p_sym(key)} => #{p_sym(value)}, "
        end
      end
      logger.error("}")
    end
    logger.error("fin DEBUG Hash")
    logger.error("inspect : ")
    logger.error(h.inspect)
    10.times do
      logger.error("")
    end
  end
  
  # h_to_s : affiche correctement un Hash en string  
  def h_to_s_old(parcelle)
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
