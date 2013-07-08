class Saison < ActiveRecord::Base
  serialize :sum_charges, Hash #calculate_marge_by_cat_for_typeculture
  serialize :sum_produits, Hash #calculate_produit_by_cat_for_typeculture
 
  # Variables Stockee - exemple de sum_charges
  # les typecultures sont differencies en indexant la variable stockee par [:typecultures][id][:record]
  # A la creation de la saison les variables stockees sont initialisees
  # bouton init stockage dans vue saison: 
  #   reinit_all. permet de reinitialiser les variables stockees apres create/modif/delete d'un typeculture
  # [:typecultures][:code][:record] : la valeur stockee (retour de calculate_marge_by_cat_for_typeculture)
  # [:typecultures][:code][:valid] (true/false): la validite de la variable stockee. 
  #   positionne a true apres le stockage
  #   TODO positionne a false apres toute modif affectant le calcul
  # 
  
  validates_presence_of :name, :message => 'pas de nom'

  has_many :parcelles
  has_many :labours
  has_many :pulves
  has_many :factures
  has_many :ventes
  has_many :reportables
  has_many :produits
  has_many :putoproduits

  has_one :setting


  def self.init_serialized
    result = true
    typecultures = Typeculture.find(:all)
    saisons = Saison.find(:all)
    # sum_charges
    # sum_charges = Hash.new
    # sum_charges[:typeculture] = []
    rec = Hash.new
    rec[:typeculture] = Hash.new
    saisons.each do |saison|
      typecultures.each do |typeculture|
        rec[:typeculture][typeculture.code.to_sym] = Hash.new
        rec[:typeculture][typeculture.code.to_sym][:record] = nil
        rec[:typeculture][typeculture.code.to_sym][:valid] = false
      end
      saison.sum_charges = rec
      result = false unless saison.save
      # puts "TEST #{saison.sum_charges[:typeculture][:ble][:valid].to_s}"
    end
    # sum_produits
    sum_produits = Hash.new
    sum_produits[:typeculture] = Hash.new
    saisons.each do |saison|
      typecultures.each do |typeculture|
        sum_produits[:typeculture][typeculture.code.to_sym] = Hash.new
        sum_produits[:typeculture][typeculture.code.to_sym][:record] = nil
        sum_produits[:typeculture][typeculture.code.to_sym][:valid] = false
      end
      saison.sum_produits = sum_produits
      result = false unless saison.save
    end
    result
  end
    
  # positionne le champ Protofac.quantite_restante de chaque produit de la saison.
  # normalement cette methode n'a pas besoin d'etre appelee car les updates sont fait 
  # apres chaque modif de produit ou pulve
  def update_protofacture_stock
    self.produits.each do |produit|
      produit.update_protofacture_stock
    end
  end
    
  def selected?
    self.id.eql?(Saison.get_current_id)
  end
  
  def self.get_current
    Saison.find(Thread.current[:current_saison_id])
  end
  
  def self.get_current_id
    Thread.current[:current_saison_id]
  end
  
  def surface
    surface = 0
    self.parcelles.each { |p| surface += p.surface}
    surface
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

  # doit etre deplacé dans saison.rb
  def nb_years_between(s1, s2)
    return s2.year - s1.year
  end
  
  def self.before?(s)
    return (self.year < s.year) if s.class.eql?(Saison)
    return (self.year < s)
  end
  
  def self.after?(s)
    return (self.year > s.year) if s.class.eql?(Saison)
    return (self.year > s)
  end
  
end
