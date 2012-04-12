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
  validates_presence_of :prix, 
                        :message => "Prix doit etre indique",
                        :if => Proc.new { |u| (u.calcul_auto.eql?(0)) }
  validates_numericality_of :prix,
                            :message => "Prix doit etre un nombre",
                            :if => Proc.new { |u| (!u.prix.blank?) }
  
  validates_presence_of :quantite,
                        :message => "quantite doit etre indique",
                        :if => Proc.new { |u| (u.calcul_auto.eql?(1)) }
  validates_numericality_of :quantite,
                        :message => "quantite doit etre un nombre",
                        :if => Proc.new { |u| (!u.quantite.blank?) }

  validates_presence_of :prix_unitaire,
                        :message => "prix_unitaire doit etre indique",
                        :if => Proc.new { |u| (u.calcul_auto.eql?(1)) }
  validates_numericality_of :prix_unitaire,
                        :message => "prix_unitaire doit etre un nombre",
                        :if => Proc.new { |u| (!u.prix_unitaire.blank?) }

  validates_associated :ventoparcelles

  # validates_each :prix, :prix_unitaire, :quantite do |model, attr, value|
  #   if value =~ /groucho|harpo|chico/i 
  #     model.errors.add(attr,  "You  can't be  serious,  #{value}" )
  #   end 
  # end
  
  def set_prix
    logger.error "setting prix: #{self.calcul_auto.to_s}" 
    if (self.prix_unitaire? && self.quantite?)
      self.prix = self.prix_unitaire * self.quantite
      self.prix += self.ajust if self.ajust?
      self.save!
    end
  end
  
  def self.find_by_saison(*args)
    with_scope(:find => { :conditions => ["saison_id = ?", Setting.find(1).saison_id],
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

# ----- Affichage ------
  def get_prix_unitaire_unit
    return "" if self.unit.blank?
    return "€/" + self.unit
  end
  


end
