class Putoproduit < Charge

  belongs_to :produit
  belongs_to :pulve
  belongs_to :saison
  
  validates_presence_of :produit_id, :message => "Selectionner un produit (creer si produit inexistant)"
  validates_presence_of :dosage, :message => "dosage ne doit pas etre nul"
  validates_numericality_of :dosage, :message => "n'est pas un nombre"

  # Callback
  def before_save 
    self.saison ||= Application::SAISON
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
