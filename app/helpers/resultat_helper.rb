module ResultatHelper
    
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
  
  
end