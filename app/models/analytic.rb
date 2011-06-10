class Analytic < ActiveRecord::Base
  
  attr_accessor :saisons
  
  #iterators
  attr_accessor :colonnes_type, 
                :other_colonnes_type,
                :lines_type, 
                :lines_type_sections, 
                :other_lines_type,
                :other_lines_type_sections,
                :costs_type

  def initialize
    #for test only
    current_saison_id = Setting.find(:first).saison_id
    current_saison = Saison.find(current_saison_id)

    # init iterators
    self.colonnes_type = [:parcelles, :zones, :typecultures]
    self.other_colonnes_type = [:sum]
    self.lines_type = [:labours, :pulves, :factures, :ventes]
    self.other_lines_type = [:resultats]
    self.costs_type = [:ha, :total]
    
    self.other_lines_type_sections = {}
    self.other_lines_type_sections[:resultats] = [:total_labours, :total_pulves, :total_factures, :total_ventes,
                                            :total_charges, :benef ]
    self.lines_type_sections = {}
    self.lines_type_sections[:pulves] = [:all, :category]
    self.lines_type_sections[:labours] = [:all, :category]
    self.lines_type_sections[:ventes] = [:all, :category]
    self.lines_type_sections[:factures] = [:all, :category, :factcat]
    # end of init iterators
    
    self.saisons = []
    # Saison.find(:all).each do |saison|
    Saison.find([current_saison_id]).each do |saison|
      init_saison(saison)
      
      colonnes_type.each do |col_type| # :parcelles, :zones, :typecultures
        # self.saisons[saison.id][col_type]
        init_colonne_type(saison.id, col_type)
        
        saison.send(col_type).each do |colonne| #each parcelle_id, each zone_id, ...
          # self.saisons[saison.id][col_type][col_id]
          init_colonne(saison.id, col_type, colonne.id)
          
          lines_type.each do |line_type| # :labours, :pulves, :factures
            init_line_type(saison.id, col_type, colonne.id, line_type)
            init_sections(saison, col_type, colonne.id, line_type)
          end
          other_lines_type.each do |other_line_type| # :resultats
            init_other_line_type(saison.id, col_type, colonne.id, other_line_type)
          end
        end
      end
    end
    Saison.find(:all).each do |s|
      # logger.error "yaml self.saisons[#{s.id}] : " + self.saisons[s.id].to_yaml
    end
  end
  
  # self.saisons[s][:col_type][col.id][:labours][:ha][:sum]
  def init_saison(saison)
    self.saisons[saison.id] = {}
    lines_type.each do |line_type| # :labours, :pulves, :factures
      init_line_type_for_saison(saison.id, line_type)
      init_sections_for_saison(saison, line_type)
    end
    other_lines_type.each do |other_line_type| # :resultats
      init_other_line_type_for_saison(saison.id, other_line_type)
    end
  end
  
  def init_colonne_type(saison_id, col_type)
    self.saisons[saison_id][col_type] = {}
  end
  
  def init_colonne(saison_id, col_type, col_id)
    self.saisons[saison_id][col_type][col_id] = {}
  end
  
  # pour chaque colonne init line puis section de chaque line
  def init_line_type(saison_id, col_type, col_id, line_type)
    self.saisons[saison_id][col_type][col_id][line_type] = {}
    self.lines_type_sections[line_type].each do |section|
      self.saisons[saison_id][col_type][col_id][line_type][section] = {} 
    end
  end
  
  # resultats de chaques colonnes (total_facture, total_labours, ..., benef)
  def init_other_line_type(saison_id, col_type, col_id, other_line_type)
    self.saisons[saison_id][col_type][col_id][other_line_type] = {}
    self.other_lines_type_sections[other_line_type].each do |other_section|
      self.saisons[saison_id][col_type][col_id][other_line_type][other_section] = {} 
      self.saisons[saison_id][col_type][col_id][other_line_type][other_section][:ha] = 0
      self.saisons[saison_id][col_type][col_id][other_line_type][other_section][:total] = 0
    end
  end

  # champs resultats de la saison communs a toutes les colonnes (total_facture, total_labours, ..., benef)
  def init_other_line_type_for_saison(saison_id, other_line_type)
    self.saisons[saison_id][other_line_type] = {}
    self.other_lines_type_sections[other_line_type].each do |other_section|
      #total_facture, _total_labours, ..., benef
      self.saisons[saison_id][other_line_type][other_section] = {} 
      self.saisons[saison_id][other_line_type][other_section][:ha] = 0
      self.saisons[saison_id][other_line_type][other_section][:total] = 0
    end
  end
  
  # champs commun a chaque colonne (date du labour, cout total du labour, cad notamment les champs de la db)
  def init_line_type_for_saison(saison_id, line_type)
    self.saisons[saison_id][line_type] = {}
    self.lines_type_sections[line_type].each do |section|
      self.saisons[saison_id][line_type][section] = {} # section : category, all, factcat
    end
  end
  
  #pour chaque colonne, categories et types de chaque type de lingne (labours.categories, factures.types, ...)
  def init_sections(saison, col_type, col_id, line_type)
    # self.saisons[saison_id][col_type][col_id][line_type][section] = {} 
    Category.send(line_type).each do |cat|
      self.saisons[saison.id][col_type][col_id][line_type][:category][cat.id] = {} 
      self.saisons[saison.id][col_type][col_id][line_type][:category][cat.id][:ha] = 0
      self.saisons[saison.id][col_type][col_id][line_type][:category][cat.id][:total] = 0
      self.saisons[saison.id][col_type][col_id][line_type][:category][cat.id][:name] = cat.name
    end
    saison.send(line_type).each do |line|
      self.saisons[saison.id][col_type][col_id][line_type][:all][line.id] = {} 
      self.saisons[saison.id][col_type][col_id][line_type][:all][line.id][:ha] = 0
      self.saisons[saison.id][col_type][col_id][line_type][:all][line.id][:total] = 0
      # TODO remplacer line.name par {} pour y stocker les champs de la db
      self.saisons[saison.id][col_type][col_id][line_type][:all][line.id][:data] = line.name
    end
    if line_type == :factures
      Factcat.all.each do |factcat|
        self.saisons[saison.id][col_type][col_id][line_type][:factcat][factcat.id] = {} 
        self.saisons[saison.id][col_type][col_id][line_type][:factcat][factcat.id][:ha] = 0
        self.saisons[saison.id][col_type][col_id][line_type][:factcat][factcat.id][:total] = 0
        self.saisons[saison.id][col_type][col_id][line_type][:factcat][factcat.id][:name] = factcat.name
      end 
    end    
  end
  
  #commun a chaque colonne chaque colonne, categories et types de chaque type de lingne 
  def init_sections_for_saison(saison, line_type)
    # self.saisons[saison_id][col_type][col_id][line_type][section] = {} 
    Category.send(line_type).each do |cat|
      self.saisons[saison.id][line_type][:category][cat.id] = {} 
      self.saisons[saison.id][line_type][:category][cat.id][:ha] = 0
      self.saisons[saison.id][line_type][:category][cat.id][:total] = 0
      self.saisons[saison.id][line_type][:category][cat.id][:name] = cat.name
    end
    saison.send(line_type).each do |line|
      self.saisons[saison.id][line_type][:all][line.id] = {} 
      self.saisons[saison.id][line_type][:all][line.id][:ha] = 0
      self.saisons[saison.id][line_type][:all][line.id][:total] = 0
      # TODO remplacer line.name par {} pour y stocker les champs de la db
      self.saisons[saison.id][line_type][:all][line.id][:data] = {}
    end
    if line_type == :factures
      Factcat.all.each do |factcat|
        self.saisons[saison.id][line_type][:factcat][factcat.id] = {} 
        self.saisons[saison.id][line_type][:factcat][factcat.id][:ha] = 0
        self.saisons[saison.id][line_type][:factcat][factcat.id][:total] = 0
        self.saisons[saison.id][line_type][:factcat][factcat.id][:name] = factcat.name
      end 
    end    
  end

  def set_saison_line_datas(s_id, line_type, line_id, datas)
    s_id=2
    self.saisons[s_id][line_type][:all][line_id][:datas] = datas
  end
  def get_saison_line_datas(s_id, line_type, line_id)
    s_id=2
    self.saisons[s_id][line_type][:all][line_id][:datas]
  end
  
  def set_saison_line(s_id, line_type, line_id, cost, value)
    s_id=2
    self.saisons[s_id][line_type][:all][line_id][cost] = value
  end
  def get_saison_line(s_id, line_type, line_id, cost)
    self.saisons[s_id][line_type][:all][line_id][cost]
  end
  
  def set_line(s_id, col_type, col_id, line_type, line_id, cost, value)
    s_id=2
    self.saisons[s_id][col_type][col_id][line_type][:all][line_id][cost] = value
  end

  def set_colonne(saison_id, colonne_type, colonne_id, datas)
    if saisons[saison_id]
      if saisons[saison_id][colonne_type.to_sym]
        if saisons[saison_id][colonne_type.to_sym][colonne_id]
          saisons[saison.id][colonne_type.to_sym][colonne_id] = datas
          return true
        end
      end
    end
    return false
  end
  
  def get_colonne(saison_id, colonne_type, colonne_id)
    if res.saisons[saison_id]
      if res.saisons[saison_id][colonne_type.to_sym]
        if res.saisons[saison_id][colonne_type.to_sym][colonne_id]
          return res.saisons[saison.id][colonne_type.to_sym][colonne_id]
        end
      end
    else
      logger.error 'Analytic.Res.saisons... not valid in get_colonne()'
      return nil
    end
  end

end

