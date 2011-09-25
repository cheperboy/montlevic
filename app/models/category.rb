class Category < ActiveRecord::Base
  
  belongs_to :upcategory
  # TODO "has_many :depenses" doit etre supprime?
  has_many :charges
  has_many :factures
  
  def self.find_by_type(type)
    type_id = Upcategory.find(:all, :conditions => { :name => type })
    # logger.error('type_id' + type_id.to_s)
    categories = Category.find(:all, :conditions => { :upcategory_id => type_id })
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

    
end

