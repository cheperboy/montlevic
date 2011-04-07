class Pulve < Charge

# ----- Model -----

  belongs_to :category
  belongs_to :user
  belongs_to :saison
  
  has_many :parcelles, :through => :putoparcelles
  has_many :putoparcelles, :dependent => :destroy
  
  has_many :factures, :through => :putofactures
  has_many :putofactures, :dependent => :destroy
  
  accepts_nested_attributes_for :putoparcelles, :allow_destroy => true
  accepts_nested_attributes_for :putofactures, :allow_destroy => true

# ----- Validations -----
  
  validates_presence_of :name
  validates_presence_of :category
  validates_presence_of :user
  validates_presence_of :dosage
  validates_presence_of :prix_littre
  validates_presence_of :cout_ha_passage
  validates_presence_of :cout_fixe
  
  validates_associated :putoparcelles
  validates_associated :putofactures
  
  validates_numericality_of :dosage, :message => "n'est pas un nombre"
  validates_numericality_of :prix_littre, :message => "n'est pas un nombre"
  validates_numericality_of :cout_ha_passage, :message => "n'est pas un nombre"
  validates_numericality_of :cout_fixe, :message => "n'est pas un nombre"

# ----- Methodes -----
  
  def get_cout_ha_produit
    return(self.dosage * self.prix_littre)
  end
  
  def get_cout_ha_passage
    self.cout_ha_passage
  end

  def get_cout_ha_fixe
    return (self.cout_fixe / self.surfaces)
  end

  # retourne le cout a l'ha
  def get_cout_ha
    return (self.cout_ha_passage + self.get_cout_ha_produit + (self.cout_fixe / self.sum_surfaces))
  end
  
  # retourne le cout total de cette charge
  def get_cout_total
    return (self.sum_surfaces * self.get_cout_ha)
  end

  # retourne le cout total de cette charge 
  def get_cout_total_sans_reduc
    return (self.sum_surfaces * self.cout_ha_passage)
  end
  
  
#  def get_cout_ha_parcelle_with_rate(parcelle)
#    cout_ha_parcelle = 0
#    if all_parcelles? 
#      cout_ha_parcelle = self.get_cout_ha
#    end
#    if (self.parcelles.include?(parcelle))
#    rate = Putoparcelle.find_by_parcelle(parcelle.id, self.id).rate
#      cout_ha_parcelle = self.get_cout_ha * rate
#    end
#    return cout_ha_parcelle
#  end
  
  
end
