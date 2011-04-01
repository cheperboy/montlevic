class Zonetopa < ActiveRecord::Base
  belongs_to :parcelle
  belongs_to :zone
  
  validates_presence_of :parcelle_id
  validates_presence_of :zone_id
  validates_presence_of :value
  validates_numericality_of :value, :message => "n'est pas un nombre"
  
  # TODO : ajouter la saison dans les conditions
  def self.find_by(zone_id, parcelle_id)
    Zonetopa.find( 
              :first, 
              :conditions => 
                { :zone_id => zone_id, 
                  :parcelle_id => parcelle_id })
  end

end
