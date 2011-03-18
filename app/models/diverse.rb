class Diverse < Facture
  
  set_table_name "factures"

  def name_diverse
    the_date = self.date.to_s
    the_cout = self.cout.to_s
    the_saison = self.saison.name.to_s
    @name_diverse = the_saison + " - " + 
                       date.to_s + " - " + 
                       category.name + " - " + 
                       the_cout +" € - " + 
                       name
  end

  def update_cout
    cout = 0
    self.facdivs.each do |facdiv|
      cout += facdiv.cout
    end
    self.cout = cout
  end

end
