class Factcat < ActiveRecord::Base
  has_many :factures
  validates_presence_of :name
  
  
end
