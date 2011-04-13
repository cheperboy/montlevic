class Print < ActiveRecord::Base
  require 'csv'

  #alias :big :small

  #Txxx variables temporaires
  #Zxxx variables par Zone
  #Pxxx variables par Parcelle
  
  attr_accessor :Tcols, :Tfactures, :Tlabours, :Tpulves, :Tventes, :Tbenefs,
                :val,
                :csv, :csv_html, :display, :info_debug

  def initialize
  end

  def get_value_or_blank(var, value)
    val = var[value.to_sym]
    return (pretty_csv(val))
  end

  #TODO deja declaré dans application helper commment ne pas dupliquer cette methode?
  def pretty_csv(val)
    precision = 1
    return nil if (val.equal?(0))
    return nil if (val == 0.0)
    return val.to_i if (val == val.to_i)
    return val if precision == 0
    return (val * 10 ** precision).round.to_f / 10 ** precision
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
  
  def calculate(col_model)
    unless col_model.find_for_saison().nil?
      
      @saison = Saison.find(Setting.find(:first).saison_id)
      @labours = @saison.labours
      @pulves = @saison.pulves
      @factures = Facture.find_by_saison(:all, :order => "category_id")
      @ventes = Vente.find_by_saison(:all, :order => "category_id")
      @types = Category.find_all_by_upcategory_id(Upcategory.find_by_name('facture'))
#      @labours = Labour.find_by_saison(:all)
#      @pulves = Pulve.find_by_saison(:all)
#      @factures = Facture.find_by_saison(:all, :order => "category_id")
#      @ventes = Vente.find_by_saison(:all, :order => "category_id")
#      @types = Category.find_all_by_upcategory_id(Upcategory.find_by_name('facture'))
      
      init_cols(col_model)
      init_cols(col_model)
      init_factures(col_model)
      init_pulves(col_model)
      init_labours(col_model)
      init_ventes(col_model)

      run_labours(col_model)
      run_pulves(col_model)
      run_factures(col_model)
      run_ventes(col_model)
      run_totaux(col_model)
      
      set_alias()
    else
      return nil
    end
  end
 
  def init_display
    self.display = {}
    self.display[:labours] = -1
  end
  
  def init_cols(col_model)
    cols = col_model.find_for_saison()

    unless cols.nil?
      types = Category.find_all_by_upcategory_id(Upcategory.find_by_name('facture'))
      rang = 0
      
    #Init Hparcelles 
      self.Tcols = {}
      self.Tcols[:ids] = []
      self.Tcols[:col_model] = col_model
      self.Tcols[:charges] = {} 
      self.Tcols[:benef] = {}  
      self.Tcols[:charges][:total] = 0   # derniere case somme de toutes les charges de chaque colonnes
      self.Tcols[:charges][:ha] = 0      # derniere case somme de tout les totaux ha
      self.Tcols[:benef][:total] = 0  # derniere case somme de TOUTES les ventes
      self.Tcols[:benef][:ha] = 0     # derniere case somme de TOUTES les ventes ha
      self.Tcols[:vente_total] = 0  # derniere case somme de TOUTES les ventes
      self.Tcols[:vente_ha] = 0     # derniere case somme de TOUTES les ventes ha
      
      for col in cols
        self.Tcols[:length] = cols.length
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
        self.Tcols[col.id][:charges][:ha] = {}
        self.Tcols[col.id][:charges][:total] = {}
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
  
        for type in types
          self.Tcols[col.id][:factures][:total][type.name] = 0  
          self.Tcols[col.id][:factures][:ha][type.name] = 0  
          self.Tcols[col.id][:charges][:total][type.name] = 0  
          self.Tcols[col.id][:charges][:ha][type.name] = 0
          self.Tcols[col.id][:benef][:total][type.name] = 0  
          self.Tcols[col.id][:benef][:ha][type.name] = 0
        end
      end
    end
    
    
  end

  def init_factures(col_model)
    cols = col_model.find_for_saison()
    #@factures = Facture.find_by_saison(:all, :order => "category_id")
    #@types = Category.find_all_by_upcategory_id(Upcategory.find_by_name('facture'))
    rang = 0    
    
    @Tfactures = Hash.new()
    @Tfactures[:total] = Hash.new()
    @Tfactures[:ha] = Hash.new()
    
    for facture in @factures
      @Tfactures[facture.id] = {:parcelles => {}, :id => facture.id, :name => facture.name, :cout => facture.cout }
      #for parcelle in facture.parcelles
      for col in cols
        hcols = {:name => col.name, :surface => col.surface }  
        @Tfactures[facture.id][:parcelles].store(col.id, hcols)
        @Tfactures[facture.id][col.id] = {:ha => 0, :total => 0 , :cout_sans_charges => 0 }

        @Tfactures[facture.id][:total] = 0 
        @Tfactures[facture.id][:ha] = 0 
        @Tfactures[:total][:sum] = 0 
        @Tfactures[:ha][:sum] = 0 
        
        for type in @types
          @Tfactures[:total][type.name] = 0 
          @Tfactures[:ha][type.name] = 0 
        end
      end
    end
  end
  
  def init_benefs(col_model)
    cols = col_model.find_for_saison()
    @ventes = Vente.find_by_saison(:all, :order => "category_id")
    @types = Category.find_all_by_upcategory_id(Upcategory.find_by_name('vente'))
    rang = 0    
    
    @Tventes = Hash.new()
    @Tventes[:total] = Hash.new()
    @Tventes[:ha] = Hash.new()
    
    for vente in @ventes
      @Tventes[vente.id] = {:parcelles => {}, :id => vente.id, :name => vente.name, :cout => vente.value }
      #for parcelle in facture.parcelles
      for col in cols
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
  
  def init_ventes(col_model)
  #Init Hlabours 
    cols = col_model.find_for_saison()
    ventes = Vente.find_by_saison(:all)
    
    @Tventes = Hash.new()
    @Tventes[:total] = Hash.new()
    @Tventes[:ha] = Hash.new()
    @Tventes[:total][:sum] = 0
    @Tventes[:ha][:sum] = 0
    for vente in ventes
      @Tventes[vente.id] = {:parcelles => {}, :id => vente.id, :name => vente.name, :total => 0, :ha => 0 }
      for col in cols
        hcols = {:name => col.name, :surface => col.surface }
        @Tventes[vente.id][:parcelles].store(col.id, hcols)
        @Tventes[vente.id][col.id] = {:ha => 0, :total => 0 }
      end
    end
  end
  
  def init_labours(col_model)
  #Init Hlabours 
    cols = col_model.find_for_saison()
    labours = Labour.find_by_saison(:all)
    
    @Tlabours = Hash.new()
    @Tlabours[:total] = Hash.new()
    @Tlabours[:ha] = Hash.new()
    @Tlabours[:total][:sum] = 0
    @Tlabours[:ha][:sum] = 0
    for labour in labours
      @Tlabours[labour.id] = {:parcelles => {}, :id => labour.id, :name => labour.name, :total => 0, :ha_passage => labour.cout_ha_passage}
      for col in cols
        hcols = {:name => col.name, :surface => col.surface }  
        @Tlabours[labour.id][:parcelles].store(col.id, hcols)
        @Tlabours[labour.id][col.id] = {:ha => 0, :total => 0 }
      end
    end
  end

  def init_pulves(col_model)
  #Init Hpulve 
    cols = col_model.find_for_saison()
    @pulves = Pulve.find_by_saison(:all)
    
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
      for col in cols
        hcols = {:name => col.name, :surface => col.surface }  
        @Tpulves[pulve.id][:parcelles].store(col.id, hcols)
        @Tpulves[pulve.id][col.id] = {:ha => 0, :total => 0 }
      end
    end
  end

  def run_labours(col_model)
    cols = col_model.find_for_saison()
#    @labours = Labour.find_by_saison(:all)
  #LABOUR
    for labour in @labours
      for col in cols
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

  def run_pulves(col_model)
    cols = col_model.find_for_saison()
    for pulve in @pulves
      for col in cols
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

  def run_factures(col_model)
    cols = col_model.find_for_saison()
    for facture in @factures
      for col in cols
        #valeur ha et total pour chaque col
        cout_ha = facture.get_cout_ha_col(col)
        cout_total = facture.get_cout_total_col(col)
        @Tfactures[facture.id][col.id][:ha] = cout_ha
        @Tfactures[facture.id][col.id][:total] = cout_total
      end
      
      total_ha = facture.get_cout_ha
      total = facture.get_cout_total
      @Tfactures[facture.id][:category] = facture.category.name
      @Tfactures[facture.id][:parcelles_size] = @Tfactures[facture.id][:parcelles].length
      @Tfactures[facture.id][:surface_total] = facture.sum_surfaces
      
      #total de la facture
      @Tfactures[facture.id][:total] = total
      @Tfactures[facture.id][:ha] = total_ha
      
      #total des factures
      @Tfactures[:total][:sum] += total
      @Tfactures[:ha][:sum] += total_ha
      
      #totaux par types de factures
      for type in @types
        if (@Tfactures[facture.id][:category].to_s == type.name)
          @Tfactures[:total][type.name] += total
          @Tfactures[:ha][type.name] += total_ha
        end
      end
    end
  end

  def run_ventes(col_model)
    cols = col_model.find_for_saison()
    for vente in @ventes
      for col in cols
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

  def run_totaux(col_model)
    cols = col_model.find_for_saison()
    
    #TOTAUX PAR PARCELLES
    for labour in @labours
      for col in cols
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
      for col in cols
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
      for col in cols
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


        for type in @types
          if (@Tfactures[facture.id][:category].to_s == type.name)
            @Tcols[col.id][:charges][:ha][type.name] += cout_ha
            @Tcols[col.id][:charges][:total][type.name] += cout_total
          end
        end
      end    
    end

    for vente in @ventes
      for col in cols
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
    
    for col in cols
      @Tcols[:charges][:total] += @Tcols[col.id][:charges][:total][:sum]
      #@Tcols[:charges][:ha] += @Tcols[col.id][:charges][:ha][:sum]

      @Tcols[:benef][:total] += @Tcols[col.id][:benef][:total][:sum]
      #@Tcols[:benef][:ha] += @Tcols[col.id][:benef][:ha][:sum]
    end    
  end

  def csv_put_tete(w, model)
    row = []
    ((self.csv[:nb_cols] * 2) + self.csv[:nb_row_before]).times { row << nil }
    csv_write(w, row)
    
    row.clear
    row = [model.to_s.pluralize]
    ((self.csv[:nb_cols] * 2) + self.csv[:nb_row_before] - 1 ).times { row << nil }
    csv_write(w, row)
    row.clear
  end

  def csv_end(w)
    w.close
    self.csv[:table] += '</table>'    
  end

  def csv_init
    self.csv = {}
    self.csv[:html] = ''
    self.csv[:table] = '<table class="table_print">'
    self.csv[:nb_cols] = self.Tcols[:length]
    self.csv[:nb_row_before] = 5
    self.csv[:nb_row_total] = csv[:nb_cols] + self.csv[:nb_row_before]
  end
  
  def write_row(w, row)
    w << row    
  end

  def write_html(row)
    row.each do |col|
      self.csv[:html] += col.to_s + ', '
    end
    self.csv[:html] += '<br>'      
  end

  def write_table(row)
    self.csv[:table] += '<tr>'      
    row.each do |col|
      self.csv[:table] += '<td> ' + col.to_s + '</td>'
    end
    self.csv[:table] += '</tr>'      
  end
  
  def csv_write(w, row)
    write_table(row)
    write_html(row)
    write_row(w, row)
  end

  def csv_tete(w)
    row = []
    self.csv[:nb_row_before].times do row << nil end
    self.Tcols[:ids].each do |id|
      row << self.Tcols[id][:name]
      row << (self.Tcols[id][:surface].to_s + ' Ha')
    end
    csv_write(w, row)  
    
    row.clear
    row = [nil, 'nom', 'passage Ha', 'total/Ha', 'total'] 
    entete = ['c/Ha', 'total']
    (self.csv[:nb_cols]).times { row += entete }
    csv_write(w, row)
  end
  
  def csv_charges(w, model, detail_total, unused)
  # csv_charges
  # w : writer
  # model : Labour, Pulve, Facture, Vente
  # detail_total : 
  #   true  : total for all types 
  #   false : total sum only

    
    sym = model.to_s.downcase.pluralize.to_sym
    # sym = 'labours' ou 'pulves'...
    row = []
    
    csv_put_tete(w, model.to_s.pluralize)
    if (self.display[sym] == 1)
      lines = model.find_by_saison(:all)
      lines.each do |line|
        dep = self.val[sym][line.id] 
  
        row << line.category.name + ' ' + line.name
        row << line.date.to_s
        cell = line.parcelles.length.to_s
        cell += ' p - '
        cell += pretty_csv(dep[:surface_total]).to_s
        cell += ' ha'
        row << cell
        row << pretty_csv(dep[:ha]).to_s
        row << pretty_csv(dep[:total]).to_s
        self.val[:cols][:ids].each do |id|
          row << pretty_csv(dep[id][:ha])
          row << pretty_csv(dep[id][:total])
        end
        csv_write(w, row)
        row.clear
      end
    end
    #Total 'model'    
    if detail_total
      csv_total_by_types(w, model)
    end

    title = 'Total ' + model.to_s.pluralize
    row << [title]
    (self.csv[:nb_row_before] - 3).times { row << nil }    
    row << pretty_csv(self.val[sym][:ha][:sum])
    row << pretty_csv(self.val[sym][:total][:sum])
    self.Tcols[:ids].each do |id|
      row << pretty_csv(self.val[:cols][id][sym][:ha][:sum])
      row << pretty_csv(self.val[:cols][id][sym][:total][:sum])
    end
    csv_write(w, row)
  end
  
  def csv_total_by_types(w, model)
    sym = model.to_s.downcase.pluralize.to_sym
    row = []
    csv_put_tete(w, 'sous-total')
    for type in @types
      row << type.name
      2.times {row << nil}
      row << pretty_csv(self.val[sym][:ha][type.name])
      row << pretty_csv(self.val[sym][:total][type.name])
      self.Tcols[:ids].each do |id|
        row << pretty_csv(self.val[:cols][id][:charges][:ha][type.name])
        row << pretty_csv(self.val[:cols][id][:charges][:total][type.name])
      end
      csv_write(w, row)
      row.clear
    end
  end
  
  def csv_total_line(w, model)
    row = []
    title = 'total ' + model.to_s
    sym = model.to_s.to_sym
    csv_put_tete(w, title)
    (self.csv[:nb_row_before] - 2).times {row << nil}
    row << pretty_csv(self.Tcols[sym][:ha])
    row << pretty_csv(self.Tcols[sym][:total])    
    self.Tcols[:ids].each do |id|
      row << pretty_csv(self.Tcols[id][sym][:ha][:sum])
      row << pretty_csv(self.Tcols[id][sym][:total][:sum])
    end
    csv_write(w, row)
  end

  def csv_benefs(w)
    row = []
    csv_put_tete(w, 'Benefs')
    (self.csv[:nb_row_before] - 2).times { row << nil }    
    row << pretty_csv(self.Tcols[:benef][:ha])
    row << pretty_csv(self.Tcols[:benef][:total])
    self.Tcols[:ids].each do |id|
      row <<  pretty_csv(self.Tcols[id][:benef][:ha][:sum])
      row <<  pretty_csv(self.Tcols[id][:benef][:total][:sum])
    end
    csv_write(w, row)
  end
  
  def generate_csv(model)
    #self.info_debug = detail[:labour]
    csv_init
    
    date = Date.today.to_s
    file_name = date + '_' + model.to_s
    file = RAILS_ROOT + '/csv/' + file_name + '.csv'
    w = CSV.open(file, 'w')
    csv_tete(w)
    csv_charges(w, Labour, false, 0)
    csv_charges(w, Pulve, false, 0)
    csv_charges(w, Facture, true, 0)
    csv_total_line(w, 'charges')
    
    csv_charges(w, Vente, false, 0)
    csv_total_line(w, 'benef')
    
    
    csv_end(w)
  end
    
end

