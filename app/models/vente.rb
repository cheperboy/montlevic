class Vente < Charge

  has_many :parcelles, :through => :ventoparcelles
  has_many :ventoparcelles, :dependent => :destroy

  belongs_to :category
  belongs_to :user
  belongs_to :saison
  
  accepts_nested_attributes_for :ventoparcelles, :allow_destroy => true

  validates_presence_of :name, :message => "Nom doit etre indique"
  validates_presence_of :category, :message => "Categorie doit etre indique"
  validates_presence_of :user, :message => "Prestataire doit etre indique"
  validates_presence_of :prix, :message => "Prix doit etre indique"
  validates_numericality_of :prix, :message => "Prix doit etre un nombre"
  validates_associated :ventoparcelles

  def self.find_by_saison(*args)
    with_scope(:find => { :conditions => ["saison_id = ?", Application::SAISON_ID],
                          :order => :category_id}) do
        find(*args)
      end
  end

  def get_cout_ha
    return (self.get_cout_total / self.sum_surfaces)  
  end
  
  # retourne le prix total de cette vente
  def get_cout_total
    return (self.prix)
  end

  # TODO regler le probleme de cette fonction (est-il necessaire de reecrir sur get_cout_ha_parcelle(parcelle) de charge.rb)
  # def get_cout_ha_parcelle(parcelle)
  #   cout_ha_parcelle = 0
  #   if (all_parcelles?)
  #     cout_ha_parcelle = self.get_cout_ha
  #   elsif (self.parcelles.include?(parcelle))
  #     ventoparcelle = self.ventoparcelles.find(:parcelle_id => parcelle.id)
  #     cout_ha_parcelle = self.ventoparcelles.value / parcelle.surface
  #   end
  #   return cout_ha_parcelle
  # end

end
