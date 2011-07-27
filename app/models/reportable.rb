class Reportable < Facture
  #Facture comprenant un/des reports sur une/plusieurs saisons.
  
  #Par defaut, une facture Reportable n'est pas comptabilisee, 
    #seuls ses Reports associes sont comptabilises
  #Donc une facture de produit Reportable doit etre accompagnee de Reports 
    #pour etre prise en compte dans les calculs
  # => dans FactureController, a la creation d'une Reportable, son champ 'factype' est set a 'null'
  
  # TODO la valeur comptable d'une Reportable doit etre la valeur cout moins la somme des Report. ainsi le cout comptable est le restant qui n'a pas ete reporte.
  
  set_table_name "factures"
  has_many :reports

  def name_reportable
    the_date = self.date.to_s
    the_cout = self.cout.to_s
    the_saison = self.saison.name.to_s
    @name_reportable = id.to_s + " - " + 
                       the_saison + " - " + 
                       date.to_s + " - " + 
                       category.name + " - " + 
                       the_cout +" € - " + 
                       name
  end

end
