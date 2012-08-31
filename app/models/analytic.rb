class Analytic < ActiveRecord::Base
  
  attr_accessor :saisons
  
  #iterators
  attr_accessor :colonnes_type, 
                :saison_colonne_type,
                :saison_colonne_type_sections,
                :lines_type, 
                :lines_type_sections, 
                :other_lines_type,
                :other_lines_type_sections,
                :costs_type

  def to_json(options = {})
    super
  end

  def as_json(options = nil) #:nodoc:
    hash = Serializer.new(self, options).serializable_record
    hash = { self.class.model_name.element => hash } if include_root_in_json
    hash
  end

  def from_json(json)
    self.attributes = ActiveSupport::JSON.decode(json)
    self
  end

  def initialize
    #for test only
    current_saison_id = Setting.get_saison_id
    current_saison = Setting.get_saison

    # init iterators
    self.colonnes_type = [:parcelles, :zones, :typecultures]
    self.saison_colonne_type = [:sum]
    self.saison_colonne_type_sections = [:total_charges, :benef ] # Sections only for :sum
    self.lines_type = [:labours, :putoproduits, :pulves, :factures, :ventes]
    self.other_lines_type = [:resultats]
    self.costs_type = [:ha, :total]
    
    self.other_lines_type_sections = {}
    self.other_lines_type_sections[:resultats] = [:total_labours, :total_pulves, :total_putoproduits, :total_factures, :total_ventes,
                                            :total_charges, :benef ]
    self.lines_type_sections = {}
    self.lines_type_sections[:putoproduits] = [:all, :category]
    self.lines_type_sections[:pulves] = [:all, :category]
    self.lines_type_sections[:labours] = [:all, :category]
    self.lines_type_sections[:ventes] = [:all, :category]
    self.lines_type_sections[:factures] = [:all, :category, :factcat, :produits]
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
      
      # colonne "saison" appelee avec ses sections (total_charges, :benef)
      saison_colonne_type.each do |saison_col_type| # :sum
        saisons[saison.id][saison_col_type] = {}
        saison_colonne_type_sections.each do |section|
          saisons[saison.id][saison_col_type][section] = {}
          costs_type.each do |cost|
            saisons[saison.id][saison_col_type][section][cost] = 0
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
    self.saisons[saison.id][:datas] = 0
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
    self.saisons[saison_id][col_type][col_id][:datas] = {}
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

  # lignes resultats de la saison communs a toutes les colonnes (total_facture, total_labours, ..., benef)
  def init_other_line_type_for_saison(saison_id, other_line_type)
    self.saisons[saison_id][other_line_type] = {}
    self.other_lines_type_sections[other_line_type].each do |other_section|
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
  
  #pour chaque colonne, categories et types de chaque type de ligne (labours.categories, factures.types, ...)
  def init_sections(saison, col_type, col_id, line_type)
    # self.saisons[saison_id][col_type][col_id][line_type][section] = {} 

    # les deux lignes suivantes permettent d'appeler les categories de produits 
    # lorsqu'on itere les pulves (au lieu d'appeler les categories de pulve)
    category = line_type.to_s.singularize
    category = "produit" if line_type.eql?(:pulves)    
    Category.send("root_#{category}").descendants.each do |cat|
      self.saisons[saison.id][col_type][col_id][line_type][:category][cat.id] = {} 
      self.saisons[saison.id][col_type][col_id][line_type][:category][cat.id][:ha] = 0
      self.saisons[saison.id][col_type][col_id][line_type][:category][cat.id][:total] = 0
      self.saisons[saison.id][col_type][col_id][line_type][:category][cat.id][:name] = cat.name
    end
    unless saison.send(line_type).nil?
      saison.send(line_type).each do |line|
        self.saisons[saison.id][col_type][col_id][line_type][:all][line.id] = {} 
        self.saisons[saison.id][col_type][col_id][line_type][:all][line.id][:ha] = 0
        self.saisons[saison.id][col_type][col_id][line_type][:all][line.id][:total] = 0
      end
    end
    if line_type.eql?(:factures)
      Category.get_factcats.each do |factcat|
        self.saisons[saison.id][col_type][col_id][line_type][:factcat][factcat.id] = {}
        self.saisons[saison.id][col_type][col_id][line_type][:factcat][factcat.id][:ha] = 0
        self.saisons[saison.id][col_type][col_id][line_type][:factcat][factcat.id][:total] = 0
        self.saisons[saison.id][col_type][col_id][line_type][:factcat][factcat.id][:name] = factcat.name
      end
    end
  end
  
  #commun a chaque colonne, categories et types de chaque type de lingne 
  def init_sections_for_saison(saison, line_type)
    # self.saisons[saison_id][col_type][col_id][line_type][section] = {} 
    category = line_type.to_s.singularize
    category = "produit" if line_type.eql?(:pulves)    
    Category.send("root_#{category}").descendants.each do |cat|
      self.saisons[saison.id][line_type][:category][cat.id] = {} 
      self.saisons[saison.id][line_type][:category][cat.id][:ha] = 0
      self.saisons[saison.id][line_type][:category][cat.id][:total] = 0
      self.saisons[saison.id][line_type][:category][cat.id][:name] = cat.name
    end
    unless saison.send(line_type).nil?
      saison.send(line_type).each do |line|
        self.saisons[saison.id][line_type][:all][line.id] = {} 
        self.saisons[saison.id][line_type][:all][line.id][:ha] = 0
        self.saisons[saison.id][line_type][:all][line.id][:total] = 0
        self.saisons[saison.id][line_type][:all][line.id][:data] = {}
      end
    end
    if line_type == :factures
      Category.get_factcats.each do |factcat|
        self.saisons[saison.id][line_type][:factcat][factcat.id] = {} 
        self.saisons[saison.id][line_type][:factcat][factcat.id][:ha] = 0
        self.saisons[saison.id][line_type][:factcat][factcat.id][:total] = 0
        self.saisons[saison.id][line_type][:factcat][factcat.id][:name] = factcat.name
      end 
      # Init lines_type_sections produits (stock, used, ..) for Facture (for saison colone only)
      self.saisons[saison.id][line_type][:produits][:stock] = {}
      self.saisons[saison.id][line_type][:produits][:quantite] = {}
      self.saisons[saison.id][line_type][:produits][:used] = {}
      self.saisons[saison.id][line_type][:produits][:stock][:total] = 0 
      self.saisons[saison.id][line_type][:produits][:stock][:ha] = 0
      self.saisons[saison.id][line_type][:produits][:quantite][:total] = 0
      self.saisons[saison.id][line_type][:produits][:quantite][:ha] = 0
      self.saisons[saison.id][line_type][:produits][:used][:total] = 0
      self.saisons[saison.id][line_type][:produits][:used][:ha] = 0
    end    
  end

  def set_saison_datas(s_id, datas)
    self.saisons[s_id][:datas] = datas
  end
  def get_saison_datas(s_id, data)
    self.saisons[s_id][:datas][data]
  end

  def set_colonne_datas(s_id, col_type, col_id, datas)
    self.saisons[s_id][col_type][col_id][:datas] = datas
  end
  def get_colonne_datas(s_id, col_type, col_id, data)
    self.saisons[s_id][col_type][col_id][:datas][data]
  end

  def set_saison_line_datas(s_id, line_type, line_id, datas)
    self.saisons[s_id][line_type][:all][line_id][:datas] = datas
  end
  def get_saison_line_datas(s_id, line_type, line_id)
    self.saisons[s_id][line_type][:all][line_id][:datas]
  end
  
  def set_saison_line(s_id, line_type, section, line_id, cost, value)
    self.saisons[s_id][line_type][section][line_id][cost] = value
  end
  def add_saison_line(s_id, line_type, section, line_id, cost, value)
    self.saisons[s_id][line_type][section][line_id][cost] += value
    #           @sid, :factures, :category,cat.id, :total += facture.get_cout_total)
  end
  def get_saison_line(s_id, line_type, section, line_id, cost)
    self.saisons[s_id][line_type][section][line_id][cost]
  end
  
  def set_line(s_id, col_type, col_id, line_type, section, line_id, cost, value)
    self.saisons[s_id][col_type][col_id][line_type][section][line_id][cost] = value
  end
  def add_line(s_id, col_type, col_id, line_type, section, line_id, cost, value)
    self.saisons[s_id][col_type][col_id][line_type][section][line_id][cost] += value
  end
  def get_line(s_id, col_type, col_id, line_type, section, line_id, cost)
    self.saisons[s_id][col_type][col_id][line_type][section][line_id][cost]
  end

  def set_other_line(s_id, col_type, col_id, line_type, section, cost, value)
    self.saisons[s_id][col_type][col_id][line_type][section][cost] = value
  end
  def add_other_line(s_id, col_type, col_id, line_type, section, cost, value)
    self.saisons[s_id][col_type][col_id][line_type][section][cost] += value
  end
  def get_other_line(s_id, col_type, col_id, line_type, section, cost)
    self.saisons[s_id][col_type][col_id][line_type][section][cost]
  end

  def set_other_line_for_saison(s_id, line_type, section, cost, value)
    self.saisons[s_id][line_type][section][cost] = value
  end
  def add_other_line_for_saison(s_id, line_type, section, cost, value)
    self.saisons[s_id][line_type][section][cost] += value
  end
  def get_other_line_for_saison(s_id, line_type, section, cost)
    self.saisons[s_id][line_type][section][cost]
  end

  def set_saison_section(s_id, saison_colonne_type, saison_colonne_type_section, cost, value)
    saisons[s_id][saison_col_type][saison_colonne_type_section][cost] = value
  end
  def add_saison_section(s_id, saison_colonne_type, saison_colonne_type_section, cost, value)
    saisons[s_id][saison_col_type][saison_colonne_type_section][cost] += value
  end
  def get_saison_section(s_id, saison_colonne_type, saison_colonne_type_section, cost)
    saisons[s_id][saison_col_type][saison_colonne_type_section][cost]
  end
  
end

