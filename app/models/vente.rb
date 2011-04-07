class Vente < Charge

  has_many :parcelles, :through => :ventoparcelles
  has_many :ventoparcelles, :dependent => :destroy

  belongs_to :category
  belongs_to :user
  belongs_to :saison
  
  accepts_nested_attributes_for :ventoparcelles, :allow_destroy => true

  validates_presence_of :name
  validates_presence_of :category
  validates_presence_of :user
  validates_presence_of :prix
  validates_numericality_of :prix, :message => "n'est pas un nombre"

  validates_associated :ventoparcelles


  def get_cout_ha
    return (self.get_cout_total / self.sum_surfaces)  
  end
  
  # retourne le prix total de cette vente
  def get_cout_total
    return (self.prix)
  end


end
