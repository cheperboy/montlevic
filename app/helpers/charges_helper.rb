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

  # def OLD_display_adu(id)
  #   star = Facture.find(id).adu
  #   if (star == 1)
  #     return image_tag('star-green.jpg')
  #   else
  #     return image_tag('star-white2.jpg')
  #   end
  # end

end
