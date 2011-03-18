class Putofacture < ActiveRecord::Base

  belongs_to :facture
  belongs_to :pulve
  
  validates_presence_of :value

end
