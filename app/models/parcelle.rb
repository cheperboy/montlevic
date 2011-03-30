class Parcelle < ActiveRecord::Base

  belongs_to :typeculture
  belongs_to :saison
  
  has_many :zones, :through => :zonetopas
  has_many :zonetopas, :dependent => :destroy

  has_many :labtoparcelles
  has_many :labours, :through => :labtoparcelles

  has_many :putoparcelles
  has_many :pulves, :through => :putoparcelles

  has_many :factoparcelles
  has_many :factures, :through => :factoparcelles

  accepts_nested_attributes_for :zonetopas, :allow_destroy => true

  validates_presence_of :name
  validates_presence_of :surface
  validates_associated :zonetopas

# ----- Finders -----

  def self.find_for_saison()
    saison = Saison.find(Setting.find(:first).saison_id)
    if saison.parcelles.size == 0
      return nil
    end
    return saison.parcelles
  end

  def self.find_by_saison(*args)
    with_scope(:find => 
                {:conditions => ["saison_id = ?", Setting.find(:first).saison_id] }) do
        find(*args)
      end
  end
 
  def self.find_by_zone(zone_id)
    parcelles = []
    zonetopas = Zonetopa.find(:all, :conditions => ["zone_id = ?", zone_id])
    zonetopas.each do |zonetopa|
      if zonetopa.parcelle.saison_id == Setting.find(:first).saison_id
        parcelles << zonetopa.parcelle
      end
    end
    return parcelles
  end
  
# ----- Methodes -----

  def name_and_culture
    @name_and_culture = name + " - " + typeculture.name + " - " + surface.to_s + " Ha" 
  end
  
  #retourne la somme des surface d'un jeu de parcelles
  def sum_surfaces(parcelles)
    s=0
    parcelles.each do |parcelle| 
      s = s + parcelle.surface
    end
    s
  end
  
  #TODO : ajouter find_by_saison
  def self.all_surfaces()
    s=0
    Parcelle.find(:all).each do |parcelle| 
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

  def percent_of_zone(zone_id)
    zone = Zone.find(zone_id)
    zonetopa = Zonetopa.find_by(zone_id, self.id)
    percent = zonetopa.value * 100 / self.surface
    return percent
  end

end
