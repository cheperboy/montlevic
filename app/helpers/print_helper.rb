module PrintHelper

  def csv_html
    return(self.csv_html)  
  end
  
  #colspan a appliquer aux en-tete de colonnes 
  def print_colspan(show_cout_ha, show_cout_total)
    if show_cout_ha && show_cout_total
      return 'colspan=2'
    elsif ((show_cout_ha && !show_cout_total) || (!show_cout_ha && show_cout_total))
      return ''
    else
      return ''
    end  
  end
  
  def td_number(col_length, show_cout_ha, show_cout_total)
    if show_cout_ha && show_cout_total
      num = 2
    elsif ((show_cout_ha && !show_cout_total) || (!show_cout_ha && show_cout_total))
      num = 1
    else
      num = 0
    end  
    return (col_length * num + 5)
  end
  
  def td_number_after_saison(col_length, show_cout_ha, show_cout_total)
    if show_cout_ha && show_cout_total
      num = 2
    elsif ((show_cout_ha && !show_cout_total) || (!show_cout_ha && show_cout_total))
      num = 1
    else
      num = 0
    end  
    return (col_length * num)
  end
  
  # nombre de <td> avant la colonne "saison"
  def td_number_before_saison
    return 3
  end

  # obsolete, utile pour l'ancienne vue Print, A SUPPRIMER
  def type_first_letter(facture)
    return 'n' if facture.class.equal?(Reportable)
    return 'r' if facture.class.equal?(Report)
    return 'f' if facture.class.equal?(Debit)
    return 'd' if facture.class.equal?(Diverse)
  end
  
  # <table class=table_data>
  #   <tr class=table_data>
  #     <td><b>Pulve</b></td>
  #     <td><b>date</b></td>
  #     <td><b>cout</b></td>
  #     <td><b>contribution</b></td>
  #   </tr>
  #     <tr>
  #       <td class=right>=h putofacture.pulve.print_date </td>
  #       <td class=right>=h putofacture.pulve.get_cout_total.display </td>
  #       <td class=right>=h putofacture.value.display </td>
  #     </tr>
  #   <tr>
  
    
  #affiche les infos de la facture dans un popup
  def link_popup_facture(dep)
    if dep.is_a?(Integer)
      facture = Facture.find(dep)
    else
      facture = Facture.find(dep[:id])
    end
    #affichage tableau
    out = '
    <a href=" '+ facture_path(facture) +'" class="tip">'+ facture.name 

    #affichage popup
    out += '
    <span>      
    <fieldset class="popup">
    <legend class="popup"><b>'+ facture.name + '</b></legend>'

    #REPORT
    if facture.class.equal?(Report)
      out += '<p>Report de la facture: <b>' + facture.reportable.name + '</b></p>'
    end
    if facture.class.equal?(Reportable)
      out += '<p>Facture Reportable</p>'
    end

    #Description
    out += '
    <table class="table_data">
    ' + tr_text("Id", facture.id) + '
    ' + tr_text("Categorie", facture.category.name) + '
    ' + tr_text("Prestataire", facture.user.name) + '
    ' + tr_text("Surface", facture.sum_surfaces.display, 'Ha') + '
    ' + tr_text("Cout", facture.get_cout_total_sans_reduc.display, '€')
    if facture.charges? || facture.class.equal?(Reportable)
      out += '
      ' + tr_text("Cout Comptable", facture.get_cout_total.display, euro)
    end
    out += tr_text("Desc", facture.desc) + '
    </table> '

    #TOUS LES TYPE DE FACTURES
    unless facture.parcelles.empty?
      out += '<br><b>'+facture.parcelles.length.to_s+' parcelles : </b>'
      out += '
      <table class="table_data">
        <tr>
          <td>Culture</td>
          <td>Nom</td>
          <td>Ha</td>
        </tr>'
      for parcelle in facture.parcelles.find(:all, :order => :typeculture_id)
        out += '<tr>'
          out += '<td>' + parcelle.typeculture.name + '</td>'
          out += '<td>' + parcelle.name + '</td>'
          out += '<td>' + parcelle.surface.display(0) + '</td>'
        out += '</tr>'
      end
      out += '</table>'
    end
    
    #REPORTABLE : Reports Associees
    if facture.class.equal?(Reportable)
      if facture.reports.count > 0
        out += '<br><b>'+facture.reports.length.to_s+' Reports : </b>'
        out += '<table class="table_data">'
        for report in facture.reports
          out += '<tr>'
          out += '<td>' + report.name + '</td>'
          out += '<td>' + report.cout.to_s + ' ' + euro + '</td>'
          out += '</tr>'
        end
        out += '<tr><td>Total Reports</td>'
        out += sum_reports_cout(facture.id)
        out += '</tr>'
        out += '</table>'
      end
    end

    #DEBIT : Charges Associees (Labours et Pulves)
    if facture.labours.count > 0
      out += '<p><b>Labours</b></p>'
      out += '<table class=table_data>
      	<tr class=bold>
      	    <td class=left><b>Labour</b></td>
      	    <td><b>cout</b></td>
      	</tr>'
      facture.labtofactures.each do |labtofacture|
      out += '
            <tr>
      		    <td class=left>' + link_to(labtofacture.labour.name, labour_path(labtofacture.labour)) + '</td>
      		    <td>' + labtofacture.value.display + '</td>
      		  </tr>'
      end
      out += '
          <tr>
      	    <td class=bold>Somme :</td>
      	    <td class=bold>' + facture.sum_labours.display + '</td>
      	  </tr>
      </table>'
    end

    if facture.pulves.count > 0
      out += '<p><b>Pulves</b></p>'
      out += '<table class=table_data>
      	<tr class=bold>
      	    <td class=left><b>Pulve</b></td>
      	    <td><b>cout</b></td>
      	</tr>'
      facture.putofactures.each do |putofacture|
      out += '
            <tr>
      		    <td class=left>' + link_to(putofacture.pulve.name, pulve_path(putofacture.pulve)) + '</td>
      		    <td>' + putofacture.value.display + '</td>
      		  </tr>'
      end
      out += '
          <tr>
      	    <td class=bold>Somme :</td>
      	    <td class=bold>' + facture.sum_pulves.display + '</td>
      	  </tr>
      </table>'
    end

    # COMPTABILISATION
    if facture.comptable_diff?  
      out += "<br><b>Comptabilisation : diff</b>
  	  <table class=table_data>
  		  <tr>
  		    <td>Cout facture</td>
  		    <td><b></b></td>
  		    <td><b>#{facture.cout.display()}</b></td>
  		  </tr>"
      if facture.sum_pulves > 0  
        out += "<tr>
                <td>Pulves : </td>
          		    <td><b>-</b></td>
          		    <td><b#{facture.sum_pulves.display()}</b></td>
      		      </tr>"
      end
  		if facture.sum_labours > 0  
  		  out += "<tr>
  		    <td>Labours : </td>
  		    <td><b>-</b></td>
  		    <td><b>#{facture.sum_labours.display()}</b></td>
  		  </tr>"
  		end
      if facture.sum_produits_assoc > 0  
         out += "<tr>
  		    <td>Produits Consommés : </td>
  		    <td><b>-</b></td>
  		    <td><b>#{facture.sum_produits_used.display()}</b></td>
  		  </tr>"
  		end
      out += "<tr>
  		    <td>Valeur comptable de la facture : </td>
  		    <td><b>=</b></td>
  		    <td><b>#{(facture.cout - facture.sum_charges).display()}</b></td>
  		  </tr>
  	</table>"
    elsif facture.comptable_null?  
      out += "<br><b>Comptabilisation : nulle</b>"
    elsif facture.comptable_total?  
  	  out += "<br><b>Comptabilisation : total</b>"
    end

    out += '    
    </fieldset>
    </span>
    </a>'
    return out
  end
  
  def link_popup_labour(labour_id)
    if labour_id.is_a?(Integer)
      labour = Labour.find(labour_id)
    else
      labour = Labour.find(labour_id[:id])
    end
    #affichage tableau
    out = '
    <a href=" '+ labour_path(labour) +'" class="tip">'+ labour.name 

    #affichage popup
    out += '
    <span>        
    <fieldset class="popup">
    <legend class="popup"><b>Labour :: '+ labour.name + '</b></legend>'

    out += '
    <table class="table_popup">
    ' + tr_text("Id", labour.id) + '
    ' + tr_text("Categorie", labour.category.name) + '
    ' + tr_text("Cout Ha", labour.get_cout_ha, '€/Ha') + '
    ' + tr_text("Surface", labour.sum_surfaces, 'Ha') + '
    ' + tr_text("Cout", labour.get_cout_total, '€') +'
    </table> '

    if labour.factures_assoc?
      out += '<br><b>'+labour.factures.length.to_s+' Factures : </b><ul>'
      for labtofacture in labour.labtofactures
        out += '<li>'+  labtofacture.facture.name + ' (' + 
        labtofacture.value.to_s + '/' + 
        labtofacture.facture.cout.to_s + ')</li>'
      end
      out += '</ul>'
    else
      out += '<br>Pas de factures associee.<br>'
    end

    #nombre et enumeration des parcelles du labour
    out += '<br><b>'+labour.parcelles.length.to_s+' parcelles : </b><ul>'
    for parcelle in labour.parcelles
      out += '<li>'+parcelle.name + ' (' + parcelle.surface.to_s + 'ha)</li>'
    end
    out += '</ul>'
    out += '
    </fieldset>
    </span>
    </a>'
    return out
  end

  def link_popup_pulve_desc(name, pulve)
    out = '
    <a href="'+ pulve_path(pulve) +'" class="popup_desc"><img src="/images/img-voir.png" border="0"><span>
    '+ pulve.desc + '
    </span>
    </a> '
    return out
  end
  
  def link_popup_pulve_desc_bis(name, pulve)
    out = '
    <a href="'+ pulve_path(pulve) +'"><img src="img-voir.png" border="0" class="popup_desc"><span>
    '+ pulve.desc + '
    </span>
    </a> 

    <a href=" '+ pulve_path(pulve) +'" class="popup_desc">'+ name + '
    <span>
    '+ pulve.desc + '
    </span>
    </a>'
    return out
  end
  
  def link_popup_pulve(data)
    pulve = Pulve.find(data[:id])
    #affichage tableau
    out = '<a href=" '+ pulve_path(pulve) +'" class="tip">'+ pulve.name 

    #affichage popup
    out += '
    <span>        
    <fieldset class = "popup">
    <legend class = "popup"><b>Pulve :: '+ pulve.name + '</b></legend>'

    out += '
    <table class = "table_popup">
    ' + tr_text("Id", data[:id]) + '
    ' + tr_text("Nom", data[:name]) + '
    ' + tr_text("Date", data[:date]) + '
    ' + tr_text("Surface", data[:sum_surfaces], 'Ha') + '
    ' + tr_text("Cout Ha", data[:cout_ha_passage], '€/Ha') + '
    ' + tr_text("Cout Total", data[:cout_total_passage], '€') +'
    </table> '

    if pulve.produit_assoc?
      out += '<br><b>'+pulve.putoproduits.length.to_s+' Produits : </b><ul>'
      for putoproduit in pulve.putoproduits
        out += '<li>'+  putoproduit.produit.name + ' (' + 
        putoproduit.dosage.display + ' L/Ha' + 
        putoproduit.produit.get_prix_unitaire.display + ' €/L)</li>'
      end
      out += '</ul>'
    else
      out += '<br>Pas de produits.<br>'
    end

    #nombre et enumeration des parcelles du pulve
    out += '<b>'+pulve.parcelles.length.to_s+' parcelles : </b><ul>'
    for parcelle in pulve.parcelles
      out += '<li>'+parcelle.name + ' (' + parcelle.surface.to_s + 'ha)</li>'
    end
    out += '</ul>'

    if pulve.factures_assoc?
      out += '<br><b>'+pulve.factures.length.to_s+' Factures : </b><ul>'
      for putofactures in pulve.putofactures
        out += '<li>'+  putofactures.facture.name + ' (' + 
        putofactures.value.to_s + '/' + 
        putofactures.facture.cout.to_s + ')</li>'
      end
      out += '</ul>'
    end

    out += '
    </fieldset>
    </span>
    </a>'
    return out
  end
  
  def link_popup_putoproduit(data)
    if data.is_a?(Integer)
      putoproduit = Putoproduit.find(data)
    else
      putoproduit = Putoproduit.find(data[:id])
    end
    #affichage tableau
    out = '<a href=" '+ pulve_path(putoproduit.pulve) +'" class="tip">'+ putoproduit.pulve.name + ' - ' + putoproduit.produit.name 

    #affichage popup
    out += '
    <span>        
    <fieldset class    = "popup">
    <legend class    = "popup"><b>Produit :: '+ putoproduit.produit.name + '</b></legend>'

    out += '
    <table class = "table_popup">
    ' + tr_text("Id", data[:id]) + '
    ' + tr_text("Date passage", data[:date]) + '
    ' + tr_text("Categorie", data[:category_name]) + '
    ' + tr_text("Surface", data[:sum_surfaces], 'Ha') + '
    ' + tr_text("Cout Ha", data[:cout_ha], '€/Ha') + '
    ' + tr_text("Cout Total", data[:cout_total], '€') +'
    ' + tr_text("Dosage", putoproduit.dosage, 'L/Ha') +'
    ' + tr_text("Pix littre", putoproduit.produit.get_prix_unitaire, '€/L') +'
    </table> '

    #nombre et enumeration des parcelles du labour
    out += '<br><b>'+ putoproduit.pulve.parcelles.length.to_s+' parcelles : </b><ul>'
    for parcelle in putoproduit.pulve.parcelles
      out += '<li>'+ parcelle.name + ' (' + parcelle.surface.to_s + 'ha)</li>'
    end
    out += '</ul>'
    out += '
    </fieldset>
    </span>
    </a>'
    return out
  end
  
  def link_popup_vente(dep)
    if dep.is_a?(Integer)
      vente = Vente.find(dep)
    else
      vente = Vente.find(dep[:id])
    end
    #affichage tableau
    out = '<a href=" '+ edit_vente_path(vente) +'" class="tip">'+ vente.name 

    #affichage popup
    out += '<span>id : '+ vente.id.to_s
    out += '<br>nom : '+ vente.name 
    out += '<br>categorie : '+ vente.category.name 

    #nombre et enumeration des parcelle de la vente
    out += '<br>'+vente.parcelles.length.to_s+' parcelles : <ul>'
    for parcelle in vente.parcelles
      out += '<li>'+parcelle.name+'</li>'
    end
    out += '</ul>'

    out += '</span></a>'
    return out
  end
  
  def print_popup(screen, popup)
    link = "#"
    if (screen.nil? || popup.nil?)
      out = "erreur"
    else
      out = '<a href="#" class="tip">'+ (screen.to_s) + '<span>'+ (popup.to_s) +'</span></a>'
    end
    return out
  end

end