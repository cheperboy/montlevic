class Vente < Charge

  has_many :parcelles, :through => :ventoparcelles
  has_many :ventoparcelles, :dependent => :destroy

  # pour gestion des avoirs
  has_many :produits, :through => :ventoproduits
  has_many :ventoproduits, :dependent => :destroy

  belongs_to :category
  belongs_to :user
  belongs_to :saison
  
  accepts_nested_attributes_for :ventoparcelles, :allow_destroy => true
  accepts_nested_attributes_for :ventoproduits, :allow_destroy => true #pour gestion des avoir produits

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
  validates_associated :ventoproduits
 
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
    with_scope(:find => { :conditions => ["saison_id = ?", Thread.current[:current_saison_id]],
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
  
# pour action Analytic vente (calcul recursif)
# positionne recursivement les donnees prix, qtite et prix/unitaire des ventes d'une saison par categories
# sum[:unit] vaut true si toutes les ventes de la categorie ont la meme unite sinon vaut nil
# sum[:prix_unitaire][:value] est la moyenne des prix unitaire de chaque vente de la categorie
# sum[:prix] et sum[:quantite][:value] respectivement les sommes des prix et quantite de chaque vente de la categorie
# sum[:prix_unitaire][:valid] est a true si tout les PU de la cat sont renseignés et valides
# sum[:quantite][:valid] est a true si toutes les quantites de la cat sont renseignés et valides

  def self.synthese_by_cat(saison)
    categories_vente = Category.root_vente
    sum = Hash.new
    sum[:unit]          = Hash.new
    sum[:prix]          = Hash.new
    sum[:quantite]      = Hash.new
    sum[:prix_unitaire] = Hash.new
    sum[:quantite][:value]      = Hash.new
    sum[:quantite][:valid]      = Hash.new
    sum[:prix_unitaire][:value] = Hash.new
    sum[:prix_unitaire][:valid] = Hash.new
    sum = synthese_by_cat_recurs(saison, categories_vente, sum)
  end
  
  def self.synthese_by_cat_recurs(saison, up_category, sum)
    up_category.children.each do |category|
      # puts "cat #{category.code}"
    	sum[:unit][category.code.to_sym]          = true
    	sum[:prix][category.code.to_sym]          = 0
      sum[:quantite][category.code.to_sym]      = 0
      sum[:quantite][:value][category.code.to_sym]      = 0
      sum[:quantite][:valid][category.code.to_sym]      = true
      sum[:prix_unitaire][:value][category.code.to_sym] = 0
      sum[:prix_unitaire][:valid][category.code.to_sym] = true
    	old_unit = nil #memoire de la valeur unit de la vente de l'iteration precedante
      ventes = saison.ventes.select{|v| v.category_id.eql?(category.id)}
      ventes.each do |vente|
      	sum[:unit][category.code.to_sym] = nil unless ((vente.unit.eql?(old_unit)) && !old_unit.nil?)
      	sum[:quantite][:value][category.code.to_sym] += vente.quantite unless vente.quantite.nil?
      	sum[:quantite][:valid][category.code.to_sym] = nil if (vente.quantite.nil? || vente.quantite.blank?)
      	sum[:prix_unitaire][:valid][category.code.to_sym] = nil if (vente.prix_unitaire.nil? || vente.prix_unitaire.blank?)
      	sum[:prix_unitaire][:value][category.code.to_sym] += vente.prix_unitaire unless vente.prix_unitaire.nil?
        unless vente.unit # si vente.unit != ["na", nil]
          sum[:quantite][:valid][category.code.to_sym] = nil
        	sum[:prix_unitaire][:valid][category.code.to_sym] = nil
        end
      	# ajoute aussi la valeur (prix) a toutes les cat parentes de la vente
      	temp_cat = category
        while temp_cat.depth != Category.root_vente.depth
    		  sum[:prix][temp_cat.code.to_sym] += vente.prix
    		  temp_cat = temp_cat.parent
    		end
    	end
    	sum[:prix_unitaire][:value][category.code.to_sym] /= ventes.count unless ventes.size.eql?(0) 
      sum = synthese_by_cat_recurs(saison, category, sum) if category.has_children?
    end
    sum
  end

end
