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
  def update_protofacture_stock
  # Produit : p
  # p.used_quantity : quantite utilisee
  # p.quantite : quantite totale achetee (somme des factures)
  # protofac.get_quantite = protofac.prix_unit_unitaire * protofac.quantite
  # 
  # Init:
  # produit_restant = produit.quantite_initiale
    
  # 
  # Algo:
    self.produits.each do |produit|
      used_a_deduire = produit.get_used_quantite
      # logger.error "Produit : #{produit.id}\t #{produit.name}. used : #{used_a_deduire}"
      produit.protofactures.find(:all, :order => :facture_id).each do |protofac|  
        # logger.error "\tprotofacture : #{protofac.id}"
        if used_a_deduire.eql?(0)
          protofac.stock = protofac.quantite
        else
          if protofac.quantite <= used_a_deduire
            # logger.error "\tprotofac.quantite (#{protofac.quantite}) < used_a_deduire (#{used_a_deduire})"
            protofac.stock = 0
            # logger.error "\tprotofac.stock = 0"
            used_a_deduire = used_a_deduire - protofac.quantite
            # logger.error "\tused_a_deduire(#{used_a_deduire}) -= protofac.quantite(#{protofac.quantite})"
          else
            # logger.error "\tprotofac.quantite (#{protofac.quantite}) > used_a_deduire (#{used_a_deduire})"
            protofac.stock = protofac.quantite - used_a_deduire
            # logger.error "\tprotofac.stock = used_a_deduire(#{used_a_deduire})"
            used_a_deduire = 0
            # logger.error "\tstock=#{used_a_deduire}"
          end
        end
        protofac.save!
      end #produit.protofactures.each
      
    end # of saison.produits.each
    
  end # of method
  
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
