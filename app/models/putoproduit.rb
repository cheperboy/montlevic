class Putoproduit < Charge
# TODO le dosage retourne par update_dosage_after_save peut etre negatif = bug

  belongs_to :produit
  belongs_to :pulve
  belongs_to :saison
  
  # validates_presence_of :pulve_id, :message => "putoproduit.pulve_id non valide"
  validates_presence_of :produit_id, :message => "Selectionner un produit (creer si produit inexistant)"
  # validates_numericality_of :dosage, :message => "indiauer le dosage ou la quantite ou chcher 'destocker'",
  #                           :if => Proc.new { |u| (u.quantite.blank? && u.destocker.blank?) }

  validates_presence_of :quantite, :message => "indiquer le dosage ou la quantite ou cocher destocker",
                        :if => Proc.new { |u| (u.dosage.blank? && u.destocker.eql?(0)) }
 # && u.destocker.eql?(0)
  # validates_presence_of :dosage, :message => "dosage ne doit pas etre nul"

  # Callback
  def before_save
    self.saison ||= self.pulve.saison
    # on force une valeur de dosage qui sera ecrasee par update_dosage_after_save()
    # self.dosage = -6.66 if self.dosage.blank?
  end
   
  def destocker?
    puts "DESTOCKER == TRUE"    
    return self.destocker.eql?(1)
  end
  
  def update_dosage_after_save
    puts "\t\tputoproduit : #{self.id}"
    if !self.quantite.blank?
      self.dosage = self.quantite / self.pulve.sum_surfaces
      puts "\t\tquantite detected"
      self.destocker = 0
      self.save!
    
    elsif self.destocker?
      puts "\t\tdestocker checked"
      stock = self.produit.get_stock
      
      # au stock restant il faut ajouter la quantite de produit deja associee via ce putoproduit.
      # cependant le dosage n'existe pas encore on create:
      stock += self.dosage * self.pulve.sum_surfaces if self.dosage?
      self.dosage = stock / self.pulve.sum_surfaces
      puts "\t\tself.dosage: #{self.dosage}"
      self.destocker = 0
      self.save!
    end
  end
   
  # correspond au cout_ha_produit d'un pulve!
  def get_cout_ha
    self.dosage * self.produit.get_prix_unitaire
  end
  
  def category
    self.produit.category
  end
  
  # retourne le cout total de cette charge
  def get_cout_total
    return (self.pulve.sum_surfaces * self.get_cout_ha)
  end
  
 # ----- methodes Charge adaptees -------
 
  def get_cout_ha_parcelle(parcelle)
    cout_ha_parcelle = 0
    if (self.pulve.all_parcelles? || self.pulve.parcelles.include?(parcelle))
      cout_ha_parcelle = self.get_cout_ha
    end
    return cout_ha_parcelle
  end
  
  def get_cout_ha_typeculture(typeculture)
    cout_ha_typeculture = 0
    if (self.pulve.all_parcelles? || self.pulve.include_typeculture?(typeculture))
      cout_ha_typeculture = self.get_cout_ha
    end
    return cout_ha_typeculture
  end
  
  def get_cout_ha_zone(zone)
    cout_ha_zone = 0
    if (self.pulve.all_parcelles? || self.pulve.include_zone?(zone))
      cout_ha_zone = self.get_cout_ha
    end
    return cout_ha_zone
  end
    
  def get_cout_total_parcelle(parcelle)
    return(parcelle.surface * self.get_cout_ha_parcelle(parcelle))
  end

  def get_cout_total_zone(zone)
    surfaces = 0
    
    #cas ou il n'y a aucune parcelle associee
    if (self.pulve.parcelles.count == 0)
      surfaces = zone.surface

    #cas ou il y a 1 ou plusieurs parcelles associees
    else
      zone.parcelles.each do |parcelle|
        if self.pulve.parcelles.include?(parcelle)
          surfaces += parcelle.surface
        end
      end
    end
    return(surfaces * self.get_cout_ha_zone(zone))
  end
  
  def get_cout_total_typeculture(typeculture)
    surfaces = 0
    #cas ou il il n'y a aucune parcelle associee
    if (self.pulve.parcelles.count == 0)
      surfaces = typeculture.surface

    #cas ou il y a 1 ou plusieurs parcelles associees
    else
      self.pulve.parcelles.each do |parcelle|
        surfaces += parcelle.surface
      end
    end
    return(surfaces * self.get_cout_ha_typeculture(typeculture))
  end
  

  
end
