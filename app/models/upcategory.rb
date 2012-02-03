class Upcategory < ActiveRecord::Base
  has_many :categories
  validates_presence_of :name

  def all
    self.find(:all)
  end
end
