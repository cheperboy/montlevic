class Typeculture < ActiveRecord::Base

  has_many :parcelles
  
  validates_presence_of :name
  
  def name_for_select
    @name_for_select = "Typeculture :: " + name + " - " + " - " + surface.to_s + " Ha" 
  end

#########################
#
#
#
# self.find_by_code(code) ne prend pas en compte 
# la saison et ne devrait jamais etre appelee
#
#
#
#
#
  def self.find_by_code(code)
    self.find(:first, :conditions => ["code = ?", code])
  end  

  def self.find_by_code_for_saison(code)
    self.find(:first, :conditions => ["code = ?", code])
  end  
  
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
    surfaces = 0
    self.parcelles.find_by_saison(:all).each {|parcelle| surfaces += parcelle.surface}
    surfaces
  end
    
  def parcelles_count
    return self.parcelles.find_by_saison(:all).count
  end

  # retourne un hash avec un tableau de cultures ret[:typecultures]
  # et un tableau de parcelles ret[:parcelles] = []
  def self.get_typecultures_from_parcelle_array(parcelles)
    ret = {}
    ret[:typecultures] = []
    ret[:parcelles] = []
    Typeculture.find_for_saison.each do |culture|
      culture_temp = culture
      parcelles_temp = parcelles
      if ((parcelles_temp & culture_temp.parcelles) == culture_temp.parcelles)
        ret[:typecultures] << culture_temp
        culture_temp -= parcelles_temp
      end
      ret[:parcelles] = culture_temp.parcelles
    end
    ret
  end

end
