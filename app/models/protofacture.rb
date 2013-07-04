class Protofacture < ActiveRecord::Base

  belongs_to :facture
  belongs_to :produit
  belongs_to :saison
  
  validates_presence_of :quantite, :message      => "valeur non definie"
  validates_numericality_of :quantite, :message  => "n'est pas un nombre"
  validates_presence_of :prix_unit, :message     => "valeur non definie"
  validates_numericality_of :prix_unit, :message => "n'est pas un nombre"

  def validate
    errors.add("quantite", "quantite ne doit pas etre nul") if quantite == 0
    errors.add("Prix", "Prix ne doit pas etre nul") if prix_unit == 0
  end

  def before_save 
    self.saison ||= Saison.get_current
  end
  
  def get_used
    if stock > quantite
      logger.error " !!! ERROR !!! protofacture.rb : protofac #{self.id} (#{self.produit.name}, facture #{facture.id})"
      logger.error "quantite: #{self.quantite}\tstock: #{self.stock}"
    end
    return (quantite - stock)
  end

end
