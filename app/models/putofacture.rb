class Putofacture < ActiveRecord::Base

  belongs_to :facture
  belongs_to :pulve
  
  validates_presence_of :value, :message => "valeur non definie"
  validates_numericality_of :value, :message => "n'est pas un nombre"

end
