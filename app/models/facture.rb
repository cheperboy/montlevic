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
  Facture
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

    with_scope(:find => { :conditions => ["saison_id = ?", Setting.find(:first).saison_id],
                          :order => :category_id}) do
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
  def self.find_not_null(*args)
    with_scope(:find => { :conditions => ["saison_id = ? AND factype_id != ?", 
                                          Setting.find(:first).saison_id,
                                          Factype.find_by_name('null').id],
                          :order => :category_id}) do
        find(*args)
      end
  end

  # ----- Methodes -----
  
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

  def charges?
    return((self.labours.count > 0) || (self.pulves.count > 0))
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
  
  #somme les contribition des labour d'une parcelle
  #c'est-a-dire les champs 'value' des labtofactures associés 
  def sum_labours
    Labtofacture.sum(:value, :conditions => ['facture_id = ?', self.id])
  end
  
  def sum_pulves
    Putofacture.sum(:value, :conditions => ['facture_id = ?', self.id])
  end
  
  def sum_charges
    return (self.sum_pulves + sum_labours)
  end
  
  def sum_reports
    if self.report?
      #TODO effectuer ici la somme des reports
      return (0)
    end
    return (0)
  end
  
  #ce calcul induit une incoherence de resultat entre res-ha et res-total dans les tableaux de synthese
  #pour eviter cela, decommenter les 2 lignes..
  def get_cout_ha
    if (self.comptable_null?)
      return (0)
#    if (self.comptable_null?)
#      return ((self.get_cout_total / self.sum_surfaces) - self.sum_charges_ha - self.sum_reports_ha)
    else
      return (self.get_cout_total / self.sum_surfaces)
    end
  end
  
  # retourne le cout total de cette charge
  def get_cout_total
    if (self.comptable_null?)
      return (0)
    elsif (self.comptable_diff?)
      return (self.cout - self.sum_charges)
    elsif  (self.comptable_total?)
      return (self.cout)
    end
  end
    
  def get_cout_total_sans_reduc
    return (self.cout)
  end
    
#  def get_cout_ha_parcelle_with_rate(parcelle)
#    cout_ha_parcelle = 0
#    if all_parcelles? 
#      cout_ha_parcelle = self.get_cout_ha
#    end
#    if (self.parcelles.include?(parcelle))
#    rate = Factoparcelle.find_by_parcelle(parcelle.id, self.id).rate
#      cout_ha_parcelle = self.get_cout_ha * rate
#    end
#    return cout_ha_parcelle
#  end
  
  
end
