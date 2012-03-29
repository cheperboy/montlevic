# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  HEADER_KEY = 0
  HEADER_VALUE = 1
  HEADER_UNIT = 2
  HEADER_FILTER = 3
  HEADER_TYPE = 4
  HEADER_TRI = 5
  HEADER_TRI_KEY = 6
  HEADER_RED_GREEN = 7
  HEADER_COLOR = 8
  
  # Retourne la valeur a afficher d'une 
  # liste de choix construite avec un tableau de constantes
  # a = [ [ 1, "one"], [2, "two"], [3, "three"], ["ii", "two"] ] 
  # a.rassoc("two") → [2, "two"]
  def constant_pp(array, value)
    new_array = array.rassoc(value)
    return (new_array[0].to_s)
  end
  
  def toggle_star(object, controller)
    remote_function(:url => { :controller => controller, :action => "update_star", :id => object.id },
                    :method => :put,
                    :before => "Element.show('spinner-#{object.id}')" ,
                    :complete => "Element.hide('spinner-#{object.id}')",
                    :with => "this.name + '=' + this.checked"
                    )
  end

  def toggle_adu(object, controller)
    remote_function(:url => { :controller => controller, :action => "update_adu", :id => object.id },
                    :method => :put,
                    :before => "Element.show('spinner-#{object.id}')" ,
                    :complete => "Element.hide('spinner-#{object.id}')",
                    :with => "this.name + '=' + this.checked"
                    )
  end
  
  def call_update_saison()
    logger.error "call_update_saison()"
    remote_function(:url => { :controller => "application", :action => "update_current_saison_id", :id => nil },
                    :method => :put,
                    :with => "this.name + '=' + this.value"
                    )
  end

  # Remplace collection_select et ajoute les Types de culture en plus des parcelles
  # Obsolete, non utilise
  def collection_parcelle_and_culture(form, parcelle_id, parcelles, id, name)
    options = []
    Setting.find(1).saison.typecultures.each {|c| options << c }
    Setting.find(1).saison.parcelles.each {|p| options << p }
    return form.collection_select(:parcelle_id, options, :id, :name_for_select )
  end
  
  def toggle_div(div) 
    logger.error 'toggle_div id : ' + div.to_s + ' page[div] : ' + page[div]
    update_page do |page|
      page[div].toggle
      page[div].visual_effect :highlight
    end 
  end
  
  def ha
    return 'ha'
  end 
  def euros
    return '€'
  end 
  def euro
    return '€'
  end
  def euro_ha
    return "€/#{ha}"
  end

  def select_tag_collection(collection, name)
    out ="<select id='#{name}' name='#{name}'>"
    
    out ="</select>"
    
  end  
    
  def draw_table_with_find(headers, elements, controller, action, search_params)
    head_size = headers.count
    link_size = 3
    out = ""
    # Action a choix multiple
    # out += form_tag :action => 'index'
    # out += submit_tag :'Action'
    out += '<table class="table_list">'
    
    # CHECKKBOX A SUPPRIMER
    # if elements.first.class.eql?(Pulve)
    #   out += label :facture_id, "facture : "
    #   unless Facture.find_by_saison(:first).nil?
    #     out += select_tag :facture_id, options_for_select(Facture.find_by_saison(:all), params[:facture_id])
    #     out += select_tag(:operator, options_for_select(%w{ + - * / }, params[:operati]))
    #   end
    # end
    
    #Head - TH
    out += '<tr>'

    # CHECKKBOX A SUPPRIMER
    # out += "<td></td>"

    headers.each do |header|
      out += '<td class="list-elt-left"><b>'
      if header[HEADER_TRI] && header[HEADER_TRI] == true
        # on determine le sens de tri ASC ou DESC
        sens = 'ASC'
        if ((search_params[:tri] == header[HEADER_TRI_KEY]) && (search_params[:sens] == 'ASC'))
          sens = 'DESC'
        end
        # ajout du lien (header de colonne)
        out += link_to header[HEADER_VALUE].to_s, { :action => "index",
                                                    :tri => header[HEADER_TRI_KEY].to_s,
                                                    :sens => sens}
      else
        out += header[HEADER_VALUE].to_s 
      end
      out += '</b></td>'
    end
    out += "<td colspan='#{link_size.to_s}'></td>"

    # logger.error "search_params[:selection] #{search_params[:selection]}"
    #Elements
    elements.each do |element|
      # determination de la class du model pour les liens show/edit/delete
      element_class = element.class.to_s.downcase
      if (element_class == "debit" ||
        element_class == "diverse" ||
        element_class == "report"  ||
        element_class == "reportable")
          element_class = "facture"  
      end
      # Premier tr de l'element  
      out += "<tr class='list-row'>"        

      # CHECKKBOX A SUPPRIMER
      # premier td : case a cocher pour action multiple
      # check_val = false
      # unless search_params[:selection].nil? || search_params[:selection].index(element.id.to_s).nil?
      #   check_val = true
      # end
      # out += "<td>"
      # out += check_box_tag "selection[]", element.id, checked = check_val, options = {}
      # out += "</td>"
      
      headers.each do |header|
        value = element.send(header[HEADER_KEY])
        #gestion des cas particuliers star et adu : appel de methode link_to_star(model, id, adu)
        if header[HEADER_KEY].eql?("star")
          out += "<td>"
          out += check_box_tag 'element[star]', "1", element.star?, :onclick => toggle_star(element, controller)
          out += image_tag 'img-info.png', :id => "spinner-#{element.id}", :style => 'display: none'
          out += "</td>"
          # out += "<td>"
          # out += link_to_star(element.class, element.id, false)
          # out += "</td>"
        elsif header[HEADER_KEY].eql?("adu")
          out += "<td>"
          out += check_box_tag 'element[adu]', "1", element.adu?, :onclick => toggle_adu(element, controller)
          out += image_tag 'img-info.png', :id => "spinner-#{element.id}", :style => 'display: none'
          out += "</td>"
        elsif header[HEADER_KEY].eql?("dosage")
          out += "<td class='list-elt-right'>"
          logger.error "id : "+ element.id.to_s + " "+ element.unit.to_s
          out += element.dosage.to_s + ' ' + element.unit
          out += "</td>"
        else  
          #class css du td : align_right ou align_left
          td_class = "list-elt-right"
          if    value.class == String then td_class = "list-elt-left"
          elsif value.class.eql?(Float) then td_class = "list-elt-right"
          elsif value.class.eql?(Fixnum) then td_class = "list-elt-right"
          end
          
          #si value est un float, on le tronque pour l'affichage
          if value.class.eql?(Float) then value = value.display end
          
          out += "<td class='#{td_class}'>"
          out += "#{value} #{header[HEADER_UNIT]}"
          out += '</td>'
        end
      end
      
      #Liens
      out += '<td>'+ link_to_show(element_class, element.id) +'</td>'
      out += '<td>'+ link_to_edit(element_class, element.id) +'</td>'
      out += '<td>'+ link_to_delete(element_class, element.id) +'</td>'
      out += '</tr>'    
    end
    out += '</table>'
  end  
  
  def draw_table_with_find_js(headers, elements, controller, *args)
    options = args.extract_options!
    sort = "" 
    out = ""
    sort = ":#{options[:sort]}" unless options[:sort].nil?
    head_size = headers.count
    link_size = 3

    out += 
"<table class='table_list table-stripeclass:even table-autosort#{sort}'>
<thead>
"
    #Head - 1
    out += "
    <tr class=bold>
    "        
    headers.each do |header|
      num_type = header[HEADER_VALUE].to_s
      if header[HEADER_TRI].eql?(true)
        out += "<th class='list-elt-left table-sortable:#{header[HEADER_TYPE].to_s} table-sortable'>#{header[HEADER_VALUE].to_s}</th>"
      else
        out += "<th class='list-elt-left'>#{header[HEADER_VALUE].to_s}</th>"        
      end
    end
    out += "<th colspan='#{link_size.to_s}'></th>"
    out += "</tr>
  	"        
    
    if options[:search].eql?(true)
      #Head - 2
      out += "
      <tr class=bold>
      "        
      headers.each do |header|
        if header[HEADER_FILTER].eql?(true)
          out += "<th><input name='filter' size='1' onkeyup='Table.filter(this,this)'></th>"
        else
          out += "<th></th>"
        end
      end
      out += "<th colspan='#{link_size.to_s}'></th>"
      out += "</tr>
    	"        
      out += "
      </thead>
    	"
    end
    
    #Elements
    out += "
  	<tbody>
  	"
    alt = 0
    elements.each do |element|
      alt += 1
      # Premier tr de l'element  
      out += "<tr class='list-row'>
      "        
      
      headers.each do |header|
        value = element.send(header[HEADER_KEY])
        #gestion des cas particuliers star et adu : appel de methode link_to_star(model, id, adu)
        if header[HEADER_KEY].eql?("star")
          out += "<td>"
          out += check_box_tag 'element[star]', "1", element.star?, :onclick => toggle_star(element, controller)
          out += image_tag 'img-info.png', :id => "spinner-#{element.id}", :style => 'display: none'
          out += "</td>
          "
        elsif header[HEADER_KEY].eql?("adu")
          out += "<td>"
          out += check_box_tag 'element[adu]', "1", element.adu?, :onclick => toggle_adu(element, controller)
          out += image_tag 'img-info.png', :id => "spinner-#{element.id}", :style => 'display: none'
          out += "</td>"
        elsif header[HEADER_KEY].eql?("dosage")
          out += "<td class='list-elt-right'>"
          out += element.dosage.to_s + ' ' + element.unit
          out += "</td>"
        else  
          #class css du td : align_right ou align_left
          td_class = "list-elt-right"
          if    value.class == String then td_class = "list-elt-left"
          elsif value.class.eql?(Float) then td_class = "list-elt-right"
          elsif value.class.eql?(Fixnum) then td_class = "list-elt-right"
          end
          
          #si value est un float, on le tronque pour l'affichage
          if value.class.eql?(Float) then value = value.display end
          
          out += "<td class='#{td_class}'>"
          out += "#{value} #{header[HEADER_UNIT]}"
          out += "</td>
          "
        end
      end
      
      #Liens
      out += '<td>'+ link_to_show(controller.singularize, element.id) +'</td>'
      out += '<td>'+ link_to_edit(controller.singularize, element.id) +'</td>'
      out += '<td>'+ link_to_delete(controller.singularize, element.id) +'</td>'
      out += '</tr>'    
    end

    out += "
      <tbody>
  	</table>
  	"
  end  
  
  def draw_table(headers, elements, print_stars=false)

    out = ''
    head_size = headers.count
    link_size = 3  # 3 liens: add, show, delete  
    out += '<table class="table_list">'
    #Head
    out += '<tr>'
    headers.each do |key, value|
      out += "<td class='list-elt-left'><b>"+ value.to_s.capitalize + "</b></td>"    
    end
    # 3 liens: add, show, delete 
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
          
          #si value est un float, on le tronque pour l'affichage
          if value.class.eql?(Float) then value = value.display end
          
          #si unit est un string alors on l'affiche tel quel. si c'est un :sym, il faut appeler la methode de l'objet.
          if header[HEADER_UNIT].class.eql?(String)
            unit = header[HEADER_UNIT]
          elsif header[HEADER_UNIT].class.eql?(Symbol)
            unit = element.send(header[HEADER_UNIT])
          else
            unit = ''
          end
          
          # Affichage 'value' et 'unit'
          out += "<td class='#{td_class}'>"
          out += "#{value} #{unit}"
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


  def link_to_show(modele, object)
    url = "#{modele.to_s.downcase}_path"
    return (link_to image_tag('img-voir.png'), send(url, object), :class => "link_yellow")
  end
  
  def get_img_show
    image_tag('img-voir.png')
  end
  
  def link_to_edit(modele, object)
    url = "edit_#{modele.to_s.downcase}_path"
    return (link_to image_tag('img-modif.png'), send(url, object), :class => "link_yellow")
  end

  def get_img_edit
    image_tag('img-modif.png')
  end
  
  def link_to_delete(modele, id)
    url = modele.to_s.downcase.pluralize + '/' + id.to_s
    return (link_to image_tag('img-delete.png'), url, :confirm => 'Are you sure?', :method => :delete, :class => "link_yellow")
  end
  	
  def get_img_delete
    image_tag('img-delete.png')
  end
  def tr_text(key, value, unit=nil)
    out = ''
    out += '<tr><td class="label">'
    out += key.to_s
    out += '</td>'
    out += '<td class="field">'
    out += value.to_s
    if unit
      out += ' ' + unit.to_s
    end
    out += '</td></tr>'
    return out
  end

  def form_tr_text(form, name, col, options=nil)
    disable = false
    value = ''
    size = 25
    unit = ''
    if options
      disable = 'disabled' if options[:disable]
      size = options[:size] if options[:size]
      value = options[:value].to_s if options[:value]
      unit = ' ' + options[:unit].to_s  if options[:unit]
    end
    out = ''
    out += '<tr><td class="label">'
    out += form.label col, name
    out += ' : </td>'
    out += '<td class="field">'
    if options && options[:value]
      out += form.text_field col.to_sym, :value => value, :size => size, :class => "text_field", :disabled => disable
    else 
      out += form.text_field col.to_sym, :size => size, :class => "text_field", :disabled => disable
    end
    out += unit
    out += '</td></tr>'
    return out
  end

  def tr_text_new(name, col, options=nil)
    value = ''
    size = 25
    unit = ''
    if options
      size = options[:size] if options[:size]
      value = options[:value].to_s if options[:value]
      unit = ' ' + options[:unit].to_s  if options[:unit]
    end
    out = ''
    out += '<tr><td class="label">'
    out += label col, name
    out += ' : </td>'
    out += '<td class="field">'
    if options && options[:value]
      out += text_field col.to_sym, :value => value, :size => size, :class => "text_field", :disabled => 'disabled'
    else 
      out += text_field col.to_sym, :size => size, :class => "text_field", :disabled => 'disabled'
    end
    out += unit
    out += '</td></tr>'
    return out
  end

  def form_tr_text_area(form, name, col, options=nil)
    out = ''
    out += '<tr><td class="label">'
    unless name.blank?
      out += form.label col, name
    end
    out += '</td>'
    out += '<td class="field">'
    if options
      out += form.text_area col, :size => options[:size], :class => "text_field"
    else
      out += form.text_area col, :class => "text_field"
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
    out += '<tr><td class="label">'
    out += form.label col.to_sym, name
    out += ' : </td>'
    out += '<td class="field">'
    out += form.date_select(col.to_sym, :start_year => 2008, :order => [:day, :month, :year]) 
    out += '</td></tr>'
    return out
  end
  
  def form_tr_simple_select(form, name, col, collection)
    out = ''
    out += '<tr><td class="label">'
    out += form.label col.to_sym, name
    out += ' : </td>'
    out += '<td class="field">'
    out += form.select(col, collection) 
    out += '</td></tr>'
    return out
  end

  def form_tr_select(form, name, col, collection, id, display, options = nil)
    out = ''
    out += '<tr><td class="label">'
    out += form.label col.to_sym, name
    out += ' : </td>'
    out += '<td class="field">'
    unless options.nil?
      out += form.collection_select(col, collection, id, display, :selected => options[:selected]) 
    else
      out += form.collection_select(col, collection, id, display) 
    end
    out += '</td></tr>'
    return out
  end

  def form_tr_select_with_groups(form, name, col, collection, id, object, options = nil)
    out = ""
    out << "<tr><td class='label'>"
    out += form.label col.to_sym, name
    out += " : </td>"
    out += "<td class='field'>"
    nom = ''
    nom = object.class.to_s.downcase
    nom += '['
    nom += col.to_s
    nom += ']'

    out += "<select	id=#{object.class.to_s.downcase}_#{col} name='#{nom}'>"
    collection.each do |group|
      out += "<optgroup label=#{group.type_name}>"
      group.options.each do |cat|
        selected = ''
        if (object && object.category_id && (cat.id == object.category_id))
          selected = 'selected="selected"'
        end
        out += "<option value='#{cat.id}'"
        out += selected
        out += ">#{cat.name}</option>"
      end
      out += "</optgroup>"
    end

    out += "</select>"
    out += '</td></tr>'
    return out
  end

  def form_tr_check(form, name, col)
    out = ''
    out += '<tr><td class="label">'
    out += form.label col, name
    out += ' : </td>'
    out += '<td class="field">'
    out += form.check_box col 
    out += '</td></tr>'
    return out
  end

  def form_tr_check_tag(name, col)
    out = ''
    out += '<tr><td class="label">'
    out += "<label for=#{col}>#{name}</label>"
    #out += label col, name
    # probleme: label_for=Type_culture_1_ble
    out += ' : </td>'
    out += '<td class="field">'
    # difference avec input_id=Type_culture_1
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
    session[:admin]
  end

  def edit_access?
    session[:edit_access]
  end

  def root?
    session[:root] == (true)
  end
  
  def logged_in?
    return session[:user_id]
  end

  # def update_saison() 
  #   remote_function(:url => { :controller => "settings", :action => "update_saison" },
  #                   :method => :put)
  # end

  def shortstring(text)
    truncate(text, :length => 11, :omission => '..')
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
  # OPTIMIZE : "precision" devrait etre defini par l'utilisateur dans les parametres de l'appli
  # OPTIMIZE : number_with_precision(1111.2345, :precision => 2, :separator => ',', :delimiter => '.')
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
    return "-" if (val.equal?(0))
    return "-" if (val < 0.0)
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
 
 
  # ajoute un espace proportionnel au level devant le nom de la categorie
  def indent_cat_name(depth, name)
    out = "<span style='padding-left: #{depth*15}px;'>#{name}</span>"
    return out
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
