class Labtoparcelle < ActiveRecord::Base

  belongs_to :labour
  belongs_to :parcelle
  belongs_to :saison
  
  # validates_presence_of :value
  # validates_numericality_of :value, :message => "n'est pas un nombre"

# Callbacks
  def before_save 
    self.saison ||= Setting.find(1).saison
    self.value = 1
  end

  def self.find_by_parcelle(parcelle_id, labour_id)
    labtoparcelle = Labtoparcelle.find( :first, 
                :conditions => 
                  { :parcelle_id => parcelle_id, 
                    :labour_id => labour_id })
    return labtoparcelle                   
  end
  
end
