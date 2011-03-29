class Zone < ActiveRecord::Base
  
  has_many :parcelles, :through => :zonetopas
  has_many :zonetopas

  validates_presence_of :name
  validates_presence_of :surface

  def self.find_for_saison()
    zones = []
    parcelles = Parcelle.find_by_saison(:all)
    unless parcelles.size == 0
      parcelles.each do |parcelle|
        parcelle.zones.each do |zone|
         zones << zone
        end
      end
    end
    if zones.size == 0
      return nil
    end
    return zones.uniq
  end

  def self.find_for_saison_OLD()
    za = Zone.find(1)
    zb = Zone.find(4)
    zones = []
    zones << za
    zones << zb
    return zones
  end

  def find_parcelles()
    Parcelle.find(:all, :conditions => [:saison_id => session[:saison_id]])
  end
  
  def self.find_by_parcelle(parcelle_id)
    zones = []
    zonetopas = Zonetopa.find(:all, :conditions => ["parcelle_id = ?", parcelle_id])
    zonetopas.each do |zonetopa|
      zones << zonetopa.zone
    end
    return zones
  end
 
end
