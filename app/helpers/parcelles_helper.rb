module ParcellesHelper
  
  def percent_of_zone(parcelle, zone_id)
    zone = Zone.find(zone_id)
    zonetopa = Zonetopa.find_by(zone_id, parcelle.id)
    if zonetopa.nil?
      value = 0
    else
      value = zonetopa.value
    end
    percent = value * 100 / parcelle.surface
    if percent == 100
      color = 'green'
    else
      color = 'red'
    end
    out = '<td style="color: ' + color + ';">' + percent.display(2) + ' %</td>'
    return out
  end
  
  def parcelle_print_produit(cat, produit, parcelle)
    out = ""
    sum_produit = 0
    print = false
    # cat.produits.find_by_saison.each do |produit|
    #   produit.putoproduits.each do |putoproduit|
    #     if putoproduit.parcelle.eql?(parcelle)
    
    parcelle.putoparcelles.each do |putoparcelle|
      putoparcelle.pulve.putoproduits.each do |putoproduit|
        print = false
        if putoproduit.produit.category.eql?(cat)
          print = true
          sum_produit += putoproduit.get_cout_ha
        end
      end
    end
    if print.eql?(true)
      out << "<td>" << "#{produit.name}" << "</td>"
      out << "<td>" << "#{sum_produit}" << "</td>"
    end
    return out
  end
    # parcelle.putoparcelles.each do |putoparcelle|
    #   putoparcelle.pulve.putoproduits.each do |putoproduit|
    #         if putoproduit.produit.category.eql?(cat)
    #           sum_produit += putoproduit.get_cout_ha
    #         end
      

end
