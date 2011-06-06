class Print < ActiveRecord::Base
  require 'csv'

  #alias :big :small

  #Txxx variables temporaires
  #Zxxx variables par Zone
  #Pxxx variables par Parcelle
  attr_accessor :Tcols, :Tfactures, :Tlabours, :Tpulves, :Tventes, :Tbenefs,
                :val,
                :csv, :csv_html, :display, :info_debug,
                :saison, :labours, :pulves, :factures, :ventes, :types_facture, :col_model, :cols

  def initialize(col_model)
    unless col_model.find_for_saison().nil?    
      @col_model = col_model
      @cols = col_model.find_for_saison()
      @saison = Saison.find(Setting.find(:first).saison_id)
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
        self.Tcols[col.id][:labours][:ha] = {}
        self.Tcols[col.id][:labours][:total] = {}
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
    # logger.error('@Tcols.to_yaml')
    # logger.error(self.Tcols.inspect)
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
    for labour in @labours
      @Tlabours[labour.id] = {:parcelles => {}, :id => labour.id, :name => labour.name, :total => 0, :ha_passage => labour.cout_ha_passage}
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
    for pulve in @pulves
      @Tpulves[pulve.id] = {:parcelles => {}, 
                            :id => pulve.id, 
                            :name => pulve.name, 
                            :total => 0, 
                            :ha_passage => pulve.cout_ha_passage}
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
        @Tlabours[labour.id][col.id][:ha] = cout_ha
        @Tlabours[labour.id][col.id][:total] = cout_total
      end
 
      @Tlabours[labour.id][:parcelles_size] = @Tlabours[labour.id][:parcelles].length      
      @Tlabours[labour.id][:ha] = labour.get_cout_ha
#DONE 01/04/2011 correction erreur contrib. (cf branch "contrib")
      @Tlabours[labour.id][:total] = labour.get_cout_total
      @Tlabours[labour.id][:surface_total] = labour.sum_surfaces
      #total labour
      @Tlabours[:total][:sum] += @Tlabours[labour.id][:total]
      @Tlabours[:ha][:sum] += @Tlabours[labour.id][:ha]
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
      end
 
      @Tpulves[pulve.id][:parcelles_size] = @Tpulves[pulve.id][:parcelles].length      
      @Tpulves[pulve.id][:ha_produit] = pulve.get_cout_ha_produit
      @Tpulves[pulve.id][:ha_passage] = pulve.cout_ha_passage
      @Tpulves[pulve.id][:ha] = pulve.get_cout_ha
      @Tpulves[pulve.id][:total] = pulve.get_cout_total
      @Tpulves[pulve.id][:surface_total] = pulve.sum_surfaces
      #total pulve
      @Tpulves[:total][:sum] += @Tpulves[pulve.id][:total]
      @Tpulves[:ha][:sum] += @Tpulves[pulve.id][:ha]
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
      end
      
      total_ha = facture.get_cout_ha
      total = facture.get_cout_total
      @Tfactures[facture.id][:parcelles_size] = @Tfactures[facture.id][:parcelles].length
      @Tfactures[facture.id][:surface_total] = facture.sum_surfaces
      
      #total de la facture
      @Tfactures[facture.id][:total] = total
      @Tfactures[facture.id][:ha] = total_ha
      
      #total des factures
      @Tfactures[:total][:sum] += total
      @Tfactures[:ha][:sum] += total_ha
      
      #totaux par types de factures
      for factcat in self.types_facture
        if (@Tfactures[facture.id][:factcat] == factcat.id)
          @Tfactures[:total][:factcat][factcat.id] += total
          @Tfactures[:ha][:factcat][factcat.id] += total_ha
        end
      end
      
      #totaux par categorie de factures
      for cat in Category.factures
        if (@Tfactures[facture.id][:category] == cat.id)
          @Tfactures[:total][:category][cat.id] += total 
          @Tfactures[:ha][:category][cat.id] += total_ha   
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
        cout_ha = @Tlabours[labour.id][col.id][:ha]
        cout_total = @Tlabours[labour.id][col.id][:total]
      
      #somme des labours par col
        @Tcols[col.id][:labours][:ha][:sum] += cout_ha
        @Tcols[col.id][:labours][:total][:sum] += cout_total
     
      #total des couts par parcelle
        @Tcols[col.id][:charges][:ha][:sum] += cout_ha
        @Tcols[col.id][:charges][:total][:sum] += cout_total

        #total des benefs par parcelle
        @Tcols[col.id][:benef][:ha][:sum] -= cout_ha
        @Tcols[col.id][:benef][:total][:sum] -= cout_total
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

# FIXME ajouter un champ de plus comme dans la structure Tfactures pour differencier [factcat] et [category]
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

