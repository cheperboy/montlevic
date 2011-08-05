class Produit < ActiveRecord::Base  
  
  has_many :protofactures
  has_many :factures, :through => :protofactures
  
  has_many :putoproduits
  has_many :pulves, :through => :putoproduits

  belongs_to :saison
  belongs_to :category
  
  accepts_nested_attributes_for :putoproduits, :allow_destroy => true
  accepts_nested_attributes_for :protofactures, :allow_destroy => true
 
  # ----- Validations -----

  validates_presence_of :name, :message => "Nom ne doit pas etre vide"
  validates_presence_of :category_id, :message => "Categorie ne doit pas etre vide"
  validates_presence_of :unit, :message => "Unite ne doit pas etre vide"

  def is_valid
    unless prix.nil?
      unless protofactures.nil?
        total = 0
        protofactures.each do |protofac|
          total += protofac.value
        end
      end
      if total != prix
        return '!'
      end
    end
    return ''
  end

  # ----- Finders -----
  #test 14 avril 2011
  #TODO finir cette methode!
  # classement par cout?
  def self.find_with_order()
    saison = Saison.find(Setting.find(:first).saison_id)
    produits = saison.produits.find(:all, :order => :category_id)
  end

  def self.find_by_saison(*args)
    with_scope(:find => { :conditions => ["saison_id = ?", Setting.find(:first).saison_id],
                          :order => :category_id}) do
        find(*args)
      end
  end
  
  def self.find_by_pulve_and_produit(pulve_id, produit_id, *args)
    with_scope(:find => { :conditions => ["pulve_id = ? AND produit_id = ?", pulve_id, produit_id]}) do
        find(*args)
      end
  end

  def find_putoproduit_by_pulve(pulve_id)
    self.putoproduits.each do |putoproduit|
      if putoproduit.pulve_id.eql?(pulve_id)
        return putoproduit
      end
      return nil
    end
  end
  
  # ----- Calculs -----  
  def get_prix_unit
    if self.protofactures.count == 0
      return 0 
    else
      prix_unit = 0
      self.protofactures.each do |protofac|
        prix_unit += protofac.prix / protofac.quantite
      end
      prix_unit / self.protofactures.count
    end
  end

  def get_quantite
    if self.protofactures.count == 0
      return 0 
    else
      total = 0
      self.protofactures.each do |protofac|
        total += protofac.quantite
      end
      total
    end
  end  
    
  def get_cout_total
    if self.protofactures.count == 0
      return 0 
    else
      cout_total = 0
      self.protofactures.each do |protofac|
        cout_total += protofac.prix
      end
      cout_total
    end
  end
  
  # ----- Affichage -----
  def name_for_select
    out = "#{self.category.name} - #{self.name}"
  end
  
  def category_name
    self.category.name
  end

  def user_name
    self.user.name
  end
  
  def unit_price_by_quantity
    return "€/" + self.unit
  end
 
end
