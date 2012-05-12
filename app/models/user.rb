class User < ActiveRecord::Base
  has_many :pulves
  has_many :labours
  has_many :factures
  has_many :ventes
  
  validates_presence_of   :name, :message => "le nom ne doit pas etre vide"
  validates_presence_of   :code, :message => "le code ne doit pas etre vide"
  validates_uniqueness_of :code, :message => "ce code est deja pris"


  def self.find_by_name(name)
    self.find(:first, :conditions => ["name = ?", name])
  end

  def self.find_by_code(code)
    self.find(:first, :conditions => ["code = ?", code])
  end

  # return false if no associations
  # return true if any association is present
  def has_associations?
    (!self.pulves.empty? ||
     !self.labours.empty? || 
     !self.factures.empty? || 
     !self.ventes.empty?)
  end

end
