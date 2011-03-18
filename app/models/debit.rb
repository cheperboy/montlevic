class Debit < Facture
  #"Vraie Facture" => papier avec valeur (cout du debit) ET comptabilisee sur une seule saison

  set_table_name "factures"


  def name_debit
    the_date = self.date.to_s
    the_cout = self.cout.to_s
    the_saison = self.saison.name.to_s
    @name_debit = the_saison + " - " + 
                       date.to_s + " - " + 
                       category.name + " - " + 
                       the_cout +" € - " + 
                       name
  end

end
