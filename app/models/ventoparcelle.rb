class Ventoparcelle < ActiveRecord::Base

  belongs_to :parcelle
  belongs_to :vente
  
  validates_presence_of :value


  def self.find_by_parcelle(parcelle_id, vente_id)
    ventoparcelle = Ventoparcelle.find( 
                      :first, 
                      :conditions => 
                        { :parcelle_id => parcelle_id, 
                          :vente_id => vente_id })
    return ventoparcelle                   
  end
  
end
