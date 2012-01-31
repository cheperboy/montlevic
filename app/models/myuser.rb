class Myuser < ActiveRecord::Base
  
  validates_presence_of :login
  validates_presence_of :password

  def self.authenticate(login, password)
    return Myuser.find(:first, :conditions => ["login = ? AND password = ?", login, password])
  end

end
