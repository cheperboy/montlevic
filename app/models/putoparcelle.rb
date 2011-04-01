class Putoparcelle < ActiveRecord::Base

  belongs_to :parcelle
  belongs_to :pulve
  
  validates_presence_of :value
  validates_numericality_of :value, :message => "n'est pas un nombre"

  def self.find_by_parcelle(parcelle_id, pulve_id)
    putoparcelle = Putoparcelle.find( :first, 
                :conditions => 
                  { :parcelle_id => parcelle_id, 
                    :pulve_id => pulve_id })
    return putoparcelle                   
  end

end
