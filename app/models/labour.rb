class Labour < Charge

  has_many :parcelles, :through => :labtoparcelles
  has_many :labtoparcelles, :dependent => :destroy
  
  has_many :factures, :through => :labtofactures
  has_many :labtofactures, :dependent => :destroy
  
  belongs_to :category
  belongs_to :user
  belongs_to :saison
  
  accepts_nested_attributes_for :labtoparcelles, :allow_destroy => true
  accepts_nested_attributes_for :labtofactures, :allow_destroy => true

  validates_presence_of :name
  validates_presence_of :category
  validates_presence_of :user
  validates_associated :labtoparcelles
  validates_associated :labtofactures
  validates_numericality_of :cout_ha_passage, :message => "n'est pas un nombre"

# ----- Methodes -----


  def factures_assoc?
    if self.factures.count.equal?(0)
      return false
    else 
      return true
    end
  end

  def get_cout_ha_avec_reduc
    return (self.get_cout_total_avec_reduc / self.sum_surfaces)
  end

  # retourne le cout total de cette charge 
  # moins les contribution des factures associees
  def get_cout_total_avec_reduc
    deduction = 0
    cout = self.sum_surfaces * self.cout_ha_passage
    if factures_assoc?
      self.labtofactures.each do |link|
        deduction += link.value
      end
    end
    return (cout - deduction)
  end
  
  # retourne le cout total de cette charge 
  def get_cout_total
    return (self.sum_surfaces * self.cout_ha_passage)
  end
  
  #utilise uniquement pour l'affichage, pas dans les calculs
  def get_cout_ha
    return (self.cout_ha_passage)
  end
  
#  def get_cout_ha_parcelle_with_rate(parcelle)
#    cout_ha_parcelle = 0
#    if all_parcelles? 
#      cout_ha_parcelle = self.get_cout_ha
#    end
#    if (self.parcelles.include?(parcelle))
#    rate = Labtoparcelle.find_by_parcelle(parcelle.id, self.id).rate
#      cout_ha_parcelle = self.get_cout_ha * rate
#    end
#    return cout_ha_parcelle
#  end
  

end
