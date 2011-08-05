class Protofacture < ActiveRecord::Base

  belongs_to :facture
  belongs_to :produit
  
  validates_presence_of :quantite, :message => "valeur non definie"
  validates_numericality_of :quantite, :message => "n'est pas un nombre"
  validates_presence_of :prix, :message => "valeur non definie"
  validates_numericality_of :prix, :message => "n'est pas un nombre"

  def validate
    errors.add("quantite", "quantite ne doit pas etre nul") if quantite == 0
    errors.add("Prix", "Prix ne doit pas etre nul") if prix == 0
  end

end
