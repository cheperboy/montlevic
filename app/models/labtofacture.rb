class Labtofacture < ActiveRecord::Base

  belongs_to :labour
  belongs_to :facture
  
  validates_presence_of :value

end
