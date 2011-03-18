class Category < ActiveRecord::Base
  
  belongs_to :upcategory
  has_many :depenses
  
  def self.find_by_type(type)
    type_id = Upcategory.find(:all, :conditions => { :name => type })
    categories = Category.find(:all, :conditions => { :upcategory_id => type_id })
    categories
  end
  
end

