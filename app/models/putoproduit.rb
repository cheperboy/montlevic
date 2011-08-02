class Putoproduit < ActiveRecord::Base

  belongs_to :produit
  belongs_to :pulve
  
  validates_presence_of :value, :message => "valeur non definie"
  validates_numericality_of :value, :message => "n'est pas un nombre"

end
