class Zonetopa < ActiveRecord::Base
  belongs_to :parcelle
  belongs_to :zone
  
  validates_presence_of :value
  
  # TODO : ajouter la saison dans les conditions
  def self.find_by(zone_id, parcelle_id)
    Zonetopa.find( 
              :first, 
              :conditions => 
                { :zone_id => zone_id, 
                  :parcelle_id => parcelle_id })
  end

end
