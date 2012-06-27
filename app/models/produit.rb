class Produit < ActiveRecord::Base  

  def before_save 
  end

  def after_save 
    self.update_protofacture_stock
  end

  has_many :protofactures, :dependent => :destroy
  has_many :factures, :through => :protofactures
  
  has_many :putoproduits, :dependent => :destroy
  has_many :pulves, :through => :putoproduits

  belongs_to :saison
  belongs_to :category
  
  accepts_nested_attributes_for :putoproduits, :allow_destroy => true
  accepts_nested_attributes_for :protofactures, :allow_destroy => true
 
  # ----- Validations -----
  validates_uniqueness_of :code, :message        => "ce code est deja pris. changer de nom"
  validates_presence_of   :name, :message        => "Nom ne doit pas etre vide"
  validates_presence_of   :category_id, :message => "Categorie ne doit pas etre vide"
  validates_presence_of   :unit, :message        => "Unite ne doit pas etre vide"

  named_scope :by_saison, :conditions => ["saison_id = ?", Setting.find(1).saison_id]
  named_scope :starred, :conditions => ["star = ?", 1]
  named_scope :not_starred, :conditions => ["star = ?", 0]

  def to_s(*args)
    out = ''
    if args[0] == :default
      out += (self.name + " ")    
    end
    out
  end

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
    saison = Saison.find(Setting.find(1).saison_id)
    produits = saison.produits.find(:all, :order => :category_id)
  end

  # Finders
  
  def self.find_buy(*args)
    produits = []
    elements = self.find_by_saison(:all, :order => :category_id)
    elements.each do |p|
      if p.protofactures.count != 0
        produits << p
      end
    end
    return produits
  end
  
  def self.find_not_buy(*args)
    produits = []
    elements = self.find_by_saison(:all, :order => :category_id)
    elements.each do |p|
      if p.protofactures.count == 0
        produits << p
      end
    end
    return produits
  end
  
  def self.find_used(*args)
    produits = []
    elements = self.find_by_saison(*args)
    elements.each do |p|
      if (p.putoproduits.count != 0 && p.protofactures.count != 0)
        produits << p
      end
    end
    return produits
  end
  
  def self.find_not_used(*args)
    produits = []
    elements = self.find_by_saison(:all, :order => :category_id)
    elements.each do |p|
      if (p.putoproduits.count == 0 && p.protofactures.count != 0)
        produits << p
      end
    end
    return produits
  end
  
  def self.find_by_saison(*args)
    with_scope(:find => { :conditions => ["saison_id = ?", Setting.find(1).saison_id],
                          :order => :category_id}) do
        find(*args)
      end
  end
  
  # ----- Calculs -----  
  def get_prix_unitaire
    sum_cout = 0
    sum_quantite = 0
    prix_unitaire = 0
    unless self.protofactures.count == 0      
      self.protofactures.each do |protofac| 
        sum_cout += protofac.prix_unit * protofac.quantite
        sum_quantite += protofac.quantite
      end
      prix_unitaire = sum_cout / sum_quantite      
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

  # TODO : pulve.update. est-ce que cette method actualise correctement le dosage d'un putoproduit lorsque destocker est checked?
  def get_used_quantite
    used = 0
    self.pulves.each do |pulve|
      putoproduit = self.putoproduits.find_by_pulve_id(pulve.id)
      dosage = putoproduit.dosage
      surface = pulve.sum_surfaces
      # if this method is called by update_dosage_after_save -> get_stock then 
      # 'dosage' of the last created puto produit can be blank (if destocker is checked)
      # in this case, the 'used' by this putoproduit is 0 
      used += dosage * surface unless dosage.blank?
    end
    return (used)
  end

  def get_stock
    ret = get_quantite - get_used_quantite
    puts "\tget_stock #{ret}"
    return (ret)    
  end  
    
  def stock_percent_pp
    unless get_quantite.eql?(0)
      value = (100 * (get_quantite - get_used_quantite)/get_quantite)
    else
      value = 0
    end
    return ("#{value.display}")
  end
    
  def get_cout_total
    cout_total = 0
    unless self.protofactures.count.eql?(0)
      self.protofactures.each {|protofac| cout_total += protofac.prix_unit * protofac.quantite}
      cout_total
    end
  end
  
  def update_protofacture_stock
  # Produit : p
  # p.used_quantity : quantite utilisee
  # p.quantite : quantite totale achetee (somme des factures)
  # protofac.get_quantite = protofac.prix_unit_unitaire * protofac.quantite
  # 
  # Init:
  # produit_restant = produit.quantite_initiale
  # 
  # Algo:
    used_a_deduire = self.get_used_quantite
    self.protofactures.find(:all, :order => :facture_id).each do |protofac|  
      if used_a_deduire.eql?(0)
        protofac.stock = protofac.quantite
      else
        if protofac.quantite <= used_a_deduire
          protofac.stock = 0
          used_a_deduire = used_a_deduire - protofac.quantite
        else
          protofac.stock = protofac.quantite - used_a_deduire
          used_a_deduire = 0
        end
      end
      protofac.save!
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
  def stock_vs_used?
    return (get_quantite < get_used_quantite)
  end
  def stock_vs_used_pp
    if stock_vs_used?
      return "X"
    end
  end  
  
  def sans_facture_avec_pulve?
    return ((self.protofactures.count.eql?(0)) && !(self.putoproduits.count.eql?(0)))
  end
  
end
