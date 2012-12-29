# TODO aucun find ne doit utiliser des string en dur
# toutes les categories sensibles (Facture, Maison, produit_phyto, ...) doivent etre identifiees par CONSTANTES
# ajouter ensuite un before_update pour empecher les modif/delete si la cat fait partit d'une des constantes 
# modifier ensuite Facture.rb pour que les find utilise les Category::CONSTANTES

class Category < ActiveRecord::Base
  has_ancestry :cache_depth => true

  belongs_to :factcat
  belongs_to :upcategory
  has_many :charges
  has_many :factures
  has_many :ventes
  has_many :produits
  has_many :pulves
  has_many :labours

  validates_uniqueness_of :code, :message => "ce code est deja pris"

  # pas bon: leve des erreurs meme si pas d'espace  
  # validates_format_of :code,
  #                     :with => /^\w+$/,
  #                     :message => "ne doit pas contenir d'espaces"  

  CategoryOption = Struct.new(:id, :name)

  # For Select List by Group
  class CategoryUptype 
    attr_reader :type_name, :options 
    def initialize(name)
      @type_name = name
      @options = []
    end
  
    def <<(option)
      @options << option
    end
  end
  # End of For Select List by Group
  
  
  def self.find_by_factcat_id(factcat_id)
      categories = Category.find(:all, :conditions => { :factcat_id => factcat_id })
  end

  #nouveau pour Tree
  def self.root_facture
    Category.find(:first, :conditions => { :name => "Facture"})
  end
    def self.root_maison
      Category.find(:first, :conditions => { :name => "Maison"})
    end
    def self.root_invest
      Category.find(:first, :conditions => { :name => "Investissement"})
    end
    def self.root_agri
      Category.find(:first, :conditions => { :name => "Agricole"})
    end
  def self.root_labour
    Category.find(:first, :conditions => { :name => "Labour" })
  end
  def self.root_pulve
    Category.find(:first, :conditions => { :name => "Pulve" })
  end
  def self.root_vente
    Category.find(:first, :conditions => { :name => "Vente" })
  end
  def self.root_produit
    Category.find(:first, :conditions => { :name => "Produit" })
  end
  def self.root_putoproduit
    Category.find(:first, :conditions => { :name => "Produit" })
  end
  def self.labours_cats
    self.root_labour.children
  end
  def self.produits_cats
    self.root_produit.children
  end
  def self.pulves_cats
    self.root_pulve.children
  end    
  def self.putoproduits_cats
    self.root_produit.children
  end
  def self.factures_cats
    self.root_facture.children
  end
  def self.ventes_cats
    self.root_vente.children
  end
    

  def move_elements_to_new_leaf
    out = ""
    parent = self.parent
    unless parent.factures.size.eql?(0)
      out << "<b>Factures</b><br>"
      parent.factures.each do |facture|
        facture.update_attribute(:category_id, self.id)
        out << "- #{facture.name}<br>"
      end
    end
    unless parent.ventes.size.eql?(0)
      out << "<b>Ventes</b><br>"
      parent.ventes.each do |vente|
        vente.update_attribute(:category_id, self.id)
        out << "- #{vente.name}<br>"
      end
    end
    unless parent.pulves.size.eql?(0)
      out << "<b>Pulves</b><br>"
      parent.pulves.each do |pulve|
        pulve.update_attribute(:category_id, self.id)
        out << "- #{pulve.name}<br>"
      end
    end
    unless parent.labours.size.eql?(0)
      out << "<b>Labours</b><br>"
      parent.labours.each do |labours|
        labour.update_attribute(:category_id, self.id)
        out << "- #{labour.name}<br>"
      end
    end
    unless parent.produits.size.eql?(0)
      out << "<b>Produits</b><br>"
      parent.produits.each do |produit|
        produit.update_attribute(:category_id, self.id)
        out << "- #{produit.name}<br>"
      end
    end
    return out
  end

# old factcats (agri, maison, invest)

  def has_elements?
    return !( self.factures.size.eql?(0) && 
              self.ventes.size.eql?(0) && 
              self.produits.size.eql?(0) &&
              self.labours.size.eql?(0) &&
              self.pulves.size.eql?(0))
  end
  
  def is_descendant_of?(cat)
    cat.descendants.exists?(:id => self.id)
  end
  def is_agri?
    Category.root_agri.descendants.exists?(:id => self.id)
  end
  def is_maison?
    Category.root_maison.descendants.exists?(:id => self.id)
  end
  def is_invest?
    Category.root_invest.descendants.exists?(:id => self.id)
  end

# CATEGORIES RESERVED
  def is_produit?
    Category.root_agri.children.exists?(:id => self.id)
  end

  def get_factcat_from_category
    return "root" if self.is_root?
    factcat = self.parent
    factcat = factcat.parent while !factcat.depth.eql?(1)
    factcat
  end
  
  def self.get_factcats
    return self.root_facture.children
  end
  
  #End of nouveau pour Tree (end)

  def name_for_select_for_facture
    @name_for_select = self.factcat.name + " - " + self.name
  end
  
  def self.find_by_type(type)
    type_id = Upcategory.find(:all, :conditions => { :name => type })
    # logger.error('type_id' + type_id.to_s)
    categories = Category.find(:all, :conditions => { :upcategory_id => type_id })
    categories
  end
  
  def self.find_by_upcategory_and_code(upcategory, code)
    up_id = Upcategory.find(:first, :conditions => { :name => upcategory })
    category = Category.find(:first, :conditions => { :upcategory_id => up_id, :code => code })
    category
  end
  
  def self.find_by_factcat_and_upcategory(factcat_id, upcategory_id)
    categories = Category.find(:all, :conditions => ["factcat_id = ? AND upcategory_id = ?", factcat_id, upcategory_id])
    categories
  end
  
  def self.find_by_factcat_and_upcategory_name(factcat_name, upcategory_name)
    factcat_id = Factcat.find(:first, :conditions => { :code => factcat_name }).id
    upcategory_id = Upcategory.find(:first, :conditions => { :name => upcategory_name }).id
    categories = Category.find(:all, :conditions => ["factcat_id = ? AND upcategory_id = ?", factcat_id, upcategory_id])
    categories
  end
  
  def self.find_by_upcategory(name)
    upcategory_id = Upcategory.find_by_name(name).id
    categories = Category.find(:all, :conditions => { :upcategory_id => upcategory_id })
    return categories
  end

  def self.grouped_for_factures
    myoptions = []
    root = Category.find(:first, :conditions => { :code => 'facture' })
    root.children.each do |upcat|
      myupcat = CategoryUptype.new(upcat.name)
      categories = upcat.children
      categories.each do |cat|
        myupcat << CategoryOption.new(cat.id, cat.name)
      end
      myoptions << myupcat
    end
    return myoptions
  end
    
  def self.get_factcat(cat_id)
    category = Category.find(cat_id)
    Factcat.find(category.factcat_id)
  end
    
  def valid_is_not_leaf_has_elements?
	  out = ""
  	if ((self.has_children?) && (self.factures.count>0 || self.ventes.count>0 || self.pulves.count>0 || self.labours.count>0 || self.produits.count>0))
  	  return false
  	else
  	  return true
  	end
  end

  def self.export
    tete = Spreadsheet::Format.new  :color => :blue,
                                      :weight => :bold,
                                      :size => 14
    gras = Spreadsheet::Format.new :weight => :bold

    saison = Setting.get_saison.name
    book = Spreadsheet::Workbook.new

    # sheet 1
    name = "#{self.to_s.pluralize}_#{saison}" 
    sheet = book.create_worksheet
    sheet.name = name
    
    # datas
    tab_tete = ["id", "root", "parent", "nom", "code"]
        
    sheet.row(0).replace tab_tete
    sheet.row(0).default_format = tete
    i = 1
    elts = []
    elts = Category.all
    elts.each do |e|
      tab = [e.id, e.root.name, e.try(:parent).try(:name), e.name, e.code]
      sheet.row(i).replace tab
      i = i + 1
    end
        
    file = StringIO.new 
    book.write file
    return file
  end

end



