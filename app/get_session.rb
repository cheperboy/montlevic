# http://www.zorched.net/2007/05/29/making-session-data-available-to-models-in-ruby-on-rails/
# to get session in model
module GetSession
  # def current_user_id
  #   Saison.find(Thread.current[:current_saison_id])
  # end
  # 
  # def current_saison
  #   Saison.find(Thread.current[:current_saison_id])
  # end
  # 
  # def current_saison_id
  #   Thread.current[:current_saison_id]
  # end
  # 
  # def self.current_saison_id=(saison_id)
  #   Thread.current[:current_saison_id] = saison_id
  # end
  # def self.current_user_id=(user_id)
  #   Thread.current[:current_user_id] = user_id
  # end
end