class Category < ActiveRecord::Base
  
  belongs_to :factcat
  belongs_to :upcategory
  # TODO "has_many :depenses" doit etre supprime?
  has_many :charges
  has_many :factures
  
  def name_for_select_for_facture
    @name_for_select = self.factcat.name + " - " + self.name
  end
  
  def self.find_by_type(type)
    type_id = Upcategory.find(:all, :conditions => { :name => type })
    # logger.error('type_id' + type_id.to_s)
    categories = Category.find(:all, :conditions => { :upcategory_id => type_id })
    categories
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
    
  def self.labours
    find_by_upcategory('labour')
  end
    
  def self.pulves
    find_by_upcategory('pulve')
  end
    
  def self.putoproduits
    find_by_upcategory('pulve')
  end
    
  def self.factures
    find_by_upcategory('facture')
  end

  def self.ventes
    find_by_upcategory('vente')
  end

  # def self.factures
  #   find_by_upcategory('facture')
  # end
  
  # def self.for_factures
  #   find_by_factcat_and_upcategory_name('agri', 'facture')
  # end
    
  def self.for_factures
    find_by_upcategory('facture')
  end
    
end

