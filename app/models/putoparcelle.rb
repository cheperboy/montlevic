class Putoparcelle < ActiveRecord::Base

  belongs_to :parcelle
  belongs_to :pulve
  belongs_to :saison
  
  validates_presence_of :parcelle_id
  # validates_presence_of :pulve_id
  # validates_numericality_of :pulve_id, :message => "n'est pas un nombre"
  validates_numericality_of :parcelle_id, :message => "n'est pas un nombre"
  # validates_presence_of :value
  # validates_numericality_of :value, :message => "n'est pas un nombre"

# Callbacks
  def before_save 
    self.saison ||= Saison.get_current
    self.value = 1
  end
  
# Finders
  def self.find_by_parcelle(parcelle_id, pulve_id)
    putoparcelle = Putoparcelle.find( :first, 
                :conditions => 
                  { :parcelle_id => parcelle_id, 
                    :pulve_id => pulve_id })
    return putoparcelle                   
  end

end
