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

  has_many :protofactures
  has_many :produits, :through => :protofactures

  has_many :putofactures
  has_many :pulves, :through => :putofactures

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
  #test 14 avril 2011
#TODO finir cette methode!
# classement par cout?
  def self.find_with_order()
    saison = Saison.find(Setting.find(:first).saison_id)
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
    with_scope(:find => { :conditions => ["saison_id = ?", Setting.find(1).saison_id],
                          :order => :adu}) do
        find(*args)
      end
  end
  
  def self.find_total(*args)
    with_scope(:find => { :conditions => ["saison_id = ? AND factype_id = ?", 
                                          Setting.find(:first).saison_id,
                                          Factype.find_by_name('total').id],
                          :order => :category_id}) do
        find(*args)
      end
  end
  
  def self.find_diff(*args)
    with_scope(:find => { :conditions => ["saison_id = ? AND factype_id = ?", 
                                          Setting.find(:first).saison_id,
                                          Factype.find_by_name('diff').id],
                          :order => :category_id}) do
        find(*args)
      end
  end
  
  #old find_papier
  def self.find_null(*args)
    with_scope(:find => { :conditions => ["saison_id = ? AND factype_id = ?", 
                                          Setting.find(:first).saison_id,
                                          Factype.find_by_name('null').id],
                          :order => :category_id}) do
        find(*args)
      end
  end
  
  #old find_not_papier
  def self.find_real_by_saison(*args)
    with_scope(:find => { :conditions => ["saison_id = ? AND type != ?", 
                                          Setting.find(:first).saison_id,
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
    self.factcat.name
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
  
  # def sum_reports
  #   if self.report?
  #     return (0)
  #   end
  #   return (0)
  # end
  
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
  
  def update_factcat
    cat = Category.find(self.category_id)
    self.factcat_id = Factcat.find(cat.factcat_id).id
    self.save!
  end
    
# ----- Verifs ------

# Somme des associations superieur a facture.cout
  def assos_sup_cout
    if charges?
      if (sum_charges > cout)
        return true      
      end
    end
    return false
  end

  
end
