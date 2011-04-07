module PrintHelper

  def csv_html
    return(self.csv_html)  
  end
  
  def type_first_letter(facture)
    return 'n' if facture.class.equal?(Reportable)
    return 'r' if facture.class.equal?(Report)
    return 'f' if facture.class.equal?(Debit)
    return 'd' if facture.class.equal?(Diverse)
  end
  
  
  #affiche les infos de la facture dans un popup
  def link_popup_facture(dep)
    if dep.nil?
      out = "erreur"
    else
      facture = Facture.find(dep[:id])
  #affichage tableau
      out = '
<a href=" '+ edit_facture_path(facture) +'" class="tip">'+ facture.name 

  #affichage popup
      out += '
  <span>        
    <fieldset class="popup">
      <legend class="popup"><b>Facture :: '+ facture.name + '</b></legend>'

      #Description
      out += '
          <table class="table_popup">
            ' + tr_text("Id", facture.id) + '
            ' + tr_text("Categorie", facture.category.name) + '
            ' + tr_text("Surface", facture.sum_surfaces, 'Ha') + '
            ' + tr_text("Cout", facture.get_cout_total_sans_reduc, '€')
      if facture.charges? || facture.class.equal?(Reportable)
        out += '
            ' + tr_text("Cout Comptable", facture.get_cout_total, euros + '/Ha')
      end
      out += '
          </table> '

      #TOUT
      out += '<br><b>'+facture.parcelles.length.to_s+' parcelles : </b><ul>'
      for parcelle in facture.parcelles
        out += '<li>'+parcelle.name + ' (' + parcelle.surface.to_s + 'ha)</li>'
      end
      out += '</ul>'

      #REPORTABLE : Reports Associees
      if facture.class.equal?(Reportable)
        if facture.reports.count > 0
          out += '<br><b>'+facture.reports.length.to_s+' Reports : </b>'
          out += '<table class="table_popup">'
          for report in facture.reports
            out += '<tr>'
            out += '<td>' + report.name + ' | </td>'
            out += '<td>' + report.cout.to_s + ' € |</td>'
            out += '</tr>'
          end
          out += '<tr><td>Total Reports | </td>'
          out += sum_reports_cout(facture.id)
          out += '</tr>'
          out += '</table>'
        else
          out += '<br>Pas de reports associes.<br>'
        end
      end

      #REPORT
      if facture.class.equal?(Report)
        out += '<p><b>Reportable ' + facture.reportable.name + '</b></p>'
        out += '<p>Cout : ' + facture.cout.to_s + '/' + facture.reportable.cout.to_s + euros + '</p>'
      end

      #DEBIT : Charges Associees (Labours et Pulves)
      if facture.labours.count > 0
        out += '<br><b>'+facture.labours.length.to_s+' Labours : </b><ul>'
        for labtofacture in facture.labtofactures
          out += '<li>'+  labtofacture.labour.name + ' (' + 
                          labtofacture.value.to_s + '/' + 
                          labtofacture.labour.get_cout_total.to_s + ')</li>'
        end
        out += '</ul>'
      else
        out += '<br>Pas de labours associes.<br>'
      end
      if facture.pulves.count > 0
        out += '<br><b>'+facture.pulves.length.to_s+' Pulves : </b><ul>'
        for putofacture in facture.putofactures
          out += '<li>'+  putofacture.pulve.name + ' (' + 
                          putofacture.value.to_s + '€/' + 
                          putofacture.pulve.get_cout_total.to_s + '€)</li>'
        end
        out += '</ul>'
      else
        out += '<br>Pas de pulves associes.<br>'
      end

      out += '<p>' + facture.desc + '</p>'    
      out += '    
    </fieldset>
  </span>
</a>'
    end
    return out
  end
  
  def link_popup_labour(dep)
    if dep.nil?
      out = "erreur"
    else
      labour = Labour.find(dep[:id])
  #affichage tableau
      out = '
<a href=" '+ edit_labour_path(labour) +'" class="tip">'+ labour.name 

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
    end
    return out
  end
  
  def link_popup_pulve(dep)
    if dep.nil?
      out = "erreur"
    else
      pulve = Pulve.find(dep[:id])
  #affichage tableau
      out = '<a href=" '+ edit_pulve_path(pulve) +'" class="tip">'+ pulve.name 

  #affichage popup
      out += '
   <span>        
    <fieldset class="popup">
      <legend class="popup"><b>Pulve :: '+ pulve.name + '</b></legend>'

      out += '
          <table class="table_popup">
            ' + tr_text("Id", pulve.id) + '
            ' + tr_text("Categorie", pulve.category.name) + '
            ' + tr_text("Surface", pulve.sum_surfaces, 'Ha') + '
            ' + tr_text("Cout Ha", pulve.get_cout_ha, '€/Ha') + '
            ' + tr_text("Cout Total", pulve.get_cout_total, '€') +'
            ' + tr_text("Dosage", pulve.dosage, 'L/Ha') +'
            ' + tr_text("Pix littre", pulve.prix_littre, '€/L') +'
            ' + tr_text("Cout Passage", pulve.cout_ha_passage, '€/Ha') +'
            ' + tr_text("Cout Fixe", pulve.cout_fixe, '€') +'
          </table> '
          
      if pulve.factures_assoc?
        out += '<br><b>'+pulve.factures.length.to_s+' Factures : </b><ul>'
        for putofactures in pulve.putofactures
          out += '<li>'+  putofactures.facture.name + ' (' + 
                          putofactures.value.to_s + '/' + 
                          putofactures.facture.cout.to_s + ')</li>'
        end
        out += '</ul>'
      else
        out += '<br>Pas de factures associee.<br>'
      end
          
      #nombre et enumeration des parcelles du labour
      out += '<br><b>'+pulve.parcelles.length.to_s+' parcelles : </b><ul>'
      for parcelle in pulve.parcelles
        out += '<li>'+parcelle.name + ' (' + parcelle.surface.to_s + 'ha)</li>'
      end
      out += '</ul>'
      out += '
      </fieldset>
    </span>
  </a>'
    end
    return out
  end
  
  def link_popup_vente(dep)
    if dep.nil?
      out = "erreur"
    else
      vente = Vente.find(dep[:id])
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
    end
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
