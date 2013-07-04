class Factoparcelle < ActiveRecord::Base

  belongs_to :parcelle
  belongs_to :facture
  belongs_to :saison
  
  # validates_presence_of :value
  # validates_numericality_of :value, :message => "n'est pas un nombre"

# Callbacks
  def before_save 
    self.saison ||= Saison.find(Thread.current[:current_saison_id])
    self.value = 1
  end
  
  def self.find_by_parcelle(parcelle_id, facture_id)
    factoparcelle = Factoparcelle.find( 
                      :first, 
                      :conditions => 
                        { :parcelle_id => parcelle_id, 
                          :facture_id => facture_id })
    return factoparcelle                   
  end
  
end
