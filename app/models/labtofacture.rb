class Labtofacture < ActiveRecord::Base

  belongs_to :labour
  belongs_to :facture
  belongs_to :saison
  
  validates_presence_of :value
  validates_numericality_of :value, :message => "n'est pas un nombre"

# Callbacks
  def before_save 
    self.saison ||= Saison.find(Thread.current[:current_saison_id])
  end


end
