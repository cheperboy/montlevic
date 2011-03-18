class Factoparcelle < ActiveRecord::Base

  belongs_to :parcelle
  belongs_to :facture
  
  validates_presence_of :value


  def self.find_by_parcelle(parcelle_id, facture_id)
    factoparcelle = Factoparcelle.find( 
                      :first, 
                      :conditions => 
                        { :parcelle_id => parcelle_id, 
                          :facture_id => facture_id })
    return factoparcelle                   
  end
  
end
