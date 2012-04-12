class Pulve < Charge

  # ----- Constantes -----
  XLS_NAME = 1
  XLS_USER = 2
  XLS_COUT_HA_PASSAGE = 3

  def after_save 
    self.putoproduits.each { |putoproduit| putoproduit.update_dosage_after_save }
    self.produits.each { |produit| produit.update_protofacture_stock }
  end

  def before_delete 
    # update_protofacture_stock realise dans le controller.
    # self.produits.each { |produit| produit.update_protofacture_stock }
  end
# ----- Model -----

  # belongs_to :category
  belongs_to :user
  belongs_to :saison
  belongs_to :category
  
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
  def self.with_star
    with_scope(:find => {:conditions => ["user_id = 2"]}) do
      yield
    end
  end

  # ----- Methodes de calcul -----
  def get_cout_ha_produits # produits seulement
    cout_ha_produits = 0
    if produit_assoc?
      self.putoproduits.each {|putoproduit| cout_ha_produits += putoproduit.dosage * putoproduit.produit.get_prix_unitaire}
    end
    cout_ha_produits
  end

  def get_cout_total_produits # produits seulement
    return (self.get_cout_ha_produits * self.sum_surfaces)
  end

  def get_cout_ha_passage # prestation seulement
    self.cout_ha_passage
  end

  def get_cout_total_passage # prestation seulement
    return (self.get_cout_ha_passage * self.sum_surfaces)
  end

  def get_cout_ha # prestation + produits
    return (self.cout_ha_passage + self.get_cout_ha_produits)
  end

  def get_cout_total # prestation + produits
    return (self.get_cout_ha * self.sum_surfaces)
  end

  # ----- couts prestation -----  
  # couts relatifs a la prestation (= cout du passage sans les produits)
  # dans ces methodes, "passage" signifie "prestation"
  def get_cout_ha_passage_for_saison(surface_of_saison)
    get_cout_total_passage / surface_of_saison
  end
  
  def get_cout_ha_passage_col(col)
      return get_cout_ha_passage_parcelle(col) if col.class.equal?(Parcelle)
      return get_cout_ha_passage_zone(col) if col.class.equal?(Zone)
      return get_cout_ha_passage_typeculture(col) if col.class.equal?(Typeculture)
  end

  def get_cout_ha_passage_parcelle(parcelle)
    cout_ha_parcelle = 0
    if (all_parcelles? || self.parcelles.include?(parcelle))
      cout_ha_parcelle = self.get_cout_ha_passage
    end
    return cout_ha_parcelle
  end

  def get_cout_ha_passage_typeculture(typeculture)
    cout_ha_typeculture = 0
    if (all_parcelles? || self.include_typeculture?(typeculture))
      cout_ha_typeculture = self.get_cout_ha_passage
    end
    return cout_ha_typeculture
  end

  def get_cout_ha_passage_zone(zone)
    cout_ha_zone = 0
    if (all_parcelles? || self.include_zone?(zone))
      cout_ha_zone = self.get_cout_ha_passage
    end
    return cout_ha_zone
  end
    
  def get_cout_total_passage_col(col)
    return get_cout_total_passage_parcelle(col) if col.class.equal?(Parcelle)
    return get_cout_total_passage_zone(col) if col.class.equal?(Zone)
    return get_cout_total_passage_typeculture(col) if col.class.equal?(Typeculture)
  end
  
  def get_cout_total_passage_parcelle(parcelle)
    return(parcelle.surface * self.get_cout_ha_passage_parcelle(parcelle))
  end

  def get_cout_total_passage_zone(zone)
    surfaces=0
    
    #cas ou il il n'y a aucune parcelle associee
    if self.parcelles.count.eql?(0)
      surfaces = zone.surface

    #cas ou il y a 1 ou plusieurs parcelles associees
    else
      zone.parcelles.each do |parcelle|
        if self.parcelles.include?(parcelle)
          surfaces += parcelle.surface
        end
      end
    end
    return(surfaces * self.get_cout_ha_passage_zone(zone))
  end
  
  def get_cout_total_passage_typeculture(typeculture)
    surfaces=0
    #cas ou il il n'y a aucune parcelle associee
    if self.parcelles.count.eql?(0)
      surfaces = typeculture.surface

    #cas ou il y a 1 ou plusieurs parcelles associees
    else
      typeculture.parcelles.each do |parcelle|
        if self.parcelles.include?(parcelle)
          surfaces+=parcelle.surface
        end
      end
    end
    return(surfaces * self.get_cout_ha_passage_typeculture(typeculture))
  end

  # ----- FIN couts prestation -----




  # # retourne le cout total du produit (dosage x prix du littre) 
  # # uniquement pour affichage
  # def get_cout_total_produit
  #   return (self.get_cout_ha_produits * self.sum_surfaces)
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
