module ProduitsHelper

  # calculate_produit_by_cat_for_parcelle _recur _total
  # rempli variable sum avec les cout des produit utilises sur une parcelle
  def calculate_produit_by_cat_for_parcelle
    # init
    sum = Hash.new
    sum[:total] = Hash.new
    sum[:ha] = Hash.new
    sum[:total][:total] = 0
    sum[:ha][:total] = 0
    Category.produits_cats.each do |cat|
  	  cat.subtree.each do |sub_cat|
    	  sum[:ha]["#{sub_cat.code.to_sym}"] = 0
    	  sum[:total]["#{sub_cat.code.to_sym}"] = 0
      end
    end
    # calcul
    Category.produits_cats.each do |cat|
    	sum = calculate_produit_by_cat_for_parcelle_recurs(sum, cat)
    end
    # calcul du total
    sum = calculate_produit_by_cat_for_parcelle_total(sum)
    return sum
  end
  def calculate_produit_by_cat_for_parcelle_recurs(sum, cat)
	  @parcelle.putoparcelles.each do |putoparcelle|
			putoparcelle.pulve.putoproduits.each do |putoproduit|
				if ((putoproduit.produit.category.is_descendant_of?(cat)) || (putoproduit.produit.category.eql?cat))
					sum[:ha]["#{cat.code.to_sym}"] += putoproduit.get_cout_ha_parcelle(@parcelle)
					sum[:total]["#{cat.code.to_sym}"] += putoproduit.get_cout_total_parcelle(@parcelle)
				end
			end
		end
  	if cat.has_children?
  	  cat.children.each do |sub_cat|
        calculate_produit_by_cat_for_parcelle_recurs(sum, sub_cat)
      end
    end
    return sum
  end
  def calculate_produit_by_cat_for_parcelle_total(sum)
    # init
    sum[:total][:total] = 0
    sum[:ha][:total] = 0
	  @parcelle.pulves.each do |pulve|
			pulve.putoproduits.each do |putoproduit|
				sum[:ha][:total] += putoproduit.get_cout_ha_parcelle(@parcelle)
				sum[:total][:total] += putoproduit.get_cout_total_parcelle(@parcelle)
      end
    end
    return sum
  end


end
