class User < ActiveRecord::Base
  
  validates_presence_of :name

  def self.find_by_name(name)
    self.find(:first, :conditions => ["name = ?", name])
  end

end
