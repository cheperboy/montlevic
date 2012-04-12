module ChargesHelper
  def link_to_head(col, display)
    link_to_remote  display.to_s,
                    :url => { :action => "list", :order => col.to_s },
                    :update => 'list_facture'
  end

  def OLD_link_to_star(facture_id, adu)
    if (adu == true)
      link_to_remote  display_adu(facture_id), 
                      :url => { :action => "toggle_adu", :id => facture_id },
                      :update => 'list_facture'

    else  
      link_to_remote  display_star(facture_id), :url => { :action => "toggle_star", :id => facture_id }
    end
  end
  
  def OLD_display_star(id)
    star = Facture.find(id).star
    if (star == 1)
      return image_tag('star-yellow.jpg')
    else
      return image_tag('star-white2.jpg')
    end
  end
  
  def star_ascii(obj, invisible=false )
    if obj.star?
      return('★')
    else
      if invisible
        return('<span class=grey>☆</span>')
      end
    end
  end
  
  def adu_ascii(obj)
    if obj.adu?
      return('⚑')
    else
      return('<span class=grey>⚐</span>')
    end
  end
  
  def select_pulve_units(form, col)
    form.select(col, Application::PULVE_DOSAGE_UNITS)
  end
  
  def select_produit_units(form, col)
    form.select(col, Application::PRODUIT_QUANTITE_UNITS)
  end

  def select_vente_units(form, col)
    form.select(col, Application::VENTE_UNITS)
  end

  #kklass=popup-show-content ou popup-show-content-large
  def popup_show(link, content, kklass)
    if (link.nil? || content.nil?)
      out = "erreur"
    else
      out = '<a href="#" class=popup-show>'+ (link.to_s) + '<span class='+ kklass + '>'+ (content.to_s) +'</span></a>'
    end
    return out
  end

  def pop_content(elt)
    out = ""
    if elt.kind_of?(Facture)
      out += content_tag :span, elt.name.to_s, :class => "pop-title"
      out += "<br><span class=grey>Cout : </span> #{elt.cout.to_s} #{euro}"
      out += "<br><span class=grey>Ref compta : </span> #{elt.ref.to_s}"
      out += "<br><span class=grey>Ref client : </span> #{elt.ref_client.to_s}"
    elsif elt.kind_of?(Labour)
      out += content_tag :span, elt.name.to_s, :class => "pop-title"
      out += "<br><span class=grey>Cout : </span> #{elt.cout.to_s} #{euro}"
      out += "<br><span class=grey>Ref compta : </span> #{elt.ref.to_s}"
      out += "<br><span class=grey>Ref client : </span> #{elt.ref_client.to_s}"
    elsif elt.kind_of?(Pulve)
      out += "
			<table class=table_data>
				<tr>
					<th>Culture</th>
					<th>Parcelle</th>
					<th>Surface</th>
				</tr>"
				elt.putoparcelles.each do |putoparcelle|
        out += "
				<tr>
					<td>#{putoparcelle.parcelle.typeculture.name}</td>
					<td>#{link_to putoparcelle.parcelle.name, parcelle_path(putoparcelle.parcelle)}</td>
					<td>#{putoparcelle.parcelle.surface} #{ha}</td>
				</tr>"
				end
        out += "</table>"
			
    elsif elt.kind_of?(Vente)
      out += content_tag :span, elt.name.to_s, :class => "pop-title"
      out += "<br><span class=grey>Prix : </span> #{elt.prix.to_s} #{euro}"
      out += "<br><span class=grey>Ref compta : </span> #{elt.ref.to_s}"
      out += "<br><span class=grey>Ref client : </span> #{elt.ref_client.to_s}"
    elsif elt.kind_of?(Produit)
      out += content_tag :span, elt.name.to_s, :class => "pop-title"
      out += "<br><span class=grey>Nom : </span> #{elt.name.to_s} #{euro}"
    else
      out+= "NOTHING"
    end
    return (out)
  end
  
end
