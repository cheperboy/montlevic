module FacturesHelper
  # HEADER_KEY = 0
  # HEADER_VALUE = 1
  # HEADER_UNIT = 2
  # HEADER_FILTER = 3
  # HEADER_TYPE = 4
  # HEADER_TRI = 5
  # HEADER_TRI_KEY = 6
  # HEADER_RED_GREEN = 7
  # HEADER_COLOR = 8
  
  # Somme des cout des Reports d'une facture Reportable
  # la valeur est retournee dans un <TD> avec couleur verte ou rouge
  def sum_reports_cout(reportable_id)
    reportable = Reportable.find(reportable_id)
    if reportable.nil?
      logger.error "ERROR factures_helper.rb sum_reports_cout() Reportable do not exist"
      return '<td>Erreur</td>'
    else
      reports = reportable.reports
      total = 0
      reports.each do |report|
        total += report.cout
      end
    
      if total == reportable.cout
        color = 'green'
      else
        color = 'red'
      end
      out = '<td style="color: ' + color + ';">' + total.to_s + ' €</td>'
      return out
    end
  end
  
  def sum_reports_cout_popup(reportable_id)
    reportable = Reportable.find(reportable_id)
    reports = reportable.reports
    total = 0
    reports.each do |report|
      total += report.cout
    end
    
    if total == reportable.cout
      color = 'green'
    else
      color = 'red'
    end
    out = '<p style="color: ' + color + ';">' + total.to_s + ' €.</p>'
    return out
  end
  
  def link_to_head(col, display)
    link_to_remote  display.to_s,
                    :url => { :action => "list", :order => col.to_s },
                    :update => 'list_facture'

  end

  # utilise dans facture_table
  def set_color(value)
    if value.to_i < 0
      return "red"
    else
      return "black"
    end
  end
  
  def facture_table(headers, elements, controller, action, search_params)
    head_size = headers.count
    link_size = 3
    out = ""
    # Action a choix multiple
    # out += form_tag :action => 'index'
    # out += submit_tag :'Action'
    out += '<table class="table_list">'

    #Head - TH
    out += '<tr>'

    headers.each do |header|
      out += '<td class="list-elt-left"><b>'
      if header[ApplicationHelper::HEADER_TRI] && header[ApplicationHelper::HEADER_TRI] == true
        # on determine le sens de tri ASC ou DESC
        sens = 'ASC'
        if ((search_params[:tri] == header[ApplicationHelper::HEADER_TRI_KEY]) && (search_params[:sens] == 'ASC'))
          sens = 'DESC'
        end
        # creation de l'affichage du lien
        link = "#{header[ApplicationHelper::HEADER_VALUE].to_s}"
        if ((search_params[:tri] == header[ApplicationHelper::HEADER_TRI_KEY]) && (search_params[:sens] == 'ASC'))
          link = link + " ▼"
        elsif ((search_params[:tri] == header[ApplicationHelper::HEADER_TRI_KEY]) && (search_params[:sens] == 'DESC'))
          link = link + " ▲"
        end
        
        # ajout du lien (header de colonne)
        out += link_to link, { :action => "index",
                               :tri => header[ApplicationHelper::HEADER_TRI_KEY].to_s,
                               :sens => sens}
      else
        out += header[ApplicationHelper::HEADER_VALUE].to_s 
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
      
      headers.each do |header|
        value = element.send(header[ApplicationHelper::HEADER_KEY])
        #gestion des cas particuliers star et adu : appel de methode link_to_star(model, id, adu)
        if header[ApplicationHelper::HEADER_KEY].eql?("star")
          out += "<td>"
          out += check_box_tag 'facture[star]', "1", element.star?, :onclick => toggle_star(element)
          out += image_tag 'img-info.png', :id => "spinner-#{element.id}", :style => 'display: none'
          out += "</td>"
        # elsif header[ApplicationHelper::HEADER_KEY].eql?("adu")
        #   out += "<td>"
        #   out += link_to_star(element.class, element.id, true)
        #   out += "</td>"
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
          if header[ApplicationHelper::HEADER_RED_GREEN].eql?(true)
            out += "<span class='#{set_color(value)}'>"
          end
          unless header[ApplicationHelper::HEADER_COLOR].eql?('')
            out += "<span class='#{header[ApplicationHelper::HEADER_COLOR]}'>"
          end
          out += "#{value} #{header[ApplicationHelper::HEADER_UNIT]}"
          unless header[ApplicationHelper::HEADER_COLOR].eql?('')
            out += "</span>"
          end
          if header[ApplicationHelper::HEADER_RED_GREEN].eql?(true)
            out += "</span>"
          end
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
  

end
