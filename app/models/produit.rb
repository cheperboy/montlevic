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
    
  # ----- Calculs -----  
  def get_prix_unitaire
    prix_unitaire = 0
    unless self.protofactures.count == 0
      self.protofactures.each {|protofac| prix_unitaire += protofac.prix / protofac.quantite}
      prix_unitaire = prix_unitaire / self.protofactures.count
    end
    return prix_unitaire
  end

  def get_quantite
    total = 0
    unless self.protofactures.count.eql?(0)
      self.protofactures.each {|protofac| total += protofac.quantite}
    end
    return total
  end  

  def get_used_quantite
    used = 0
    self.pulves.each do |pulve| 
      putoproduit = self.putoproduits.find_by_pulve_id(pulve.id)
      used += putoproduit.dosage * pulve.sum_surfaces
    end
    return (used)
  end

  def get_stock
    return (get_quantite - get_used_quantite)
  end  
    
  def get_cout_total
    cout_total = 0
    unless self.protofactures.count.eql?(0)
      self.protofactures.each {|protofac| cout_total += protofac.prix}
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
  
  def get_prix_unitaire_unit
    return "€/" + self.unit
  end
  
  def get_dosage_unit
    return "#{self.unit.to_s}/ha"
  end
  
  def number_of_use
    count=0
    Pulve.find_by_saison(:all, :order => :id).each do |pulve| 
      pulve.produits.each do |produit| 
        if produit.id.eql?(self.id)
          count += 1
        end
      end
    end
    return "<span class='red'>#{count.to_s}</span>" if count.eql?(0)
    return count.to_s
  end  
  
  # ----- Verif -----
  def stock_lower_than_used?
    return (get_quantite < get_used_quantite)
  end
  def stock_lower_than_used_display
    if stock_lower_than_used?
      return "X"
    end
  end     
end
