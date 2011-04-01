class Ventoparcelle < ActiveRecord::Base

  belongs_to :parcelle
  belongs_to :vente
  
  validates_presence_of :value
  validates_presence_of :vente_id
  validates_presence_of :parcelle_id

  validates_presence_of :value
  validates_numericality_of :value, :message => "n'est pas un nombre"

  def self.find_by_parcelle(parcelle_id, vente_id)
    ventoparcelle = Ventoparcelle.find( 
                      :first, 
                      :conditions => 
                        { :parcelle_id => parcelle_id, 
                          :vente_id => vente_id })
    return ventoparcelle                   
  end
  
end
