class Category < ActiveRecord::Base
  has_ancestry :cache_depth => true

  belongs_to :factcat
  belongs_to :upcategory
  has_many :charges
  has_many :factures
  has_many :ventes
  has_many :produits
  has_many :pulves

  validates_uniqueness_of :code
  
  validates_format_of :code,
                      :with	=> /^\w+$/,
                      :message => "ne doit pas contenir d'espaces"  

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

# old factcats (agri, maison, invest)

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

  def self.labours_cats
    find_by_upcategory('labour')
  end
    
  def self.produits_cats
    find_by_upcategory('produit')
  end

  def self.pulves_cats
    find_by_upcategory('pulve')
  end
    
  def self.putoproduits_cats
    find_by_upcategory('produit')
  end
    
  def self.factures_cats
    find_by_upcategory('facture')
  end

  def self.ventes_cats
    find_by_upcategory('vente')
  end    
  def self.for_factures
    find_by_upcategory('facture')
  end
    
  def self.grouped_for_factures
    myoptions = []
    root = Category.find(:first, :conditions => { :name => 'facture' })
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


  def self.grouped_for_factures_old
    cats = find_by_upcategory('facture')
    upcategory_id = Upcategory.find(:first, :conditions => { :name => 'facture' }).id
    
    myoptions = []
    Factcat.find(:all).each do |upcat|
      myupcat = CategoryUptype.new(upcat.name)
      categories = Category.find(:all, :conditions => ["factcat_id = ? AND upcategory_id = ?", upcat.id, upcategory_id])
      categories.each do |cat|
        myupcat << CategoryOption.new(cat.id, cat.name)
      end
      myoptions << myupcat
    end

    # agri = CategoryUptype.new("Agricole")
    # factcat_id = Factcat.find_by_code("agri").id
    # categories = Category.find(:all, :conditions => ["factcat_id = ? AND upcategory_id = ?", factcat_id, upcategory_id])
    # categories.each do |cat|
    #   agri << CategoryOption.new(cat.id, cat.name)
    # end
    # 
    # invest = CategoryUptype.new("Investissement")
    # factcat_id = Factcat.find_by_code("invest").id
    # categories = Category.find(:all, :conditions => ["factcat_id = ? AND upcategory_id = ?", factcat_id, upcategory_id])
    # categories.each do |cat|
    #   invest << CategoryOption.new(cat.id, cat.name)
    # end
    # 
    # maison = CategoryUptype.new("Maison")
    # factcat_id = Factcat.find_by_code("maison").id
    # categories = Category.find(:all, :conditions => ["factcat_id = ? AND upcategory_id = ?", factcat_id, upcategory_id])
    # categories.each do |cat|
    #   maison << CategoryOption.new(cat.id, cat.name)
    # end
    # 
    # options = [agri, invest, maison]
    return myoptions
  end
    
  def self.get_factcat(cat_id)
    category = Category.find(cat_id)
    Factcat.find(category.factcat_id)
  end
    
end



