class Saison < ActiveRecord::Base

  validates_presence_of :name, :message => 'aie'

  has_many :parcelles
  has_many :labours
  has_many :pulves
  has_many :factures
  has_many :ventes
  has_many :reportables
  has_many :produits
  has_many :putoproduits

  has_one :setting    

  # positionne le champ Protofac.quantite_restante de chaque produit de la saison.
  def update_prduit_restant
  # Produit : p
  # p.used_quantity : quantite utilisee
  # p.quantite : quantite totale achetee (somme des factures)
  # protofac.get_quantite = protofac.prix_unit_unitaire * protofac.quantite
  # 
  # Init:
  # produit_restant = produit.quantite_initiale
    produit_used = produit.get_used_quantity
  # 
  # Algo:
    saison.produits.each do |produit|
      produit.protofactures.each do |protofac|
        if protofac.get_quantite <= produit_used
          protofac.set_quantite_restante(0)
        else
          protofac.set_quantite_restante(produit_used)
        end
        produit_used -= protofac.get_quantite
        produit_used = 0 if produit_used < 0
      end
    end
    
  end
  
  # retourne les id des pulves des parcelles de la saison (ou nil)
  def putoproduits
    putoproduits = []
    self.pulves.each do |pulve|
      pulve.putoproduits.each do |putoproduit|
        putoproduits << putoproduit
      end
    end
    return nil if putoproduits.size == 0
    putoproduits
  end
  
  # retourne les id des Typecultures des parcelles de la saison (ou nil)
  def typecultures
    typecultures = []
    parcelles = self.parcelles
    unless parcelles.size == 0
      parcelles.each do |parcelle|
        typecultures << parcelle.typeculture
      end
      typecultures = typecultures.uniq
    end 
    return nil if typecultures.size == 0
    typecultures
  end
  
  # retourne les id des Zones des parcelles de la saison (ou nil)
  def zones
    zones = []
    parcelles = self.parcelles
    unless parcelles.size == 0
      parcelles.uniq.each do |parcelle|
        parcelle.zones.each do |zone|
          zones << zone
        end
      end
      zones = zones.uniq
    end
    return nil if zones.size == 0
    zones
  end

end
