class Labtofacture < ActiveRecord::Base

  belongs_to :labour
  belongs_to :facture
  
  validates_presence_of :value
  validates_numericality_of :value, :message => "n'est pas un nombre"

end
