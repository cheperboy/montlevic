class Myuser < ActiveRecord::Base
  
  validates_presence_of :login
  validates_presence_of :password

  def self.authenticate(login, password)
    return Myuser.find(:first, :conditions => ["login = ? AND password = ?", login, password])
  end

  def get_pref_saison
    puts "myuser.pref_saison"
    if self.pref_saison && Saison.find(self.pref_saison)
      return self.pref_saison
      puts "choose self.pref_saison : #{self.pref_saison}"
    else
      return Saison.find(:last).id
      puts "choose Saison.find(:last) : #{Saison.find(:last)}"
    end
  end

end
