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
                :sid #saison_id

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
  
  def set_alias
    self.val = {}
    self.val[:factures] = self.Tfactures
    self.val[:labours] = self.Tlabours
    self.val[:pulves] = self.Tpulves
    self.val[:ventes] = self.Tventes
    self.val[:benefs] = self.Tbenefs
    self.val[:cols] = self.Tcols
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
    
    set_alias()
    # return true
  end
 
  def init_display
    self.display = {}
    self.display[:labours] = -1
  end
  
  def init_cols
    unless @cols.nil?
      rang = 0

    #Init Hparcelles 
      self.Tcols = {}
      self.Tcols[:ids] = []
      self.Tcols[:col_model] = @col_model
      self.Tcols[:charges] = {} 
      self.Tcols[:benef] = {}  
      self.Tcols[:charges][:total] = 0   # derniere case somme de toutes les charges de chaque colonnes
      self.Tcols[:charges][:ha] = 0      # derniere case somme de tout les totaux ha
      self.Tcols[:benef][:total] = 0  # derniere case somme de TOUTES les ventes
      self.Tcols[:benef][:ha] = 0     # derniere case somme de TOUTES les ventes ha
      self.Tcols[:vente_total] = 0    # derniere case somme de TOUTES les ventes
      self.Tcols[:vente_ha] = 0       # derniere case somme de TOUTES les ventes ha
      
      for col in @cols
        self.Tcols[:length] = @cols.length
        self.Tcols[:ids] << col.id

        self.Tcols[col.id] = {}
        self.Tcols[col.id][:pulves] = {}
        self.Tcols[col.id][:labours] = {}
        self.Tcols[col.id][:factures] = {}
        self.Tcols[col.id][:ventes] = {}
        self.Tcols[col.id][:charges] = {}
        self.Tcols[col.id][:benef] = {}
        
        self.Tcols[col.id][:pulves][:ha] = {}
        self.Tcols[col.id][:pulves][:total] = {}
        self.Tcols[col.id][:pulves][:category] = {}
        self.Tcols[col.id][:pulves][:category][:ha] = {}
        self.Tcols[col.id][:pulves][:category][:total] = {}
        self.Tcols[col.id][:labours][:ha] = {}
        self.Tcols[col.id][:labours][:total] = {}
        self.Tcols[col.id][:labours][:category] = {}
        self.Tcols[col.id][:labours][:category][:ha] = {}
        self.Tcols[col.id][:labours][:category][:total] = {}
        self.Tcols[col.id][:factures][:ha] = {}
        self.Tcols[col.id][:factures][:total] = {}
        self.Tcols[col.id][:ventes][:ha] = {}
        self.Tcols[col.id][:ventes][:total] = {}
        self.Tcols[col.id][:charges][:total] = {}
        self.Tcols[col.id][:charges][:ha] = {}
        self.Tcols[col.id][:charges][:category] = {}
        self.Tcols[col.id][:charges][:category][:ha] = {}
        self.Tcols[col.id][:charges][:category][:total] = {}
        self.Tcols[col.id][:charges][:factcat] = {}
        self.Tcols[col.id][:charges][:factcat][:ha] = {}
        self.Tcols[col.id][:charges][:factcat][:total] = {}
        self.Tcols[col.id][:benef][:ha] = {}
        self.Tcols[col.id][:benef][:total] = {}
        
        self.Tcols[col.id][:id] = col.id
        self.Tcols[col.id][:name] = col.name
        self.Tcols[col.id][:surface] = col.surface
        
        rang += 1
        self.Tcols[col.id][:rang] = rang
        self.Tcols[col.id][:labours][:ha][:sum] = 0
        self.Tcols[col.id][:labours][:total][:sum] = 0
        self.Tcols[col.id][:pulves][:ha][:sum] = 0
        self.Tcols[col.id][:pulves][:total][:sum] = 0
        self.Tcols[col.id][:ventes][:ha][:sum] = 0
        self.Tcols[col.id][:ventes][:total][:sum] = 0
        
        self.Tcols[col.id][:factures][:total][:sum] = 0  
        self.Tcols[col.id][:factures][:ha][:sum] = 0  
        self.Tcols[col.id][:charges][:total][:sum] = 0  
        self.Tcols[col.id][:charges][:ha][:sum] = 0  
        self.Tcols[col.id][:benef][:total][:sum] = 0
        self.Tcols[col.id][:benef][:ha][:sum] = 0
  
        for cat in Category.labours
          self.Tcols[col.id][:labours][:category][:total][cat.id] = 0
          self.Tcols[col.id][:labours][:category][:ha][cat.id] = 0
        end
        for cat in Category.pulves
          self.Tcols[col.id][:pulves][:category][:total][cat.id] = 0  
          self.Tcols[col.id][:pulves][:category][:ha][cat.id] = 0
        end
        for cat in Category.factures
          self.Tcols[col.id][:charges][:category][:total][cat.id] = 0  
          self.Tcols[col.id][:charges][:category][:ha][cat.id] = 0
        end
        for type in self.types_facture
          self.Tcols[col.id][:factures][:total][type.id] = 0  
          self.Tcols[col.id][:factures][:ha][type.id] = 0  
          self.Tcols[col.id][:charges][:factcat][:total][type.id] = 0  
          self.Tcols[col.id][:charges][:factcat][:ha][type.id] = 0
          self.Tcols[col.id][:benef][:total][type.id] = 0  
          self.Tcols[col.id][:benef][:ha][type.id] = 0
        end
      end
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
        cout_ha = labour.get_cout_ha_col(col)
        cout_total = labour.get_cout_total_col(col)
        @res.set_line(@sid, @c, col.id, :labours, :all, labour.id, :ha, cout_ha)
        @res.set_line(@sid, @c, col.id, :labours, :all, labour.id, :total, cout_total)
      end
 
      datas = { :id => labour.id, :name => labour.name, :category_id => labour.category_id, :category_name => labour.category.name,
                :ha_passage => labour.cout_ha_passage, :user_id => labour.user_id, :factures_assoc => labour.factures_assoc?,
                :date => labour.date, :parcelles_length => labour.parcelles.length,
                :surface_total => labour.sum_surfaces }
           
      @res.set_saison_line_datas(@sid, :labours, labour.id, datas)
      datas = @res.get_saison_line_datas(@sid, :labours, labour.id)
      logger.error "datas labour #{labour.id.to_s} cat #{labour.name} : " + datas[:id].to_s
      # total du labour
      @res.set_saison_line(@sid, :labours, :all, labour.id, :ha, labour.get_cout_ha)
      @res.set_saison_line(@sid, :labours, :all, labour.id, :total, labour.get_cout_total)
      
      #total des labours
      @res.add_other_line_for_saison(@sid, :resultats, :total_labours, :ha, labour.get_cout_ha)      
      @res.add_other_line_for_saison(@sid, :resultats, :total_labours, :total, labour.get_cout_total)
            
      #totaux par categorie de labours
      for cat in Category.labours
        if (@Tlabours[labour.id][:category] == cat.id)
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
        cout_ha = pulve.get_cout_ha_col(col)
        cout_total = pulve.get_cout_total_col(col)
        @Tpulves[pulve.id][col.id][:ha] = cout_ha
        @Tpulves[pulve.id][col.id][:total] = cout_total
        @res.set_line(@sid, @c, col.id, :pulves, :all, pulve.id, :ha, cout_ha)
        @res.set_line(@sid, @c, col.id, :pulves, :all, pulve.id, :total, cout_total)
      end
 
      @Tpulves[pulve.id][:parcelles_size] = @Tpulves[pulve.id][:parcelles].length      
      @Tpulves[pulve.id][:ha_produit] = pulve.get_cout_ha_produit
      @Tpulves[pulve.id][:ha_passage] = pulve.cout_ha_passage
      @Tpulves[pulve.id][:ha] = pulve.get_cout_ha
      @Tpulves[pulve.id][:total] = pulve.get_cout_total
      @Tpulves[pulve.id][:surface_total] = pulve.sum_surfaces

      # total du pulve
      @res.set_saison_line(@sid, :pulves, :all, pulve.id, :ha, pulve.get_cout_ha)
      @res.set_saison_line(@sid, :pulves, :all, pulve.id, :total, pulve.get_cout_total)

      #total pulves
      @Tpulves[:total][:sum] += @Tpulves[pulve.id][:total]
      @Tpulves[:ha][:sum] += @Tpulves[pulve.id][:ha]
      
      #totaux par categorie de pulves
      for cat in Category.pulves
        if (@Tpulves[pulve.id][:category] == cat.id)
          @Tpulves[:total][:category][cat.id] += @Tpulves[pulve.id][:total]
          @Tpulves[:ha][:category][cat.id] += @Tpulves[pulve.id][:ha]   
          @res.set_line(@sid, @c, col.id, :pulves, :category, cat.id, :ha, cout_ha)
          @res.set_line(@sid, @c, col.id, :pulves, :category, cat.id, :total, cout_total)
        end
      end
    end
  end

  def run_factures
    for facture in @factures
      for col in @cols
        #valeur ha et total pour chaque col
        cout_ha = facture.get_cout_ha_col(col)
        cout_total = facture.get_cout_total_col(col)
        @Tfactures[facture.id][col.id][:ha] = cout_ha
        @Tfactures[facture.id][col.id][:total] = cout_total
        @res.set_line(@sid, @c, col.id, :factures, :all, facture.id, :ha, cout_ha)
        @res.set_line(@sid, @c, col.id, :factures, :all, facture.id, :total, cout_total)
      end
      
      total_ha = facture.get_cout_ha
      total = facture.get_cout_total
      @Tfactures[facture.id][:parcelles_size] = @Tfactures[facture.id][:parcelles].length
      @Tfactures[facture.id][:surface_total] = facture.sum_surfaces
      
      #total de la facture
      @Tfactures[facture.id][:total] = total
      @Tfactures[facture.id][:ha] = total_ha
      @res.set_saison_line(@sid, :factures, :all, facture.id, :ha, total_ha)
      @res.set_saison_line(@sid, :factures, :all, facture.id, :total, total)
      
      #total des factures
      @Tfactures[:total][:sum] += total
      @Tfactures[:ha][:sum] += total_ha
      
      #totaux par types de factures
      for factcat in self.types_facture
        if (@Tfactures[facture.id][:factcat] == factcat.id)
          @Tfactures[:total][:factcat][factcat.id] += total
          @Tfactures[:ha][:factcat][factcat.id] += total_ha
          @res.set_line(@sid, @c, col.id, :factures, :factcat, factcat.id, :ha, cout_ha)
          @res.set_line(@sid, @c, col.id, :factures, :factcat, factcat.id, :total, cout_total)
        end
      end
      
      #totaux par categorie de factures
      for cat in Category.factures
        if (@Tfactures[facture.id][:category] == cat.id)
          @Tfactures[:total][:category][cat.id] += total 
          @Tfactures[:ha][:category][cat.id] += total_ha   
          @res.set_line(@sid, @c, col.id, :factures, :category, cat.id, :ha, cout_ha)
          @res.set_line(@sid, @c, col.id, :factures, :category, cat.id, :total, cout_total)
        end
      end
    end
  end

  def run_ventes
    for vente in @ventes
      for col in @cols
        #valeur ha et total pour chaque col affecté a la vente
        cout_ha = vente.get_cout_ha_col(col)
        cout_total = vente.get_cout_total_col(col)
        @Tventes[vente.id][col.id][:ha] = cout_ha
        @Tventes[vente.id][col.id][:total] = cout_total
      end
 
      @Tventes[vente.id][:parcelles_size] = @Tventes[vente.id][:parcelles].length      
      @Tventes[vente.id][:ha] = vente.get_cout_ha
      @Tventes[vente.id][:total] = vente.get_cout_total
      @Tventes[vente.id][:surface_total] = vente.sum_surfaces
      #total vente
      @Tventes[:total][:sum] += @Tventes[vente.id][:total]
      @Tventes[:ha][:sum] += @Tventes[vente.id][:ha]
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
        @Tcols[col.id][:labours][:ha][:sum] += cout_ha
        @Tcols[col.id][:labours][:total][:sum] += cout_total
     
        #total des couts par parcelle
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_charges, :ha, cout_ha)
        @res.add_other_line(@sid, @c, col.id, :resultats, :total_charges, :total, cout_total)
        @Tcols[col.id][:charges][:ha][:sum] += cout_ha
        @Tcols[col.id][:charges][:total][:sum] += cout_total

        #total des benefs par parcelle
        @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :ha, (-cout_ha))
        @res.add_other_line(@sid, @c, col.id, :resultats, :benef, :total, (-cout_total))
        @Tcols[col.id][:benef][:ha][:sum] -= cout_ha
        @Tcols[col.id][:benef][:total][:sum] -= cout_total
      
        #totaux par categorie de labour
        for cat in Category.labours
          if (@Tlabours[labour.id][:category] == cat.id)
            @res.add_line(@sid, @c, col.id, :labours, :category, cat.id, :ha, cout_ha)
            @res.add_line(@sid, @c, col.id, :labours, :category, cat.id, :total, cout_total)
            @Tcols[col.id][:labours][:category][:ha][cat.id] += cout_ha
            @Tcols[col.id][:labours][:category][:total][cat.id] += cout_total
          end
        end
      end
    end
    
    for pulve in @pulves
      for col in @cols
        cout_ha = @Tpulves[pulve.id][col.id][:ha]
        cout_total = @Tpulves[pulve.id][col.id][:total]
      
        #somme des pulves par parcelle
        @Tcols[col.id][:pulves][:ha][:sum] += cout_ha
        @Tcols[col.id][:pulves][:total][:sum] += cout_total
     
        #total des couts par parcelle
        @Tcols[col.id][:charges][:ha][:sum] += cout_ha
        @Tcols[col.id][:charges][:total][:sum] += cout_total

        #total des benefs par parcelle
        @Tcols[col.id][:benef][:ha][:sum] -= cout_ha
        @Tcols[col.id][:benef][:total][:sum] -= cout_total
      
        #totaux par categorie de pulve
        for cat in Category.pulves
          if (@Tpulves[pulve.id][:category] == cat.id)
            @Tcols[col.id][:pulves][:category][:ha][cat.id] += cout_ha
            @Tcols[col.id][:pulves][:category][:total][cat.id] += cout_total
          end
        end
      end
    end
    
    for facture in @factures
      for col in @cols
        cout_ha = @Tfactures[facture.id][col.id][:ha]
        cout_total = @Tfactures[facture.id][col.id][:total]

        #somme des factures par parcelle
        @Tcols[col.id][:factures][:ha][:sum] += cout_ha
        @Tcols[col.id][:factures][:total][:sum] += cout_total

        #total des couts par parcelle
        @Tcols[col.id][:charges][:ha][:sum] += cout_ha
        @Tcols[col.id][:charges][:total][:sum] += cout_total

        #total des benefs par parcelle
        @Tcols[col.id][:benef][:ha][:sum] -= cout_ha
        @Tcols[col.id][:benef][:total][:sum] -= cout_total

        #totaux par types de factures
        for factcat in self.types_facture
          if (@Tfactures[facture.id][:factcat] == factcat.id)
            @Tcols[col.id][:charges][:factcat][:ha][factcat.id] += cout_ha
            @Tcols[col.id][:charges][:factcat][:total][factcat.id] += cout_total
          end
        end
        
        #totaux par categorie de factures
        for cat in Category.factures
          if (@Tfactures[facture.id][:category] == cat.id)
            @Tcols[col.id][:charges][:category][:ha][cat.id] += cout_ha
            @Tcols[col.id][:charges][:category][:total][cat.id] += cout_total
          end
        end
      end    
    end

    for vente in @ventes
      for col in @cols
        cout_ha = @Tventes[vente.id][col.id][:ha]
        cout_total = @Tventes[vente.id][col.id][:total]
        
      #somme des ventes par parcelle
        @Tcols[col.id][:ventes][:ha][:sum] += cout_ha
        @Tcols[col.id][:ventes][:total][:sum] += cout_total

      #total des benefs par parcelle
        @Tcols[col.id][:benef][:ha][:sum] += cout_ha
        @Tcols[col.id][:benef][:total][:sum] += cout_total
      end
    end
    

#SOMME DES TOTAUX
    total_charge_ha = 0
    total_charge_ha += @Tfactures[:ha][:sum]
    total_charge_ha += @Tpulves[:ha][:sum]
    total_charge_ha += @Tlabours[:ha][:sum]

    total_vente_ha = 0
    total_vente_ha += @Tventes[:ha][:sum]
    
    @Tcols[:charges][:ha] = total_charge_ha
    @Tcols[:vente_ha] = total_vente_ha
    @Tcols[:benef][:ha] = total_vente_ha - total_charge_ha
    
    for col in @cols
      @Tcols[:charges][:total] += @Tcols[col.id][:charges][:total][:sum]
      #@Tcols[:charges][:ha] += @Tcols[col.id][:charges][:ha][:sum]

      @Tcols[:benef][:total] += @Tcols[col.id][:benef][:total][:sum]
      #@Tcols[:benef][:ha] += @Tcols[col.id][:benef][:ha][:sum]
    end    
  end
end

