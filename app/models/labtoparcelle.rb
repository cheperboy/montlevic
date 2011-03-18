class Labtoparcelle < ActiveRecord::Base

  belongs_to :labour
  belongs_to :parcelle
  
  validates_presence_of :value
  
  def self.find_by_parcelle(parcelle_id, labour_id)
    labtoparcelle = Labtoparcelle.find( :first, 
                :conditions => 
                  { :parcelle_id => parcelle_id, 
                    :labour_id => labour_id })
    return labtoparcelle                   
  end
  
end
