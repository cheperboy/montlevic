# OPTIMIZE cout ha pour la colonne saison
# pour optimiser la vitesse de traitement, on peu calculer uniquement les cout totaux puis refaire une boucle 
# (for facture in @factures) pour le calcul du cout ha de saison.
# cf les lignes suivantes en commentaire
# for facture in @factures
#   @res.set_saison_line(@sid, :factures, :all, facture.id, :ha, facture.get_cout_ha_moyen(@surface_of_saison))
# end
# facture_total = @res.get_other_line_for_saison(@sid, :resultats, :total_factures, :total)
# @res.set_other_line_for_saison(@sid, :resultats, :total_factures, :ha, (facture_total/@surface_of_saison))     

class Calculate < ActiveRecord::Base

  PRESTA_LAB_PU = false

  #Txxx variables temporaires
  #Zxxx variables par Zone
  #Pxxx variables par Parcelle
  attr_accessor :res,
                :csv, :csv_html, :display, :info_debug,
                :saison, :labours, :pulves, :factures, :ventes, :types_facture, :col_model, :cols,
                :c, # model de colonne en symbole pluriel :parcelles, :zones, :typecultures
                :sid, #saison_id
                :surface,
                :surface_of_saison

  
  def initialize(col_model)
    unless col_model.find_for_saison().nil?  
      @c = col_model.to_s.downcase.pluralize.to_sym
      @col_model = col_model
      @cols = col_model.find_for_saison()
      @saison = Setting.get_saison
      @sid = @saison.id
      @labours = @saison.labours
      @pulves = @saison.pulves
      @produits = @saison.produits
      @putoproduits = @saison.putoproduits
      @factures = @saison.factures
      @ventes = @saison.ventes
      @types_facture = Category.get_factcats
    else
      return nil
    end
  end
  
  def calculate
    @res = Analytic.new()
    init_cols
    run_labours
    run_produits
    run_pulves
    run_factures
    run_ventes
    run_totaux
    verif
  end

  def init_cols
    unless @cols.nil?
      saison_datas = {}
      saison_datas[:id] = @saison.id
      saison_datas[:name] = @saison.name
      saison_datas[:year] = @saison.year.to_s
      saison_datas[:surface] = 0
      for col in @cols
        # init saison datas
        saison_datas[:surface] += col.surface
        # init col datas
        col_datas = {}
        col_datas[:name] = col.name
        col_datas[:id] = col.id
        case col_model.to_s.downcase
        when "parcelle"
          col_datas[:surface] = col.surface
          col_datas[:typeculture] = col.typeculture.name
        when 'zone', 'typeculture'
          col_datas[:surface] = col.surface
          col_datas[:nombre_parcelles] = "xxx"
          col_datas[:parcelles] = "p1, p2, p3.."
        end
        @res.set_colonne_datas(@sid, @c, col.id, col_datas)
      end
      @res.set_saison_datas(@sid, saison_datas)
      @surface_of_saison = saison_datas[:surface]
    end
  end

  def run_labours
    for labour in @labours
      for col in @cols
        #valeur ha et total pour chaque col affecté au labour
        # set_cell
        @res.set_line(@sid, @c, col.id, :labours, :all, labour.id, :ha, labour.get_cout_ha_col(col))
        @res.set_line(@sid, @c, col.id, :labours, :all, labour.id, :total, labour.get_cout_total_col(col))
      end

      datas = { :id => labour.id, :name => labour.name, :category_id => labour.category_id, :category_name => labour.category.name,
                :ha_passage => labour.cout_ha_passage, :user_id => labour.user_id, :factures_assoc => labour.factures_assoc?,
                :date => labour.date, :parcelles_length => labour.parcelles.length, :surface_total => labour.sum_surfaces }
           
      @res.set_saison_line_datas(@sid, :labours, labour.id, datas)

    # 1- Total SAISON
      # cout total/ha du labour du point de vue saison
      cout_ha_for_saison = labour.get_cout_ha_moyen(@surface_of_saison)
      cout_total = labour.get_cout_total
      
      # total du labour (chaque ligne, colonne "Total Saison")
      @res.set_saison_line(@sid, :labours, :all, labour.id, :ha, cout_ha_for_saison)
      @res.set_saison_line(@sid, :labours, :all, labour.id, :total, cout_total)
      
      #total des labours (Ligne de Somme en rouge "Total Labours", colonne Saison)
      @res.add_other_line_for_saison(@sid, :resultats, :total_labours, :ha, cout_ha_for_saison)      
      @res.add_other_line_for_saison(@sid, :resultats, :total_labours, :total, cout_total)

      #totaux par categorie de labours (colonne saison)
      for cat in Category.labours_cats
        if (labour.category_id == cat.id)
          @res.add_saison_line(@sid, :labours, :category, cat.id, :ha, cout_ha_for_saison)
          @res.add_saison_line(@sid, :labours, :category, cat.id, :total, cout_total)
         end
      end
      
      #TEST ANCESTRY
      for cat in Category.labours_cats
        if (labour.category_id == cat.id)
          @res.add_saison_line(@sid, :labours, :category, cat.id, :ha, cout_ha_for_saison)
          @res.add_saison_line(@sid, :labours, :category, cat.id, :total, cout_total)
         end
      end
    end
  end

  def run_produits
    unless @putoproduits.nil?
      for putoproduit in @putoproduits
        for col in @cols
          #valeur ha et total pour chaque col affecté au pulve
          @res.set_line(@sid, @c, col.id, :putoproduits, :all, putoproduit.id, :ha, putoproduit.get_cout_ha_col(col))
          @res.set_line(@sid, @c, col.id, :putoproduits, :all, putoproduit.id, :total, putoproduit.get_cout_total_col(col))
        end

        datas = { 
          :id => putoproduit.id, 
          :name => putoproduit.produit.name, 
          :category_name => putoproduit.category.name, 
          :cout_ha => putoproduit.get_cout_ha, 
          :user_id => putoproduit.pulve.user_id,
          :cout_total => putoproduit.get_cout_total, 
          :date => putoproduit.pulve.date, 
          :parcelles_length => putoproduit.pulve.parcelles.length, 
          :sum_surfaces => putoproduit.pulve.sum_surfaces }
    
        @res.set_saison_line_datas(@sid, :putoproduits, putoproduit.id, datas)

        # total du pulve
        @res.set_saison_line(@sid, :putoproduits, :all, putoproduit.id, :ha, putoproduit.get_cout_ha_moyen(@surface_of_saison))
        @res.set_saison_line(@sid, :putoproduits, :all, putoproduit.id, :total, putoproduit.get_cout_total)

        #total des produits
        @res.add_other_line_for_saison(@sid, :resultats, :total_putoproduits, :ha, putoproduit.get_cout_ha_moyen(@surface_of_saison))      
        @res.add_other_line_for_saison(@sid, :resultats, :total_putoproduits, :total, putoproduit.get_cout_total)
    
        #totaux par categorie de produits
        cat = putoproduit.produit.category
        while (cat.depth > 0)
          @res.add_saison_line(@sid, :putoproduits, :category, cat.id, :ha, putoproduit.get_cout_ha_moyen(@surface_of_saison))
          @res.add_saison_line(@sid, :putoproduits, :category, cat.id, :total, putoproduit.get_cout_total)
          cat = cat.parent
        end
      end
    end
  end

# Le suffixe "_passage" est accolle a chaque methode car on veut les cout lies a la prestation uniquement
# pas les couts lies au(x) produit(s). methodes_passage ajoutees dans Pulve.rb
  def run_pulves
    for pulve in @pulves
      for col in @cols
        #valeur ha et total pour chaque col affecté au pulve
        @res.set_line(@sid, @c, col.id, :pulves, :all, pulve.id, :ha, pulve.get_cout_ha_passage_col(col))
        @res.set_line(@sid, @c, col.id, :pulves, :all, pulve.id, :total, pulve.get_cout_total_passage_col(col))
      end

      # champs :datas du pulve
      datas = { 
        :id => pulve.id, 
        :name => pulve.name, 
        :user_id => pulve.user_id,
        :cout_ha_passage => pulve.get_cout_ha_passage,
        :cout_total_passage => pulve.get_cout_total_passage,
        :date => pulve.date,
        :parcelles_length => pulve.parcelles.length,
        :sum_surfaces => pulve.sum_surfaces }
    
      @res.set_saison_line_datas(@sid, :pulves, pulve.id, datas)

      # total du pulve
      @res.set_saison_line(@sid, :pulves, :all, pulve.id, :ha, pulve.get_cout_ha_passage_for_saison(@surface_of_saison))
      @res.set_saison_line(@sid, :pulves, :all, pulve.id, :total, pulve.get_cout_total_passage)
    
      if nil
      # TODO 1 revoir le mode de calcul du cout_ha dans pulve.rb
      # TODO 2 supprimer/cacher le champ coup_fixe du pulve (ou pas?)
      # pulve.get_cout_ha_moyen(@surface_of_saison) = 
      # = get_cout_total / surface_of_saison
      # = (self.sum_surfaces * self.get_cout_ha) / surface_of_saison
      # = (self.sum_surfaces * (self.cout_ha_passage + self.get_cout_ha_produits + (self.cout_fixe / self.sum_surfaces))) / surface_of_saison
      # = (self.cout_ha_passage + self.get_cout_ha_produits + (self.cout_fixe / self.sum_surfaces))
      end
      #total des pulves
      @res.add_other_line_for_saison(@sid, :resultats, :total_pulves, :ha, pulve.get_cout_ha_passage_for_saison(@surface_of_saison))      
      @res.add_other_line_for_saison(@sid, :resultats, :total_pulves, :total, pulve.get_cout_total_passage)
    
      #totaux par categorie de pulves
      for cat in Category.produits_cats
        # if (pulve.produit.category_id == cat.id)
        #   @res.add_saison_line(@sid, :pulves, :category, cat.id, :ha, pulve.get_cout_ha_moyen(@surface_of_saison))
        #   @res.add_saison_line(@sid, :pulves, :category, cat.id, :total, pulve.get_cout_total)
        # end
      end
    end
  end

  def run_factures
    # pour chaque facture
    for facture in @factures
      # pour chaque colonne
      for col in @cols
        # set les valeurs ha et total de la facture pour chaque colonne (sauf col saison)
        @res.set_line(@sid, @c, col.id, :factures, :all, facture.id, :ha, facture.get_cout_ha_col(col))
        @res.set_line(@sid, @c, col.id, :factures, :all, facture.id, :total, facture.get_cout_total_col(col))
      end
      
      # set les champs :datas de la facture
      datas = { :id => facture.id, :name => facture.name, :category_id => facture.category_id,
                :category_name => facture.category.name, :user_id => facture.user_id,
                :cout_total => facture.get_cout_total, :charges_assoc => facture.charges?, :date => facture.date, 
                :parcelles_length => facture.parcelles.length, :surface_total => facture.sum_surfaces, :sum_charges => facture.sum_charges}      
      @res.set_saison_line_datas(@sid, :factures, facture.id, datas)
      
      # set les valeurs ha et total de la facture pour la colonne saison (total de la facture)
      @res.set_saison_line(@sid, :factures, :all, facture.id, :total, facture.get_cout_total)
      @res.set_saison_line(@sid, :factures, :all, facture.id, :ha, facture.get_cout_ha_moyen(@surface_of_saison))
      
      # set le champ [:resultats, :total_factures] (par defaut: toutes les factures type Agricole)
      if facture.category.is_agri?
        @res.add_other_line_for_saison(@sid, :resultats, :total_factures, :total, facture.get_cout_total)
        @res.add_other_line_for_saison(@sid, :resultats, :total_factures, :ha, facture.get_cout_ha_moyen(@surface_of_saison))     
      end
      
      # Totaux par types de factures:
      # set le champ [:factcat, factcat_id] si la facture appartient a cette factcat (Argi, Maison ou Invest)
      for factcat in self.types_facture
        if (facture.category.is_descendant_of?(factcat))
          @res.add_saison_line(@sid, :factures, :factcat, factcat.id, :ha, facture.get_cout_ha_moyen(@surface_of_saison))
          @res.add_saison_line(@sid, :factures, :factcat, factcat.id, :total, facture.get_cout_total)
          # @res.saisons[@sid].factures.factcat[factcat.id].total += facture.get_cout_total
        end
      end

      #totaux par categorie de factures
      # set le champ [:category, category_id] si la facture appartient a cette Categorie (Frais generaux, Assurance, ...)
      cat = facture.category
      while (cat.depth > 1)
        @res.add_saison_line(@sid, :factures, :category, cat.id, :ha, facture.get_cout_ha_moyen(@surface_of_saison))
        @res.add_saison_line(@sid, :factures, :category, cat.id, :total, facture.get_cout_total)
        # on impute la facture sur sa category parent
        cat = cat.parent
      end
      
      #synthese des quantites et stocks Produits
      if (facture.category.is_produit?)
        @res.add_saison_line(@sid, :factures, :produits, :quantite, :total, facture.sum_putoproduits_associated)
        @res.add_saison_line(@sid, :factures, :produits, :stock, :total, facture.sum_putoproduits_stock)
        @res.add_saison_line(@sid, :factures, :produits, :used, :total, facture.sum_putoproduits_used)
      end
    end
  end

  def run_ventes
    for vente in @ventes
      for col in @cols
        #valeur ha et total pour chaque col affecté a la vente
        @res.set_line(@sid, @c, col.id, :ventes, :all, vente.id, :ha, vente.get_cout_ha_col(col))
        @res.set_line(@sid, @c, col.id, :ventes, :all, vente.id, :total, vente.get_cout_total_col(col))
      end
 
      # champs :datas de la facture
      datas = { :id => vente.id, :name => vente.name, :category_id => vente.category_id,
                :category_name => vente.category.name, :user_id => vente.user_id,
                :cout_total => vente.get_cout_total, :date => vente.date, 
                :parcelles_length => vente.parcelles.length, :surface_total => vente.sum_surfaces }
      
      @res.set_saison_line_datas(@sid, :ventes, vente.id, datas)
      
      #total de la vente
      @res.set_saison_line(@sid, :ventes, :all, vente.id, :ha, vente.get_cout_ha_moyen(@surface_of_saison))
      @res.set_saison_line(@sid, :ventes, :all, vente.id, :total, vente.get_cout_total)

      # total des ventes
      @res.add_other_line_for_saison(@sid, :resultats, :total_ventes, :ha, vente.get_cout_ha_moyen(@surface_of_saison))      
      @res.add_other_line_for_saison(@sid, :resultats, :total_ventes, :total, vente.get_cout_total)
      
      #totaux par categorie de vente
      # set le champ [:category, category_id] si la vente appartient a cette Categorie (Pac, Vente ble, ...)
      cat = vente.category
      while (cat.depth > 0)
        @res.add_saison_line(@sid, :ventes, :category, cat.id, :ha, vente.get_cout_ha_moyen(@surface_of_saison))
        @res.add_saison_line(@sid, :ventes, :category, cat.id, :total, vente.get_cout_total)
        # on impute la facture sur sa category parent
        cat = cat.parent
      end
    end
  end

  #TOTAUX PAR COLONNE
  def run_totaux

    # LABOURS
    for col in @cols
      sum_total = 0
      total_labour = 0
      # somme de toutes les cellules Labour d'une colonne 
      for labour in @labours         
        #valeur totale du Labour pour cette colonne
        total_labour = @res.get_line(@sid, @c, col.id, :labours, :all, labour.id, :total)
        sum_total += total_labour
        for cat in Category.labours_cats
          if (labour.category_id == cat.id)
            # valeur totale du labour pour cette categorie
            @res.add_line(@sid, @c, col.id, :labours, :category, cat.id, :total, total_labour)
          end
        end
      end
      #somme des labours par col
      @res.set_other_line(@sid, @c, col.id, :resultats, :total_labours, :total, sum_total)     
      @res.set_other_line(@sid, @c, col.id, :resultats, :total_labours, :ha, sum_total/col.surface)
      if PRESTA_LAB_PU.eql?(true)
        #total des couts par col
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_charges, :total, sum_total)
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_charges, :ha, sum_total/col.surface)
        #total des benefs par col
        @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :total, (-sum_total))
        @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :ha, (-sum_total/col.surface))
      end
      #totaux par categorie de labour
      for cat in Category.labours_cats
        cout_total = @res.get_line(@sid, @c, col.id, :labours, :category, cat.id, :total)
        @res.set_line(@sid, @c, col.id, :labours, :category, cat.id, :ha, cout_total/col.surface)
      end        
    end
    
    # PUTOPRODUITS
    unless @putoproduits.nil?
      for col in @cols
        sum_total = 0
        total = 0
        # somme de toutes les cellules Produit d'une colonne 
        for putoproduit in @putoproduits       
          #valeur totale du produits pour cette colonne
          total = @res.get_line(@sid, @c, col.id, :putoproduits, :all, putoproduit.id, :total)
          sum_total += total

          # Imputation sur category et categories parents
          cat = putoproduit.produit.category
          while (cat.depth > 0)
            @res.add_line(@sid, @c, col.id, :putoproduits, :category, cat.id, :total, total)
            @res.add_line(@sid, @c, col.id, :putoproduits, :category, cat.id, :ha, total/col.surface)
            # on impute le produit sur sa category parent
            cat = cat.parent
          end
        end

        
        #somme des produits par col
        @res.set_other_line(@sid, @c, col.id, :resultats, :total_putoproduits, :total, sum_total)     
        @res.set_other_line(@sid, @c, col.id, :resultats, :total_putoproduits, :ha, sum_total/col.surface)
        #total des couts par col
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_charges, :total, sum_total)
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_charges, :ha, sum_total/col.surface)
        #total des benefs par col
        @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :total, (-sum_total))
        @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :ha, (-sum_total/col.surface))
      end
    end
    
    # PULVES
    unless @pulves.nil?
      for col in @cols
        sum_total = 0
        total = 0
        # somme de toutes les cellules Pulve d'une colonne 
        for pulve in @pulves       
          #valeur totale du pulve pour cette colonne
          total = @res.get_line(@sid, @c, col.id, :pulves, :all, pulve.id, :total)
          sum_total += total
        end
        #somme des pulves par col
        @res.set_other_line(@sid, @c, col.id, :resultats, :total_pulves, :total, sum_total)     
        @res.set_other_line(@sid, @c, col.id, :resultats, :total_pulves, :ha, sum_total/col.surface)
        if PRESTA_LAB_PU.eql?(true)
          #total des couts par col
          @res.add_other_line(@sid, @c, col.id, :resultats, :total_charges, :total, sum_total)
          @res.add_other_line(@sid, @c, col.id, :resultats, :total_charges, :ha, sum_total/col.surface)
          #total des benefs par col
          @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :total, (-sum_total))
          @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :ha, (-sum_total/col.surface))
        end
        #totaux par categorie de labour
        for cat in Category.produits_cats
          cout_total = @res.get_line(@sid, @c, col.id, :pulves, :category, cat.id, :total)
          @res.set_line(@sid, @c, col.id, :pulves, :category, cat.id, :ha, cout_total/col.surface)
        end        
      end
    end
    
    unless @factures.nil?
      for col in @cols
        sum_total = 0
        total = 0
        # somme de toutes les cellules facture d'une colonne 
        for facture in @factures       
          #total = valeur de la facture imputee sur cette colonne uniquement
          total = @res.get_line(@sid, @c, col.id, :factures, :all, facture.id, :total)

          if facture.category.is_agri?
            sum_total += total
          end
          
          # Totaux par types de factures:
          # set le champ [:factcat, factcat_id] si la facture appartient a cette factcat (Argi, Maison ou Invest)
          for factcat in self.types_facture
            if (facture.category.is_descendant_of?(factcat))
              @res.add_line(@sid, @c, col.id, :factures, :factcat, factcat.id, :total, total)
            end
          end

          # Imputation sur category et categories parents
          cat = facture.category
          while (cat.depth > 1)
            @res.add_line(@sid, @c, col.id, :factures, :category, cat.id, :total, total)
            @res.add_line(@sid, @c, col.id, :factures, :category, cat.id, :ha, total/col.surface)
            # on impute la facture sur sa category parent
            cat = cat.parent
          end
        end
        # for each facture.category.is_agri? :
        # set le champ [:resultats, :total_factures] (par defaut: toutes les factures type Agricole: sum_total = somme des factures agri)
        #somme des factures par col
        @res.set_other_line(@sid, @c, col.id, :resultats, :total_factures, :total, sum_total)     
        @res.set_other_line(@sid, @c, col.id, :resultats, :total_factures, :ha, sum_total/col.surface)
        #total des couts par col
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_charges, :total, sum_total)
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_charges, :ha, sum_total/col.surface)
        #total des benefs par col
        @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :total, (-sum_total))
        @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :ha, (-sum_total/col.surface))
        #totaux par categorie de facture
        for factcat in self.types_facture
          cout_total = @res.get_line(@sid, @c, col.id, :factures, :factcat, factcat.id, :total)
          @res.set_line(@sid, @c, col.id, :factures, :factcat, factcat.id, :ha, cout_total/col.surface)
        end
      end
    end
    
    #VENTES
    unless @ventes.nil?
      for col in @cols
        sum_total = 0
        total = 0
        # somme de toutes les cellules vente d'une colonne 
        for vente in @ventes       
          #valeur totale du pulve pour cette colonne
          total = @res.get_line(@sid, @c, col.id, :ventes, :all, vente.id, :total)
          sum_total += total
          
          cat = vente.category
          while (cat.depth > 0)
            @res.add_line(@sid, @c, col.id, :ventes, :category, cat.id, :total, total)
            @res.add_line(@sid, @c, col.id, :ventes, :category, cat.id, :ha, total/col.surface)
            cat = cat.parent
          end
        end
        
        #somme des ventes par col
        @res.set_other_line(@sid, @c, col.id, :resultats, :total_ventes, :total, sum_total)     
        @res.set_other_line(@sid, @c, col.id, :resultats, :total_ventes, :ha, sum_total/col.surface)
        #total des benefs par col
        @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :total, sum_total)
        @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :ha, sum_total/col.surface)
      end
    end
    
#SOMME DES TOTAUX POUR COLONNE SAISON
    # total Charges (et total_ha) pour la saison (pas par colonnes, colonne "saison")
    total_putoproduits_ha = @res.get_other_line_for_saison(@sid, :resultats, :total_putoproduits, :ha)
    total_factures_ha =     @res.get_other_line_for_saison(@sid, :resultats, :total_factures, :ha)
    @res.add_other_line_for_saison(@sid, :resultats, :total_charges, :ha, total_putoproduits_ha)
    @res.add_other_line_for_saison(@sid, :resultats, :total_charges, :ha, total_factures_ha)
    if PRESTA_LAB_PU.eql?(true)
      total_pulves_ha =       @res.get_other_line_for_saison(@sid, :resultats, :total_pulves, :ha)
      total_labours_ha =      @res.get_other_line_for_saison(@sid, :resultats, :total_labours, :ha)
      @res.add_other_line_for_saison(@sid, :resultats, :total_charges, :ha, total_pulves_ha)
      @res.add_other_line_for_saison(@sid, :resultats, :total_charges, :ha, total_labours_ha)
    end
    
    total_putoproduits =  @res.get_other_line_for_saison(@sid, :resultats, :total_putoproduits, :total)
    total_factures =      @res.get_other_line_for_saison(@sid, :resultats, :total_factures, :total)
    @res.add_other_line_for_saison(@sid, :resultats, :total_charges, :total, total_putoproduits)
    @res.add_other_line_for_saison(@sid, :resultats, :total_charges, :total, total_factures)
    if PRESTA_LAB_PU.eql?(true)
      total_labours =       @res.get_other_line_for_saison(@sid, :resultats, :total_labours, :total)
      total_pulves =        @res.get_other_line_for_saison(@sid, :resultats, :total_pulves, :total)
      @res.add_other_line_for_saison(@sid, :resultats, :total_charges, :total, total_labours)
      @res.add_other_line_for_saison(@sid, :resultats, :total_charges, :total, total_pulves)
    end
    # total benef
    total_ventes_ha =   @res.get_other_line_for_saison(@sid, :resultats, :total_ventes, :ha)
    total_charges_ha =  @res.get_other_line_for_saison(@sid, :resultats, :total_charges, :ha)
    @res.set_other_line_for_saison(@sid, :resultats, :benef, :ha, total_ventes_ha - total_charges_ha)

    total_ventes = @res.get_other_line_for_saison(@sid, :resultats, :total_ventes, :total)
    total_charges = @res.get_other_line_for_saison(@sid, :resultats, :total_charges, :total)
    @res.set_other_line_for_saison(@sid, :resultats, :benef, :total, total_ventes - total_charges)   
    # logger.error "#{@res.saisons[@sid].to_json}"
  end
  
  def verif
    labours = 0
    pulves = 0
    factures_total = 0
    factures_sum_charges = 0

    charges = 0
    charges_by_col = 0
    charges_by_line = 0
    charges_by_line_ha = 0
        
    # somme des charges
    for col in @cols
      for labour in @labours
        labours += @res.get_line(@sid, @c, col.id, :labours, :all, labour.id, :total)
      end
      for pulve in @pulves
        pulves += @res.get_line(@sid, @c, col.id, :pulves, :all, pulve.id, :total)
      end
      for facture in @factures
        factures_total += @res.get_line(@sid, @c, col.id, :factures, :all, facture.id, :total)
      end
    end
    charges = labours + pulves + factures_total
    
    for facture in @factures
      factures_sum_charges += @res.get_saison_line_datas(@sid, :factures, facture.id)[:sum_charges]
    end
    

    # somme des charges par totaux de col
    for col in @cols
      charges_by_col += @res.get_other_line(@sid, @c, col.id, :resultats, :total_labours, :total) 
      charges_by_col += @res.get_other_line(@sid, @c, col.id, :resultats, :total_pulves, :total) 
      charges_by_col += @res.get_other_line(@sid, @c, col.id, :resultats, :total_factures, :total) 
    end
    # somme des charges par totaux de ligne
    charges_by_line_ha += @res.get_other_line_for_saison(@sid, :resultats, :total_pulves, :ha)
    charges_by_line_ha += @res.get_other_line_for_saison(@sid, :resultats, :total_labours, :ha)
    charges_by_line_ha += @res.get_other_line_for_saison(@sid, :resultats, :total_factures, :ha)
    charges_by_line +=    @res.get_other_line_for_saison(@sid, :resultats, :total_labours, :total)
    charges_by_line +=    @res.get_other_line_for_saison(@sid, :resultats, :total_pulves, :total)
    charges_by_line +=    @res.get_other_line_for_saison(@sid, :resultats, :total_factures, :total)
  end
    
end

