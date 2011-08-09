class Pulve < Charge

# ----- Model -----

  # belongs_to :category
  belongs_to :user
  belongs_to :saison
  
  has_many :parcelles, :through => :putoparcelles
  has_many :putoparcelles, :dependent => :destroy
  
  has_many :factures, :through => :putofactures
  has_many :putofactures, :dependent => :destroy
  
  has_many :produits, :through => :putoproduits
  has_many :putoproduits, :dependent => :destroy
  
  accepts_nested_attributes_for :putoparcelles, :allow_destroy => true
  accepts_nested_attributes_for :putofactures, :allow_destroy => true
  accepts_nested_attributes_for :putoproduits, :allow_destroy => true

# ----- Validations -----
  
  validates_presence_of :name, :message => "nom ne doit pas etre nul"
  validates_presence_of :user, :message => "Prestataire ne doit pas etre nul"
  validates_presence_of :cout_ha_passage, :message => "cout ha passage ne doit pas etre nul"
  
  # validates_associated :putoparcelles
  # validates_associated :putofactures
  
  validates_numericality_of :cout_ha_passage, :message => "cout ha passage doit etre un nombre"

# ----- Finders -----

  # named_scope :with_star,
  #             {:conditions => ["star = ?", 1]}

  def self.find_with_saison(*args) 
    with_scope(:find => {:conditions => ["saison_id = ?", Setting.find(:first).saison_id]}) do 
      find(*args)
    end 
  end

  def self.with_star
    with_scope(:find => {:conditions => ["user_id = 2"]}) do
      yield
    end
  end

  # ----- Methodes de calcul -----
  def get_cout_ha_produits
    val = 0
    if produit_assoc?
      self.putoproduits.each do |putoproduit|
        val += putoproduit.dosage * putoproduit.produit.get_prix_unit
      end
    end
    return val
  end

  def get_cout_ha_produit
    val = 0
    if produit_assoc?
      self.putoproduits.each do |putoproduit|
        val += putoproduit.dosage * putoproduit.produit.get_prix_unit
      end
    end
    return val
  end

  def get_cout_ha_passage
    self.cout_ha_passage
  end

  def get_cout_ha
    return (self.cout_ha_passage)
  end
  
  # retourne le cout total de cette charge
  def get_cout_total
    return (self.get_cout_ha * self.sum_surfaces)
  end

  def get_cout_total_produits
    return (self.get_cout_ha_produits * self.sum_surfaces)
  end

  def get_cout_total_passage
    return (self.get_cout_ha_passage * self.sum_surfaces)
  end

  # # retourne le cout total du produit (dosage x prix du littre) 
  # # uniquement pour affichage
  # def get_cout_total_produit
  #   return (self.get_cout_ha_produit * self.sum_surfaces)
  # end
  # 
  # # retourne le cout total de cette charge 
  # def get_cout_total_sans_reduc
  #   return (self.sum_surfaces * self.cout_ha_passage)
  # end

  # ----- Methodes de verif -----
  # TODO completer cela et afficher les infos dans la liste des pulves
  def facture_assoc?
    self.putofactures.empty?
  end
  
  def produit_assoc?
    !self.putoproduits.empty?
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

# ----- Methodes d'affichage -----

  def categories
    cats = []
    out = ""
    self.produits.each do |produit|
      cats << produit.category.name
    end
    cats = cats.uniq.sort
    cats.each do |cat| 
      out += cat.to_s + "<br>"
    end
    return out
  end

  def print_produits
    pros = []
    out = ""
    self.produits.each do |produit|
      pros << produit
    end
    pros = pros.uniq
    pros.each do |pro| 
      out += pro.category.name.to_s + " : " + pro.name.to_s + "<br>"
    end
    return out
  end

end
