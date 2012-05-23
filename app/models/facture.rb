class Facture < Charge  
  
  COLS_NAME =         {1 => 'adu',  2 => 'star', 3=>'category_id', 4=>'date', 5=>'cout', 6=>'name', 7=>'ref_client', 8=>'ref', 9=>'factype_id', 10=>'desc', 11=>'type'}
  COLS_DISPLAY_NAME = {1 => 'adu',  2 => 'star', 3=>'cat',         4=>'date', 5=>'cout', 6=>'nom',  7=>'ref client', 8=>'ref', 9=>'type',       10=>'desc', 11=>'type'}
  COLS_SIZE =         {1 => 1,      2 => 1,      3=>2,             4=>2,      5=>3,      6=>2,      7=>2,            8=>3,     9=>2,            10=>2,      11=>2}
  COLS_LINK =         {1 => true,   2 => true,   3=>true,          4=>true,   5=>true,   6=>true,   7=>true,         8=>true,  9=>true,         10=>false,  11=>true}
  COLS_COUNT = 11

  # FACTURE_TYPE_AGRI = 0
  # FACTURE_TYPE_MAISON = 1
  # FACTURE_TYPE_INVESTISSEMENT = 2
  # FACTURE_TYPES =       [FACTURE_TYPE_AGRI, FACTURE_TYPE_MAISON, FACTURE_TYPE_INVESTISSEMENT]
  # FACTURE_TYPES_NAME =  ['Agricol', 'FACTURE_TYPE_MAISON', 'FACTURE_TYPE_INVESTISSEMENT']
  # 
  
  has_many :facdivs

  has_many :produits, :through => :protofactures
  has_many :protofactures, :dependent => :destroy 

  # TODO : supprimer cette assoc putofacture
  has_many :pulves, :through => :putofactures
  has_many :putofactures

  # TODO : supprimer cette assoc labtofacture
  has_many :labtofactures
  has_many :labours, :through => :labtofactures

  has_many :parcelles, :through => :factoparcelles
  has_many :factoparcelles, :dependent => :destroy

  belongs_to :category
  belongs_to :factcat
  belongs_to :factype
  belongs_to :user
  belongs_to :saison
  
  accepts_nested_attributes_for :factoparcelles, :allow_destroy => true

  # ----- Validations -----
  def validate
    errors.add("Nom", "Ne doit pas etre vide") unless name != ''
    unless cout != '' || type == Diverse.to_s
      errors.add("Cout", "Ne doit pas etre vide") 
    end
  end

  validates_numericality_of :cout, :message => "n'est pas un nombre"

  validates_presence_of :name
  validates_presence_of :category
  validates_presence_of :user
  validates_associated :factoparcelles
  validates_presence_of :cout

  # ----- Finders -----

  named_scope :scope_by_saison, 
  :conditions => {:saison_id => Setting.get_saison_id}

  named_scope :scope_by_phyto, 
  :conditions => {:category_id => Category.find_by_upcategory_and_code('facture', 'produits_phyto')}


  #test 14 avril 2011
  #TODO finir cette methode!
  # classement par cout?
  def self.find_with_order()
    saison = Setting.get_saison
    all_factures = saison.factures.find(:all, :order => :cout)
    order= []
    reportable_todo = true
    report_todo = true
    while ((all_factures.size > 0) && (reportable_todo = true))
      for facture in all_factures
        if ((facture.class == Reportable))    
          reportable = facture
          order << reportable
          all_factures.delete(reportable)
          if reportable.reports.size > 0
            for report in all_factures
              if ((report.class == Report) && (report.reportable_id == reportable.id))
                order << report
                all_factures.delete(report)
              end
            end
          end
        end
      end
    end
    return order
  end

  def self.find_by_saison(*args)
    with_scope(:find => { :conditions => ["saison_id = ?", Setting.get_saison_id],
                          :order => :adu}) do
        find(*args)
      end
  end
  
  def self.find_total(*args)
    with_scope(:find => { :conditions => ["saison_id = ? AND factype_id = ?", 
                                          Setting.get_saison_id,
                                          Factype.find_by_name('total').id],
                          :order => :category_id}) do
        find(*args)
      end
  end
  
  def self.find_diff(*args)
    with_scope(:find => { :conditions => ["saison_id = ? AND factype_id = ?", 
                                          Setting.get_saison_id,
                                          Factype.find_by_name('diff').id],
                          :order => :category_id}) do
        find(*args)
      end
  end
  
  #old find_papier
  def self.find_null(*args)
    with_scope(:find => { :conditions => ["saison_id = ? AND factype_id = ?", 
                                          Setting.get_saison_id,
                                          Factype.find_by_name('null').id],
                          :order => :category_id}) do
        find(*args)
      end
  end
  
  #old find_not_papier
  def self.find_real_by_saison(*args)
    with_scope(:find => { :conditions => ["saison_id = ? AND type != ?", 
                                          Setting.get_saison_id,
                                          'Report'],
                          :order => :category_id}) do
        find(*args)
      end
  end

  def charges?
    return((self.labours.count > 0) || (self.pulves.count > 0) || (self.produits.count > 0))
  end

  def comptable_diff?
    return (self.factype_id == Factype.find_by_name('diff').id)  
  end
  def comptable_null?
    return (self.factype_id == Factype.find_by_name('null').id)  
  end
  def comptable_total?
    return (self.factype_id == Factype.find_by_name('total').id)  
  end
  
  def category?(cat)
    return (self.category.name == cat)  
  end
  
  def category_produits?()
    return (self.category.code.eql?('produits_phyto'))  
  end
  
  def category_services_agri?()
    return (self.category.code.eql?('service_agricole'))  
  end
  
  # ----- Methodes d'affichage -----
  
  def pp_paye
    if self.paye.eql?(1) 
      return ("✓")
    else 
      return ""
    end
  end
    
  def print_factype
    self.factype.name
  end

  def toggle_star
    self.star = 2
    self.save
    return true
  end
  
  def name_and_type
    the_date = self.date.to_s
    the_cout = self.cout.to_s
    @name_and_category =  date.to_s + " - " + 
                          category.name + " - " + 
                          the_cout +" € - " + 
                          name
  end
    
  def factcat_name
    # 12/03/13 modification car Factcat obsolete
    # self.factcat.name
    self.category.get_factcat_from_category.name
  end

  # ----- Methodes de calcul -----

  #somme les contribition des labour d'une facture
  #c'est-a-dire les champs 'value' des labtofactures associés 
  def sum_labours
    Labtofacture.sum(:value, :conditions => ['facture_id = ?', self.id])
  end
  
  def sum_pulves
    val=0
    self.putofactures.each {|putofacture| val += putofacture.value }
    return val
  end
  
  def sum_putoproduits_stock
    sum = 0
    self.protofactures.each { |p| sum += p.prix_unit * p.stock }
    sum
  end
  
  def sum_putoproduits_used
    sum = 0
    self.protofactures.each { |p| sum += p.prix_unit * (p.quantite - p.stock) }
    sum
  end
  
  # Somme des produits associes. meme ceux qui n'ont pas ete utilises lors de traitements.
  def sum_putoproduits_associated
    # TODO URGENT facture 46 la valeur renvoyee est fausse
    sum = 0
    # logger.error "facture : #{self.id}"
    self.protofactures.each do |p| 
      # logger.error "produit #{p.produit.name}"
      # logger.error "\tquantite: #{p.quantite}"
      # logger.error "\tused: #{p.get_used}"
      # logger.error "\tstock: #{p.quantite - p.get_used}"
      sum += p.prix_unit * p.quantite
    end
    # logger.error "\tsum_putoproduits_associated : #{sum}"
    sum
  end
  
  # remplacer sum_putoproduits_used par sum_putoproduits_associated pour comptabiliser aussi les produits utilises
  def sum_charges
    return (self.sum_pulves + self.sum_putoproduits_used + sum_labours)
  end
  
  def get_cout_ha
    return (self.get_cout_total / self.sum_surfaces)
  end
  
  # retourne le cout total de cette charge
  def get_cout_total
    if (self.comptable_null?)
      return (0)
    elsif (self.comptable_diff?)
      return (self.cout - self.sum_charges)
    elsif (self.comptable_total?)
      return (self.cout)
    end
  end
    
  def get_cout_total_sans_reduc
    return (self.cout)
  end
  
  # 12/03/13 modification car Factcat obsolete
  def update_factcat
    cat = Category.find(self.category_id)
    self.factcat_id = cat.get_factcat_from_category.id
    self.save!
  end
    
# ----- Verifs ------

# Somme des associations superieur a facture.cout
  def assos_sup_cout
    if charges?
      if ((sum_charges > cout) && (!cout.almost_eql?(sum_charges, 1)))
        return true      
      end
    end
    return false
  end

  # Reportable not NULL ou Report NULL
  def reportable_not_null_or_report_null
    if (self.class.eql?(Reportable) && !comptable_null?) || (self.class.eql?(Report) && comptable_null?)
      return true      
    end
    return false
  end

# ----- Export ------

  def self.export_by_saison   
    # s = 0
    # Debit.find_by_saison(:all).each do |f| 
    #   s+= f.cout
    # end
    # 
    # puts "Debit = #{s}"
    # 
    # Reportable.find_by_saison(:all).each do |f| 
    #   # puts "\t#{f.name} #{f.cout}"
    # 
    #   s+= f.cout
    #   sr=0
    #   f.reports.each do |r| 
    #     sr+=r.cout
    #     # puts "\t\t#{r.name} #{r.cout}"
    #   end
    #   if f.cout !=  sr
    #     puts "#{f.cout} - #{sr} = #{f.cout - sr}"
    #     sr=0
    #   end
    # end
    # puts "Debit+reportable = #{s}"

    tete = Spreadsheet::Format.new  :color => :blue,
                                      :weight => :bold,
                                      :size => 14
    gras = Spreadsheet::Format.new :weight => :bold

    saison = Setting.get_saison.name
    book = Spreadsheet::Workbook.new

    # sheet 1
    name = "toutes les factures #{saison}"
    sheet = book.create_worksheet
    sheet.name = name
    
    # datas
    tab_tete = ["id", "type", "date", "categorie", "cout", "prestataire", "nom", "ref client", "ref perso", "cout total", "cout - total"]
        
    sheet.row(0).replace tab_tete
    sheet.row(0).default_format = tete
    i = 1
    factures = []
    Debit.find_by_saison(:all).each {|d| factures << d}
    Reportable.find_by_saison(:all).each {|d| factures << d}
    factures.each do |f|
      date = f.date.strftime("%Y/%m/%d")
      tab = [f.id, f.type.to_s, date, f.category.name, f.cout, f.user.name, f.name, f.ref_client, f.ref, f.get_cout_total, f.cout - f.get_cout_total]
      sheet.row(i).replace tab
      i = i + 1
    end

    # sheet 2
    name = "reportables et reports"
    sheet2 = book.create_worksheet
    sheet2.name = name    
    # datas
    sheet2.row(0).replace tab_tete
    sheet2.row(0).default_format = tete
    i = 1
    Reportable.find_by_saison(:all).each do |f|
      date = f.date.strftime("%Y/%m/%d")
      tab = [f.id, f.type.to_s, date, f.category.name, f.cout, f.user.name, f.name, f.ref_client, f.ref, f.get_cout_total, f.cout - f.get_cout_total]
      sheet2.row(i).replace tab
      sheet2.row(i).default_format = gras
      i = i + 1
      f.reports.each do |r|
        date = f.date.strftime("%Y/%m/%d")
        tab = [r.id, r.type.to_s, date, r.category.name, r.cout, r.user.name, r.name, r.ref_client, r.get_cout_total, f.cout - f.get_cout_total]
        sheet2.row(i).replace tab
        i = i + 1
      end
    end
    
    file = StringIO.new 
    book.write file
    return file
  end

end
