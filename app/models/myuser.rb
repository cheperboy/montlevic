class Myuser < ActiveRecord::Base
  
  validates_presence_of :name
    
  def self.authenticate(login, password)
    return Myuser.find(:first, :conditions => ["login = ?", login])
  end

end
