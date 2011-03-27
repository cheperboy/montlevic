class Factype < ActiveRecord::Base
  has_many :factures

#{ :name => "diff", :display => "diff", :desc => "Les charges associees a cette facture sont affectees a chaques depenses (pulves et labours).\r\nLa somme de toutes les charges associees a la facture est deduit du cout de la facture et le reste (cout_facture - somme_des_charges) est reparti sur les parcelles associees a la facture."}, 
#{ :name => "cout total", :display => "cout total", :desc => "Les charges associees a cette facture ne sont pas deduites du cout de la facture.\r\n\r\nIl s'agit simplement de liens virtuels qui permettent d'associer des charges a des facture pour tracer facilement les depenses.\r\n\r\nLe cout de la facture est reparti entre sur les parcelles associees (avec prise en compte du taux associe."}, 
#{ :name => "diff", :display => "diff", :desc => ""}])

  TOTAL = 3
  NULL = 4
  DIFF = 1
  
  atype = Struct.new(:id, :name)

  total = atype.new(TOTAL, 'total')
  null  = atype.new(NULL, 'null')
  diff  = atype.new(DIFF, 'diff')

  TYPES = [total, null, diff]

  def initialize
    @factypes = []
  end

  def <<(atype)
    @factypes << atype
  end
  
  def total
    return 2
  end
    
#  TOTAL =   Factype.find(:first, :conditions => ["name = ?", "total"])
#  TOTAL_id =Factype.find(:first, :conditions => ["name = ?", "total"]).id

#  NULL =    Factype.find(:first, :conditions => ["name = ?", "null"])
#  NULL_id = Factype.find(:first, :conditions => ["name = ?", "null"]).id

#  DIFF =    Factype.find(:first, :conditions => ["name = ?", "diff"])
#  DIFF_id = Factype.find(:first, :conditions => ["name = ?", "diff"]).id


end
