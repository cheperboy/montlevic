class Ventoparcelle < ActiveRecord::Base

  belongs_to :parcelle
  belongs_to :vente
  belongs_to :saison

  # validates_presence_of :value
  # validates_numericality_of :value, :message => "n'est pas un nombre"

  # Callbacks
  def before_save 
    self.saison ||= Saison.get_current
    self.value = 1
  end
   
# Finders
  def self.find_by_parcelle(parcelle_id, vente_id)
    ventoparcelle = Ventoparcelle.find( 
                      :first, 
                      :conditions => 
                        { :parcelle_id => parcelle_id, 
                          :vente_id => vente_id })
    return ventoparcelle                   
  end
  
end
