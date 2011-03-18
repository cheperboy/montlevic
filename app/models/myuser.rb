class Myuser < ActiveRecord::Base
  
  def self.authenticate(login, password)
    return Myuser.find(:first, :conditions => ["login = ?", login])
  end

end
