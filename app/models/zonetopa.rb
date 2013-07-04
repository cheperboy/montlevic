class Zonetopa < ActiveRecord::Base

  belongs_to :parcelle
  belongs_to :zone
  belongs_to :saison
  
  validates_presence_of :zone_id
  validates_presence_of :value
  validates_numericality_of :value, :message => "n'est pas un nombre"
  
# Callbacks
  def before_save 
    self.saison ||= Saison.find(Thread.current[:current_saison_id])
  end

  # TODO : ajouter la saison dans les conditions
  def self.find_by(zone_id, parcelle_id)
    Zonetopa.find( 
              :first, 
              :conditions => 
                { :zone_id => zone_id, 
                  :parcelle_id => parcelle_id })
  end

end
