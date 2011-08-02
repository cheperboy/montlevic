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
  def validate
    errors.add("Nom", "Ne doit pas etre vide") unless name != ''
  end

  validates_numericality_of :prix, :message => "n'est pas un nombre"

  validates_presence_of :name
  validates_presence_of :category_id
  validates_presence_of :quantite
  validates_presence_of :unit
  validates_associated :protofactures
  validates_associated :putoproduits

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
  
  def category_name
    self.category.name
  end

  def user_name
    self.user.name
  end
  
  
  
end
