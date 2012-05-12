class Parcelle < ActiveRecord::Base

  belongs_to :typeculture
  belongs_to :saison
  
  has_many :zones, :through => :zonetopas
  has_many :zonetopas, :dependent => :destroy

  has_many :labtoparcelles
  has_many :labours, :through => :labtoparcelles

  has_many :putoparcelles
  has_many :pulves, :through => :putoparcelles

  has_many :ventoparcelles
  has_many :ventes, :through => :ventoparcelles

  has_many :factoparcelles
  has_many :factures, :through => :factoparcelles

  accepts_nested_attributes_for :zonetopas, :allow_destroy => true

  validates_uniqueness_of   :code, :scope => :saison_id, :message => "ce code est deja pris"
  validates_presence_of     :name
  validates_presence_of     :surface
  validates_numericality_of :surface, :message => "n'est pas un nombre"
  validates_associated      :zonetopas

# ----- Finders -----

  named_scope :scope_by_saison,
    :conditions => {:saison_id => Setting.get_saison_id}

  # ATTENTION utiliser comme suit : saison_20XX.parcelles.find_by_code("the_code")
  def self.find_by_code(code)
    self.find(:first, :conditions => ["code = ?", code])
  end

  def self.find_for_saison()
    saison = Setting.get_saison
    if saison.parcelles.size == 0
      return nil
    end
    return saison.parcelles
  end

  def self.find_by_saison(*args)
    with_scope(:find =>
                {:conditions => ["saison_id = ?", Setting.get_saison_id], :order => :typeculture_id }) do
        find(*args)
      end
  end
 
  def self.find_by_zone(zone_id)
    parcelles = []
    zonetopas = Zonetopa.find(:all, :conditions => ["zone_id = ?", zone_id])
    zonetopas.each do |zonetopa|
      if zonetopa.parcelle.saison_id == Setting.get_saison_id
        parcelles << zonetopa.parcelle
      end
    end
    return parcelles
  end

  # retourne les parcelles de la saison courante du type de culture donne
  def self.get_parcelles_from_culture(culture)
    parcelles = culture.parcelles.select {|p| p.saison_id.eql?(Setting.get_saison_id) }
  end

  
# ----- Methodes -----

  def name_and_culture
    @name_and_culture = name + " - " + typeculture.name + " - " + surface.to_s + " Ha" 
  end

  def name_for_select
    @name_for_select = "Parcelle :: " + name + " - " + typeculture.name + " - " + surface.to_s + " Ha" 
  end
    
  #retourne la somme des surface d'un tableau de parcelles
  def self.sum_surfaces(parcelles)
    s=0
    parcelles.each do |parcelle| 
      s = s + parcelle.surface
    end
    s
  end
  
  def percent_of_zone(zone_id)
    zone = Zone.find(zone_id)
    zonetopa = Zonetopa.find_by(zone_id, self.id)
    percent = zonetopa.value * 100 / self.surface
    return percent
  end

end
