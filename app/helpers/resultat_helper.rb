module ResultatHelper

  # pour un type de culture 
  # cout /ha et total des produits utilises par categorie
  # somme pour chaque categorie
  # calculate_produit_by_cat_for_typeculture _recur _total
  def calculate_produit_by_cat_for_typeculture()
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
    	sum = calculate_produit_by_cat_for_typeculture_recurs(sum, cat)
    end

    # calcul du total
    sum = calculate_produit_by_cat_for_typeculture_total(sum)
    return sum
  end
  def calculate_produit_by_cat_for_typeculture_recurs(sum, cat)
    Produit.find_by_saison(:all).each do |produit|
  		if ((produit.category.is_descendant_of?(cat)) || (produit.category.eql?cat))
  			sum[:ha]["#{cat.code.to_sym}"] += produit.get_cout_ha_typeculture(@typeculture)
  			sum[:total]["#{cat.code.to_sym}"] += produit.get_cout_total_typeculture(@typeculture)
  	  end
	  end
  	if cat.has_children?
  	  cat.children.each do |sub_cat|
        calculate_produit_by_cat_for_typeculture_recurs(sum, sub_cat)
      end
    end
    return sum
  end
  def calculate_produit_by_cat_for_typeculture_total(sum)
    # init
    sum[:total][:total] = 0
    sum[:ha][:total] = 0
    # calcul
    Produit.find_by_saison(:all).each do |produit|
			sum[:ha][:total] += produit.get_cout_ha_typeculture(@typeculture)
			sum[:total][:total] += produit.get_cout_total_typeculture(@typeculture)
	  end
    return sum
  end

  # pour un type de culture
  # facture, ventes par categories,
  # somme /ha et total pour chaque elelment et chaque categorie
  def calculate_marge_by_cat_for_typeculture(typeculture)
    # init
    cat_factures_codes = ['travaux_culture', 'frais_cultures']
    cat_ventes_codes = ['vente_production', 'vente_paille', 'vente_primes']

    sum                         = Hash.new
    sum[:total]                 = Hash.new
    sum[:total][:resultat]         = 0
    sum[:total][:factures]      = 0
    sum[:total][:ventes]        = 0
    sum[:ha]                    = Hash.new
    sum[:ha][:resultat]            = 0
    sum[:ha][:factures]         = 0
    sum[:ha][:ventes]           = 0
    sum[:factures]              = Hash.new
    sum[:factures][:ha]         = Hash.new
    sum[:factures][:total]      = Hash.new
    sum[:factures][:cats]       = []
    sum[:factures][:elts]       = Hash.new
    sum[:factures][:elts][:all] = []
    sum[:ventes]                = Hash.new
    sum[:ventes][:ha]           = Hash.new
    sum[:ventes][:total]        = Hash.new
    sum[:ventes][:cats]         = []
    sum[:ventes][:elts]         = Hash.new
    sum[:ventes][:elts][:all]   = []
    factures                    = []
    ventes                      = []

    cat_factures_codes.each { |code| sum[:factures][:cats] << Category.find_by_code(code) }
    cat_ventes_codes.each { |code| sum[:ventes][:cats] << Category.find_by_code(code) }

    # init factures
    cat_factures_codes.each do |code|
      category = Category.find_by_code(code)
      category.subtree.each do |cat|
        sum[:factures][:ha]["#{cat.code.to_sym}"] = 0
        sum[:factures][:total]["#{cat.code.to_sym}"] = 0
        sum[:factures][:elts]["#{cat.code.to_sym}"] = []
        cat.factures.find_by_saison(:all).each do |facture|
          sum[:factures][:elts]["#{cat.code.to_sym}"] << facture.id
          # sum[:factures][:ids] << facture.id
          factures << facture
        end
      end
    end
    # init ventes
    cat_ventes_codes.each do |code|
      category = Category.find_by_code(code)
      category.subtree.each do |cat|
        sum[:ventes][:ha]["#{cat.code.to_sym}"] = 0
        sum[:ventes][:total]["#{cat.code.to_sym}"] = 0
        sum[:ventes][:elts]["#{cat.code.to_sym}"] = []
        cat.ventes.find_by_saison(:all).each do |vente|
          sum[:ventes][:elts]["#{cat.code.to_sym}"] << vente.id
          ventes << vente
        end
      end
    end

    # calcul factures
    factures.each do |facture|
      ha = facture.get_cout_ha_col(typeculture)
      total = facture.get_cout_total_col(typeculture)
      # facture
      sum[:factures][:elts][:all][facture.id] = Hash.new
      sum[:factures][:elts][:all][facture.id][:ha] = ha
      sum[:factures][:elts][:all][facture.id][:total] = total
      sum[:factures][:elts][:all][facture.id][:name] = facture.name
      # total factures
      sum[:ha][:factures] += ha
      sum[:total][:factures] += total
      # total resultat
      sum[:ha][:resultat] -= ha
      sum[:total][:resultat] -= total
      # categories
      cat = facture.category
      while (cat.depth > 1)
        sum[:factures][:ha]["#{cat.code.to_sym}"] += ha
        sum[:factures][:total]["#{cat.code.to_sym}"] += total
        cat = cat.parent
      end      
    end

    # calcul ventes
    ventes.each do |vente|
      puts "#{vente.category.name} - #{vente.name}"
      ha = vente.get_cout_ha_col(typeculture)
      total = vente.get_cout_total_col(typeculture)
      # vente
      sum[:ventes][:elts][:all][vente.id] = Hash.new
      sum[:ventes][:elts][:all][vente.id][:ha] = ha
      sum[:ventes][:elts][:all][vente.id][:total] = total
      sum[:ventes][:elts][:all][vente.id][:name] = vente.name
      # total ventes
      sum[:ha][:ventes] += ha
      sum[:total][:ventes] += total
      # total resultat
      sum[:ha][:resultat] += ha
      sum[:total][:resultat] += total
      # categories
      cat = vente.category
      while (cat.depth > 1)
        sum[:ventes][:ha]["#{cat.code.to_sym}"] += ha
        sum[:ventes][:total]["#{cat.code.to_sym}"] += total
        cat = cat.parent
      end      
    end

    return sum
  end

end # module ResultatHelper