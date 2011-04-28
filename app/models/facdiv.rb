class Facdiv < ActiveRecord::Base
  belongs_to :facture
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :cout
  validates_numericality_of :cout, :message => "n'est pas un nombre"

  # ----- Validations -----
  def validate
    errors.add("Nom", "Ne doit pas etre vide") unless name != ''
    unless cout != '' || type == Diverse.to_s
      errors.add("Cout", "Ne doit pas etre vide") 
    end
  end

  validates_numericality_of :cout, :message => "n'est pas un nombre"

  def name_facdiv
    the_date = self.date.to_s
    the_cout = self.cout.to_s
    the_saison = self.saison.name.to_s
    @name_facdiv = the_saison + " - " + 
                       date.to_s + " - " + 
                       category.name + " - " + 
                       the_cout +" € - " + 
                       name
  end

  
end
