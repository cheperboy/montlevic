class Charge < ActiveRecord::Base

  self.abstract_class = true

  # permet de créer une classe sans que la 
  # table correspondante existe dans la db
#  class << self
#    def table_name
#      self.name.tableize
#    end
#  end

  def abstract_class?
    return true
  end


  # ----- Getters -----

  def to_s(*args)
    out = ''
    if args[0] == :default
      out += (self.print_date + " ")
      out += (self.category.name + " ")    
      out += (self.name + " ")    
    else
      args.each do |arg|
        out += (self.print_date + " ") if arg == :date
        out += (self.category.name + " ") if arg == :category      
        out += (self.name + " ") if arg == :name      
      end
    end
    out
  end
  
  def print_date
    unless self.date.nil? || self.date.blank?
      out = "#{self.date.day}/#{self.date.month}/#{self.date.year}"
      return out
    end
  end

  def category_name
    self.category.name
  end

  def user_name
    self.user.name
  end

  # METHODES partagées par toutes les dépenses, factures, pulve, ...

  def self.find_by_saison(*args)
    with_scope(:find => 
                {:conditions => ["saison_id = ?", Setting.find(:first).saison_id] }) do
        find(*args)
      end
  end

#methode deplacee de Model/Labour.rd vers Charges.rb
#pour etre accessible par Pulve
  def factures_assoc?
    if self.factures.count.equal?(0)
      return false
    else 
      return true
    end
  end

  def all_parcelles?
    return self.parcelles.length.equal?(0)
  end
  
  def all_zones?
    return self.parcelles.length.equal?(0)
  end

  def include_zone?(zone)
    self.parcelles.each do |parcelle|
      if parcelle.zones.include?(zone)
        return true
      end
    end
    return false
  end

  def include_typeculture?(typeculture)
    self.parcelles.each do |parcelle|
      if parcelle.typeculture == typeculture
        return true
      end
    end
    return false
  end

  def typecultures
    cultures = []
    Typeculture.find(:all).each do |culture|
      self.parcelles.each do |parcelle|
        if parcelle.typeculture == culture
          cultures << culture.name
        end
      end
    end
    cultures.uniq.sort.to_s
  end
  
  # sum_surfaces
  # retourne la somme des surfaces de chaque parcelles associées à cette charge.
  # Si aucune parcelle n'est associée a cette charge, toutes les parcelles sont prises en compte.
  # [IF MODIF] Attention, normalement cette méthode ne devrait jamais retourner 0   
  def sum_surfaces
    s=0 
    if all_parcelles?
      parcelles = Parcelle.find_for_saison()
    else
      parcelles = self.parcelles
    end
    parcelles.each do |parcelle| 
      s = s + parcelle.surface
    end
    s
  end
  
  def get_cout_ha_for_saison(surface_of_saison)
    get_cout_total / surface_of_saison
  end
  
  def get_cout_ha_col(col)
      return get_cout_ha_parcelle(col) if col.class.equal?(Parcelle)
      return get_cout_ha_zone(col) if col.class.equal?(Zone)
      return get_cout_ha_typeculture(col) if col.class.equal?(Typeculture)
  end

  def get_cout_ha_parcelle(parcelle)
    cout_ha_parcelle = 0
    if (all_parcelles? || self.parcelles.include?(parcelle))
      cout_ha_parcelle = self.get_cout_ha
    end
    return cout_ha_parcelle
  end

  def get_cout_ha_typeculture(typeculture)
    cout_ha_typeculture = 0
    if (all_parcelles? || self.include_typeculture?(typeculture))
      cout_ha_typeculture = self.get_cout_ha
    end
    return cout_ha_typeculture
  end

  def get_cout_ha_zone(zone)
    cout_ha_zone = 0
    if (all_parcelles? || self.include_zone?(zone))
      cout_ha_zone = self.get_cout_ha
    end
    return cout_ha_zone
  end
    
  def get_cout_total_col(col)
    return get_cout_total_parcelle(col) if col.class.equal?(Parcelle)
    return get_cout_total_zone(col) if col.class.equal?(Zone)
    return get_cout_total_typeculture(col) if col.class.equal?(Typeculture)
  end
  
  def get_cout_total_parcelle(parcelle)
    return(parcelle.surface * self.get_cout_ha_parcelle(parcelle))
  end

  def get_cout_total_zone(zone)
    surfaces=0
    
    #cas ou il il n'y a aucune parcelle associee
    if (self.parcelles.count == 0)
      surfaces = zone.surface

    #cas ou il y a 1 ou plusieurs parcelles associees
    else
      zone.parcelles.each do |parcelle|
        if self.parcelles.include?(parcelle)
          surfaces+=parcelle.surface
        end
      end
    end
    return(surfaces * self.get_cout_ha_zone(zone))
  end
  
  def get_cout_total_typeculture(typeculture)
    surfaces=0
    #cas ou il il n'y a aucune parcelle associee
    if (self.parcelles.count == 0)
      surfaces = typeculture.surface

    #cas ou il y a 1 ou plusieurs parcelles associees
    else
      typeculture.parcelles.each do |parcelle|
        if self.parcelles.include?(parcelle)
          surfaces+=parcelle.surface
        end
      end
    end
    return(surfaces * self.get_cout_ha_typeculture(typeculture))
  end
  
end
