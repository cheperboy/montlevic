class Recette < ActiveRecord::Base
  # permet de créer une classe sans que la 
  # table correspondante existe dans la db
  class << self
    def table_name
      self.name.tableize
    end
  end


end
