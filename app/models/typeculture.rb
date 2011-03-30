class Typeculture < ActiveRecord::Base

  has_many :parcelles

  def self.find_for_saison()
    typeculture_ids = []
    typecultures = []
    parcelles = Parcelle.find_by_saison(:all)
    unless parcelles.size == 0
      parcelles.each do |parcelle|
         typeculture_ids << parcelle.typeculture
      end
      typeculture_ids = typeculture_ids.uniq
    end
    if typeculture_ids.size == 0
      return nil
    end
    typeculture_ids.each do |id|
      typeculture = Typeculture.find(id)
      typecultures << typeculture
    end
    return typecultures
  end
  
  def surface
    surfaces=0
    Parcelle.find_by_saison(:all).each do |parcelle|
      if self.parcelles.find(:all, :conditions => {:saison_id =>  Application::SAISON}).include?(parcelle)
        surfaces+=parcelle.surface
      end
    end
    return surfaces
  end
    
end
