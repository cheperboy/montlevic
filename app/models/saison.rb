class Saison < ActiveRecord::Base

  validates_presence_of :name

  has_many :parcelles
  has_many :labours
  has_many :pulves
  has_many :factures
  has_many :ventes
  has_many :reportables

  has_one :setting    

  def typecultures
    typecultures = []
    parcelles = self.parcelles
    unless parcelles.size == 0
      parcelles.each do |parcelle|
        typecultures << parcelle.typeculture.id
      end
      typecultures = typecultures.uniq
    end
    return nil if typecultures.size == 0
    typecultures
  end
  
  def zones
    zones = []
    parcelles = self.parcelles
    unless parcelles.size == 0
      parcelles.uniq.each do |parcelle|
        parcelle.zones.each do |zone|
          zones << zone.id
        end
      end
      zones = zones.uniq
    end
    return nil if zones.size == 0
    zones
  end

end
