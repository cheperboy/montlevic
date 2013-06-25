class Ventoproduit < ActiveRecord::Base

# doit etre lie a une vente de type Avoir et a un produit.
# la valeure ventoproduit.vlaue sera deduite du prix d'achat du produit dans le calcul de cout unitaire du porduit
# evolution possible: lier ce model a n facture pour meilleure tracabilite

# ----- Model -----

  belongs_to :saison
  belongs_to :vente
  belongs_to :produit
# facture a ajouter eventuellement pour lier l'avoir a une facture
#  belongs_to :facture
  
# ----- Validations -----
  
  validates_presence_of :value, :message => "la valeure doit etre definie"
  validates_numericality_of :value, :message => "n'est pas un nombre"

  validates_presence_of :quantite, :message => "indiquer le dosage ou la quantite ou cocher destocker",
                        :if => Proc.new { |u| (u.dosage.blank? && u.destocker.eql?(0)) }
  
  # Callbacks
  def before_save 
    self.saison ||= Setting.find(1).saison
  end
  
  

end