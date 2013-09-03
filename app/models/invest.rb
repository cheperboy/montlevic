# TODO Invest doit etre une STI de Facture
module Invest
  EXPORT_INVEST_HEAD = 
  [
    # KEY           VALUE
   	['id',          'id'], 
   	['date',        'date'], 
   	['ref client',  'ref_client'], 
   	['ref perso',   'ref'], 
   	['facture',     'name'], 
   	['prix',        'cout'], 
   	['taux',        'nb_month_amort']
   ]

  # Invest est une extension de la classe Facture
  # Invest utilise le champ suivant :
  # - nb_month_amort

  # tal : Taux d'Amortissement lineaire
  # tal = 100/durée années = 100/(nb_month_amort / 12)
  
  # Calcul
  # hypothese année de 360 jours, soit 12 mois de 30 jours. 
  # (dans certaines entreprises, le nombre de jours  se calcule sur une base de 365 jours)
  # Premiere annee
  # Sa formule est : 1ère annuité = (valeur de bien x taux linéaire x nombre de jours) / 360  

  # ----- Validations -----
  def validate
    errors.add("Nom", "Ne doit pas etre vide") unless name != ''
    errors.add("Cout", "Ne doit pas etre vide") unless cout != ''
    errors.add("nb_month_amort", "Ne doit pas etre vide") unless nb_month_amort != ''
  end

  # retourne valeur de l'amortissement pour la saison en parametre et pour saison courante si pas de parametre 
  def get_cout_for_saison(saison_id = nil)
    # recupere la saison pour laquelle on effectue le calcul
    if (saison_id.nil?)
      saison = Saison.get_current
    else
      saison = Saison.find(saison_id)
    end

    # valeur de l'amortissement
    amort = self.cout / self.nb_years_amort

    # si la saison pour laquel on veut calculer l'amort est anterieur a la date d'achat, on renvoi 0
    amort = 0 if saison.before?(self.saison)

    # cas ou l'amortissement est fini:
    amort = 0 if saison.after?(self.saison.year + self.nb_years_amort)
  end
  
  # a reprendre : cas + 1
  def date_end
    year_end = self.date.year + (self.nb_month_amort / 12)
    return Date.new(year_end, self.date.month, self.date.day)
  end
  
  def last_year
    self.date_end.strftime("%Y")
  end

  def first_year
    self.date.strftime("%Y")
  end

  def nb_years_amort
    return self.nb_month_amort / 12
  end
  
  # cout pour une annee donnee en parametre
  def get_cout_for_year(year)
    amort = 0
    month = 1
    while (month < 13)
    # (1..12).each do imonth
      amort += get_cout_for_month(year, month)
      month = month + 1
    end
    amort
  end
  
  def get_cout_for_month(year, month)
    first_year = self.first_year.to_i
    last_year = self.last_year.to_i
    amort_monthly = (self.cout / self.nb_month_amort) # valeur de l'amort par mois
    if year.eql?(first_year) # annee d'achat
      if month >= self.date.strftime("%m").to_i
        amort = amort_monthly
      else
        amort = 0
      end
    elsif year.eql?(last_year) # derniere annee
      if month < self.date.strftime("%m").to_i
        amort = amort_monthly
      else
        amort = 0
      end
    elsif (year > first_year && year < last_year) # annee pleine entre annee d'achat et derniere annee
      amort = amort_monthly
    else
      amort = 0
    end
    return amort
  end
  
# ----- Verifs ------
  # ces methodes retournent true si erreur
  # =>                      false si pas d'erreur  

  # Reportable not NULL ou Report NULL
  def reportable_not_null_or_report_null
    return (self.class.eql?(Reportable) && !comptable_null?) || (self.class.eql?(Report) && comptable_null?)
  end

  # parcelles_assoc.saison_id != de la saison de la facture
  def parcelle_assoc_saison_incoh
    err = false
    self.parcelles.each       { |p| err = true unless p.saison_id.eql?(self.saison_id) }
    self.factoparcelles.each  { |a| err = true unless a.saison_id.eql?(self.saison_id) }
    return (err)
  end

# ----- Export ------

  def self.export()
    first_year = Saison.find(:first).year.to_i
    last_year   = first_year + 15
    
    # creation fichier
    book = Spreadsheet::Workbook.new

    # sheet 1
    name = "tableau amortissement"
    sheet = book.create_worksheet
    sheet.name = name
    
    
    # tab_head_x = formules pour groupir plan auto sur plusieurs colonnes
    # Une colonne = 1 mois, groupir par annees (12 mois)
    tab_head_x = []
    Invest::EXPORT_INVEST_HEAD.each do |header|
      tab_head_x << ''
    end
    tab_head_x = []
    (first_year..last_year).each do |year|
      (1..12).each do |month|
        tab_head_x << '' if month.eql?(1)
        tab_head_x << ''
      end
    end

    # tab_head = ["id", "date", "ref", "facture", "prix", "taux", "plage"]
    tab_head_0 = []
    Invest::EXPORT_INVEST_HEAD.each {|header| tab_head_0 << header[0]}

    tab_head_1 = [] # tableau vide pour remplir avant en-tete ligne mois
    tab_head_0.length.times {tab_head_1 << ''}
    
    # tab_years_head = [first_year, ..., 2000, ...., 2001, ..., 2002, ..., last_year] (... = 12 fois)
    tab_years_head_0 = []
    (first_year..last_year).each do |year|
      (1..12).each do |month|
        tab_years_head_0 << "total #{year.to_s}" if month.eql?(1)
        tab_years_head_0 << year.to_s
      end
    end

    # tab_months_head = [1,2,3,4,4,5,6,7,8,9,10,11,12, ... ]
    tab_months_head_1 = []         # init du tableau
    (first_year..last_year).each do |year|
      (1..12).each do |month|
        tab_months_head_1 << "" if month.eql?(1)
        tab_months_head_1 << month.to_s
      end
    end

    tab_0 = []
    tab_0.concat(tab_head_0)
    tab_0.concat(tab_years_head_0)
    
    tab_1 = []
    tab_1.concat(tab_head_1)
    tab_1.concat(tab_months_head_1)
    
    sheet.row(0).replace tab_0
    sheet.row(0).default_format = Application::XLS_FORMAT_TETE
    sheet.row(1).replace tab_1
    sheet.row(1).default_format = Application::XLS_FORMAT_GRAS

    #Traitement de chaque facture investissement
    i = 2
    # factures = []
    # factures = Facture.all(:all, 
    #                         :conditions => ["saison_id = ?", "1"],
    #                         :order => "id DESC"
    #                         # :limit => 10
    #                         )

    # Invest.find(:all).each {|f| factures << f}
    factures = Facture.find(46, 50, 51)
    factures.each do |f|
      if f.category.is_invest?
        date        = f.date.strftime("%d/%m/%Y")
        taux_pretty = "#{f.nb_years_amort.to_s} ans"

        # tab_infos   = [f.id, f.date, f.ref, f.name, f.cout, f.taux_pretty, "plage"]
        tab_infos_i   = []
        Invest::EXPORT_INVEST_HEAD.each do |header|
          tab_infos_i << f.send(header[Application::HEADER_VALUE])
        end

        # fill tab_amort for the facture (line i)
      
        tab_amort_i  = []
        ofset_year = 0 #premiere annee=0, 2eme annee=1, etc
        (first_year..last_year).each do |year|
          (1..12).each do |mmonth|
            # debut = numero de colonne de la premiere cellule de la plage que l'on somme
            # +2  : +1 car colonne resultat de somme ne doit pas etre compté
            #     : +1 car .length positionne sur la derniere case du tableau (on veut la case qui suit)
            # *13 : 12 mois plus la case qui contient la somme
            debut = (Invest::EXPORT_INVEST_HEAD.length + 2 + (13 * ofset_year)).to_i
            tab_amort_i << "#{f.get_cout_for_year(first_year+ofset_year)}" if mmonth.eql?(1)
            # tab_amort_i << "=SOMME(L#{i+1}C#{debut}:L#{i+1}C#{debut+11})" if mmonth.eql?(1)
            tab_amort_i << f.get_cout_for_month(year.to_i, mmonth.to_i).to_f
          end
          ofset_year += 1
        end

        tab_infos_i.concat(tab_amort_i)
        sheet.row(i).replace tab_infos_i
        i = i + 1
      end
    end

    # sheet 2 - instructions
    name = "Instructions"
    sheet2 = book.create_worksheet
    sheet2.name = name
    sheet2.row(1).replace [1, 'Donnees -> Grouper -> Plan automatique']
    sheet2.row(2).replace [2, "Rechercher (ctrl-F ou pomme-F)-> Remplacer -> remplacer '=' par '=' -> remplacer tout."]
    

    #ecriture du fichier
    file = StringIO.new 
    book.write file
    return file
  end

end
