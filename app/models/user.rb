class User < ActiveRecord::Base
  has_many :pulves
  validates_presence_of :name, :message => "le nom ne doit pas etre vide"
  validates_presence_of :code

  def self.find_by_name(name)
    self.find(:first, :conditions => ["name = ?", name])
  end

  def self.find_by_code(code)
    self.find(:first, :conditions => ["code = ?", code])
  end

end
