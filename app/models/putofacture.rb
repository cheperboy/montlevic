class Putofacture < ActiveRecord::Base

  belongs_to :facture
  belongs_to :pulve
  belongs_to :saison
  
  validates_presence_of :value, :message => "valeur non definie"
  validates_numericality_of :value, :message => "n'est pas un nombre"

# Callbacks
  def before_save 
    self.saison ||= GetSession.current_saison
  end
  
end
