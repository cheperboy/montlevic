class Calculate < ActiveRecord::Base

  #Txxx variables temporaires
  #Zxxx variables par Zone
  #Pxxx variables par Parcelle
  attr_accessor :Tcols, :Tfactures, :Tlabours, :Tpulves, :Tventes, :Tbenefs,
                :val,
                :res,
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
      @saison = Saison.find(Setting.find(:first).saison_id)
      @sid = @saison.id
      @labours = @saison.labours
      @pulves = @saison.pulves
      @factures = @saison.factures
      @ventes = @saison.ventes
      @types_facture = Factcat.all
    else
      return nil
    end
  end
  
  def calculate
    @res = Analytic.new()
    init_cols
    # logger.debug(self.Tcols.inspect)
    return nil unless init_factures
    init_pulves
    init_labours
    init_ventes

    run_labours
    run_pulves
    run_factures
    run_ventes
    run_totaux
    verif
    # return true
  end
 
  def init_display
    self.display = {}
    self.display[:labours] = -1
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

  def init_factures
    rang = 0
    
    @Tfactures = Hash.new()
    @Tfactures[:total] = Hash.new()
    @Tfactures[:ha] = Hash.new()
    
    unless @factures.nil? || @factures.size == 0
      @Tfactures[:total][:sum] = 0 
      @Tfactures[:ha][:sum] = 0  
      @Tfactures[:total][:factcat] = Hash.new()
      @Tfactures[:ha][:factcat] = Hash.new()
      @Tfactures[:total][:category] = Hash.new()
      @Tfactures[:ha][:category] = Hash.new()
          
      for factcat in self.types_facture
        @Tfactures[:total][:factcat][factcat.id] = 0 
        @Tfactures[:ha][:factcat][factcat.id] = 0    
      end
      for cat in Category.factures
        @Tfactures[:total][:category][cat.id] = 0 
        @Tfactures[:ha][:category][cat.id] = 0    
      end
    
      for facture in @factures
        datas = { :id => facture.id, :name => facture.name, :category_id => facture.category_id }
        @res.set_saison_line_datas(@sid, :factures, facture.id, datas)

        @Tfactures[facture.id] = {
          :parcelles => {}, 
          :id => facture.id, 
          :name => facture.name, 
          :cout => facture.cout,
          :factcat => facture.factcat_id,
          :category => facture.category_id}
        #for parcelle in facture.parcelles
        for col in @cols          
          hcols = {:name => col.name, :surface => col.surface }  
          @Tfactures[facture.id][:parcelles].store(col.id, hcols)
          @Tfactures[facture.id][col.id] = {:ha => 0, :total => 0 , :cout_sans_charges => 0 }
  
          @Tfactures[facture.id][:total] = 0 
          @Tfactures[facture.id][:ha] = 0 
       end
      end
    else # @factures.nil?
      return nil
    end
  end
  
  def init_benefs
    @types = Category.find_all_by_upcategory_id(Upcategory.find_by_name('vente'))
    rang = 0    

    @Tventes = Hash.new()
    @Tventes[:total] = Hash.new()
    @Tventes[:ha] = Hash.new()
    
    for vente in @ventes
      @Tventes[vente.id] = {:parcelles => {}, :id => vente.id, :name => vente.name, :cout => vente.value }
      #for parcelle in facture.parcelles
      for col in @cols
        hcols = {:name => col.name, :surface => col.surface }  
        @Tventes[vente.id][:parcelles].store(col.id, hcols)
        @Tventes[vente.id][col.id] = {:ha => 0, :total => 0 , :cout_sans_charges => 0 }

        @Tventes[vente.id][:total] = 0 
        @Tventes[vente.id][:ha] = 0 
        @Tventes[:total][:sum] = 0 
        @Tventes[:ha][:sum] = 0 
        
        for type in @types
          @Tventes[:total][type.name] = 0 
          @Tventes[:ha][type.name] = 0 
        end
      end
    end
  end
  
  def init_ventes
    @Tventes = Hash.new()
    @Tventes[:total] = Hash.new()
    @Tventes[:ha] = Hash.new()
    @Tventes[:total][:sum] = 0
    @Tventes[:ha][:sum] = 0
    for vente in @ventes
      datas = { :id => vente.id, :name => vente.name, :category_id => vente.category_id }

      @res.set_saison_line_datas(@sid, :ventes, vente.id, datas)
      @Tventes[vente.id] = {:parcelles => {}, :id => vente.id, :name => vente.name, :total => 0, :ha => 0 }
      for col in @cols
        hcols = {:name => col.name, :surface => col.surface }
        @Tventes[vente.id][:parcelles].store(col.id, hcols)
        @Tventes[vente.id][col.id] = {:ha => 0, :total => 0 }
      end
    end
  end
  
  def init_labours
    @Tlabours = Hash.new()
    @Tlabours[:total] = Hash.new()
    @Tlabours[:ha] = Hash.new()
    # @Tlabours[:categories] = Hash.new()
    @Tlabours[:total][:sum] = 0
    @Tlabours[:ha][:sum] = 0
    @Tlabours[:total][:category] = {}
    @Tlabours[:ha][:category] = {}

    # init des categories de labours
    for cat in Category.labours
      @Tlabours[:total][:category][cat.id] = 0
      @Tlabours[:ha][:category][cat.id] = 0
    end

    for labour in @labours      
      @Tlabours[labour.id] = {
        :parcelles => {}, 
        :id => labour.id, 
        :name => labour.name, 
        :total => 0, 
        :ha_passage => labour.cout_ha_passage,
        :category => labour.category_id
      }
      for col in @cols
        hcols = {:name => col.name, :surface => col.surface }  
        @Tlabours[labour.id][:parcelles].store(col.id, hcols)
        @Tlabours[labour.id][col.id] = {:ha => 0, :total => 0 }
      end
    end
  end

  def init_pulves
    @Tpulves = Hash.new()
    @Tpulves[:total] = Hash.new()
    @Tpulves[:ha] = Hash.new()
    @Tpulves[:total][:sum] = 0
    @Tpulves[:ha][:sum] = 0
    @Tpulves[:total][:category] = {}
    @Tpulves[:ha][:category] = {}
    
    # init des categories de pulve
    for cat in Category.pulves
      @Tpulves[:total][:category][cat.id] = 0 
      @Tpulves[:ha][:category][cat.id] = 0   
    end

    for pulve in @pulves
      datas = { :id => pulve.id, :name => pulve.name, :category_id => pulve.category_id, 
                :ha_passage => pulve.cout_ha_passage, :cout_fixe => pulve.cout_fixe, :user_id => pulve.user_id}
      @res.set_saison_line_datas(@sid, :pulves, pulve.id, datas)

      @Tpulves[pulve.id] = {
        :parcelles => {}, 
        :id => pulve.id, 
        :name => pulve.name, 
        :total => 0, 
        :ha_passage => pulve.cout_ha_passage,
        :category => pulve.category_id
      }

      for col in @cols
        hcols = {:name => col.name, :surface => col.surface }  
        @Tpulves[pulve.id][:parcelles].store(col.id, hcols)
        @Tpulves[pulve.id][col.id] = {:ha => 0, :total => 0 }
      end
    end
  end

  def run_labours
    for labour in @labours
      for col in @cols
        #valeur ha et total pour chaque col affecté a la labour
        @res.set_line(@sid, @c, col.id, :labours, :all, labour.id, :ha, labour.get_cout_ha_col(col))
        @res.set_line(@sid, @c, col.id, :labours, :all, labour.id, :total, labour.get_cout_total_col(col))
      end
 
      datas = { :id => labour.id, :name => labour.name, :category_id => labour.category_id, :category_name => labour.category.name,
                :ha_passage => labour.cout_ha_passage, :user_id => labour.user_id, :factures_assoc => labour.factures_assoc?,
                :date => labour.date, :parcelles_length => labour.parcelles.length, :surface_total => labour.sum_surfaces }
           
      @res.set_saison_line_datas(@sid, :labours, labour.id, datas)

      # total du labour
      @res.set_saison_line(@sid, :labours, :all, labour.id, :total, labour.get_cout_total)
      @res.set_saison_line(@sid, :labours, :all, labour.id, :ha, labour.get_cout_ha_for_saison(@surface_of_saison))
      
      #total des labours
      @res.add_other_line_for_saison(@sid, :resultats, :total_labours, :ha, labour.get_cout_ha)      
      @res.add_other_line_for_saison(@sid, :resultats, :total_labours, :total, labour.get_cout_total)
            
      #totaux par categorie de labours
      for cat in Category.labours
        if (labour.category_id == cat.id)
          @res.add_saison_line(@sid, :labours, :category, cat.id, :ha, labour.get_cout_ha)
          @res.add_saison_line(@sid, :labours, :category, cat.id, :total, labour.get_cout_total)
         end
      end
    end
  end

  def run_pulves
    for pulve in @pulves
      for col in @cols
        #valeur ha et total pour chaque col affecté a la pulve
        @res.set_line(@sid, @c, col.id, :pulves, :all, pulve.id, :ha, pulve.get_cout_ha_col(col))
        @res.set_line(@sid, @c, col.id, :pulves, :all, pulve.id, :total, pulve.get_cout_total_col(col))
      end
 
      # champs :datas du pulve
      datas = { :id => pulve.id, :name => pulve.name, :category_id => pulve.category_id, :category_name => pulve.category.name, 
                :cout_ha_passage => pulve.cout_ha_passage, :cout_ha_produit => pulve.get_cout_ha_produit, :user_id => pulve.user_id,
                :cout_total => pulve.get_cout_total, :factures_assoc => pulve.factures_assoc?, :date => pulve.date, 
                :parcelles_length => pulve.parcelles.length, :surface_total => pulve.sum_surfaces }
      
      @res.set_saison_line_datas(@sid, :pulves, pulve.id, datas)

      # total du pulve
      @res.set_saison_line(@sid, :pulves, :all, pulve.id, :ha, pulve.get_cout_ha)
      @res.set_saison_line(@sid, :pulves, :all, pulve.id, :total, pulve.get_cout_total)

      #total des pulves
      @res.add_other_line_for_saison(@sid, :resultats, :total_pulves, :ha, pulve.get_cout_ha)      
      @res.add_other_line_for_saison(@sid, :resultats, :total_pulves, :total, pulve.get_cout_total)
      
      #totaux par categorie de pulves
      for cat in Category.pulves
        if (pulve.category_id == cat.id)
          @res.add_saison_line(@sid, :pulves, :category, cat.id, :ha, pulve.get_cout_ha)
          @res.add_saison_line(@sid, :pulves, :category, cat.id, :total, pulve.get_cout_total)
        end
      end
    end
  end

  def run_factures
    for facture in @factures
      for col in @cols
        #valeur ha et total pour chaque col
        @res.set_line(@sid, @c, col.id, :factures, :all, facture.id, :ha, facture.get_cout_ha_col(col))
        @res.set_line(@sid, @c, col.id, :factures, :all, facture.id, :total, facture.get_cout_total_col(col))
      end
      
      # champs :datas de la facture
      datas = { :id => facture.id, :name => facture.name, :category_id => facture.category_id,
                :category_name => facture.category.name, :user_id => facture.user_id,
                :cout_total => facture.get_cout_total, :charges_assoc => facture.charges?, :date => facture.date, 
                :parcelles_length => facture.parcelles.length, :surface_total => facture.sum_surfaces, :sum_charges => facture.sum_charges}
      
      @res.set_saison_line_datas(@sid, :factures, facture.id, datas)
      
      #total de la facture
      @res.set_saison_line(@sid, :factures, :all, facture.id, :total, facture.get_cout_total)
      @res.set_saison_line(@sid, :factures, :all, facture.id, :ha, facture.get_cout_ha_for_saison(@surface_of_saison))
      
      # NEW !
      #total des factures
      @res.add_other_line_for_saison(@sid, :resultats, :total_factures, :total, facture.get_cout_total)
      # @res.add_other_line_for_saison(@sid, :resultats, :total_factures, :ha, facture.get_cout_ha_for_saison(@surface_of_saison))     
      
      #totaux par types de factures
      for factcat in self.types_facture
        if (facture.factcat_id == factcat.id)
          @res.add_saison_line(@sid, :factures, :factcat, factcat.id, :ha, facture.get_cout_ha)
          @res.add_saison_line(@sid, :factures, :factcat, factcat.id, :total, facture.get_cout_total)
        end
      end
      
      #totaux par categorie de factures
      for cat in Category.factures
        if (facture.category_id == cat.id)
          @res.add_saison_line(@sid, :factures, :category, cat.id, :ha, facture.get_cout_ha)
          @res.add_saison_line(@sid, :factures, :category, cat.id, :total, facture.get_cout_total)
        end
      end
    end
    # cout ha pour la colonne saison
    for facture in @factures
    end
    facture_total = @res.get_other_line_for_saison(@sid, :resultats, :total_factures, :total)
    @res.set_other_line_for_saison(@sid, :resultats, :total_factures, :ha, (facture_total/@surface_of_saison))     
    
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
      @res.set_saison_line(@sid, :ventes, :all, vente.id, :ha, vente.get_cout_ha)
      @res.set_saison_line(@sid, :ventes, :all, vente.id, :total, vente.get_cout_total)

      # total des ventes
      @res.add_other_line_for_saison(@sid, :resultats, :total_ventes, :ha, vente.get_cout_ha)      
      @res.add_other_line_for_saison(@sid, :resultats, :total_ventes, :total, vente.get_cout_total)
      
      #totaux par categorie de ventes
      for cat in Category.ventes
        if (vente.category_id == cat.id)
          @res.add_saison_line(@sid, :ventes, :category, cat.id, :ha, vente.get_cout_ha)
          @res.add_saison_line(@sid, :ventes, :category, cat.id, :total, vente.get_cout_total)
        end
      end
    end
  end

  def run_totaux    
    #TOTAUX PAR PARCELLES
    for labour in @labours
      for col in @cols
        cout_ha = @res.get_line(@sid, @c, col.id, :labours, :all, labour.id, :ha)
        cout_total = @res.get_line(@sid, @c, col.id, :labours, :all, labour.id, :total)  
        #somme des labours par col
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_labours, :ha, cout_ha)
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_labours, :total, cout_total)     
        #total des couts par parcelle
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_charges, :ha, cout_ha)
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_charges, :total, cout_total)
        #total des benefs par parcelle
        @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :ha, (-cout_ha))
        @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :total, (-cout_total))
        #totaux par categorie de labour
        for cat in Category.labours
          if (labour.category_id == cat.id)
            @res.add_line(@sid, @c, col.id, :labours, :category, cat.id, :ha, cout_ha)
            @res.add_line(@sid, @c, col.id, :labours, :category, cat.id, :total, cout_total)
          end
        end
      end
    end
    
    for pulve in @pulves
      for col in @cols
        cout_ha = @res.get_line(@sid, @c, col.id, :pulves, :all, pulve.id, :ha)
        cout_total = @res.get_line(@sid, @c, col.id, :pulves, :all, pulve.id, :total)
        #somme des pulves par col
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_pulves, :ha, cout_ha)
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_pulves, :total, cout_total)     
        #total des couts par col
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_charges, :ha, cout_ha)
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_charges, :total, cout_total)
        #total des benefs par col
        @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :ha, (-cout_ha))
        @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :total, (-cout_total))
        #totaux par categorie de pulve
        for cat in Category.pulves
          if (pulve.category_id == cat.id)
            @res.add_line(@sid, @c, col.id, :pulves, :category, cat.id, :ha, cout_ha)
            @res.add_line(@sid, @c, col.id, :pulves, :category, cat.id, :total, cout_total)
          end
        end
      end
    end
    
    for facture in @factures
      for col in @cols
        cout_ha = @res.get_line(@sid, @c, col.id, :factures, :all, facture.id, :ha)
        cout_total = @res.get_line(@sid, @c, col.id, :factures, :all, facture.id, :total)        
        #somme des factures par col
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_factures, :ha, cout_ha)
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_factures, :total, cout_total)
        #somme des couts par col (labours + pulves +factures)
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_charges, :ha, cout_ha)
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_charges, :total, cout_total)
        #total des benefs par col (ventes - charges)
        @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :ha, (-cout_ha))
        @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :total, (-cout_total))
        #totaux par types de factures
        for factcat in self.types_facture
          if (facture.factcat_id == factcat.id)
            @res.add_line(@sid, @c, col.id, :factures, :factcat, factcat.id, :ha, cout_ha)
            @res.add_line(@sid, @c, col.id, :factures, :factcat, factcat.id, :total, cout_total)
          end
        end
        #totaux par categorie de factures
        for cat in Category.factures
          if (facture.category_id == cat.id)
            @res.add_line(@sid, @c, col.id, :factures, :category, cat.id, :ha, cout_ha)
            @res.add_line(@sid, @c, col.id, :factures, :category, cat.id, :total, cout_total)
          end
        end
      end    
    end

    for vente in @ventes
      for col in @cols
        cout_ha = @res.get_line(@sid, @c, col.id, :ventes, :all, vente.id, :ha)
        cout_total = @res.get_line(@sid, @c, col.id, :ventes, :all, vente.id, :total)
        #somme des ventes par col
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_ventes, :ha, cout_ha)
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_ventes, :total, cout_total)

        #total des benefs par col
        @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :ha, (cout_ha))
        @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :total, (cout_total))
      
        #totaux par categorie de vente
        for cat in Category.ventes
          if (vente.category_id == cat.id)
            @res.add_line(@sid, @c, col.id, :ventes, :category, cat.id, :ha, cout_ha)
            @res.add_line(@sid, @c, col.id, :ventes, :category, cat.id, :total, cout_total)
          end
        end
      end
    end
    

#SOMME DES TOTAUX

    # total Charges (et total_ha) pour la saison (pas par colonnes, colonne "saison")
    total_pulves_ha =   @res.get_other_line_for_saison(@sid, :resultats, :total_pulves, :ha)
    total_labours_ha =  @res.get_other_line_for_saison(@sid, :resultats, :total_labours, :ha)
    total_factures_ha = @res.get_other_line_for_saison(@sid, :resultats, :total_factures, :ha)
    @res.add_other_line_for_saison(@sid, :resultats, :total_charges, :ha, total_labours_ha)
    @res.add_other_line_for_saison(@sid, :resultats, :total_charges, :ha, total_pulves_ha)
    @res.add_other_line_for_saison(@sid, :resultats, :total_charges, :ha, total_factures_ha)

    total_pulves =    @res.get_other_line_for_saison(@sid, :resultats, :total_pulves, :total)
    total_labours =   @res.get_other_line_for_saison(@sid, :resultats, :total_labours, :total)
    total_factures =  @res.get_other_line_for_saison(@sid, :resultats, :total_factures, :total)
    @res.add_other_line_for_saison(@sid, :resultats, :total_charges, :total, total_labours)
    @res.add_other_line_for_saison(@sid, :resultats, :total_charges, :total, total_pulves)
    @res.add_other_line_for_saison(@sid, :resultats, :total_charges, :total, total_factures)

    # total benef
    total_ventes_ha =   @res.get_other_line_for_saison(@sid, :resultats, :total_ventes, :ha)
    total_charges_ha =  @res.get_other_line_for_saison(@sid, :resultats, :total_charges, :ha)
    @res.set_other_line_for_saison(@sid, :resultats, :benef, :ha, total_ventes_ha - total_charges_ha)

    total_ventes = @res.get_other_line_for_saison(@sid, :resultats, :total_ventes, :total)
    total_charges = @res.get_other_line_for_saison(@sid, :resultats, :total_charges, :total)
    @res.set_other_line_for_saison(@sid, :resultats, :benef, :total, total_ventes - total_charges)   
  end
  
  def verif
    # total_pulves_ha =   @res.get_other_line_for_saison(@sid, :resultats, :total_pulves, :ha)
    # total_labours_ha =  @res.get_other_line_for_saison(@sid, :resultats, :total_labours, :ha)
    # total_factures_ha = @res.get_other_line_for_saison(@sid, :resultats, :total_factures, :ha)
    # total_pulves =      @res.get_other_line_for_saison(@sid, :resultats, :total_pulves, :total)
    # total_labours =     @res.get_other_line_for_saison(@sid, :resultats, :total_labours, :total)
    # total_factures =    @res.get_other_line_for_saison(@sid, :resultats, :total_factures, :total)

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
    
    # logger.error "charges : #{charges}"
    # logger.error "charges_by_line : #{charges_by_line}"
    # logger.error "charges_by_col : #{charges_by_col}"
    # logger.error "-----"
    # logger.error "labours + pulves = factures.sum_charges ?"
    # logger.error "labours #{labours} + pulves #{pulves} = #{labours + pulves}"
    # logger.error "factures_sum_charges #{factures_sum_charges}"

  end
    
end

