class Factcat < ActiveRecord::Base
  has_many :categories
  has_many :factures
  validates_presence_of :name
  validates_presence_of :code
  
  def self.find_by_code(code)
    factcat = Factcat.find(:first, :conditions => ["code = ?", code])
  end
  
end
