class Factype < ActiveRecord::Base
  has_many :factures

#Chargement des id des 3 Factype en tant que constantes:
unless Factype.find(:first).nil?
  TOTAL = Factype.find_by_name("total").id
  NULL = Factype.find_by_name("null").id
  DIFF = Factype.find_by_name("diff").id
end

#  
#  atype = Struct.new(:id, :name)
#
#  total = atype.new(TOTAL, 'total')
#  null  = atype.new(NULL, 'null')
#  diff  = atype.new(DIFF, 'diff')
#
#  TYPES = [total, null, diff]
#
#  def initialize
#    @factypes = []
#  end
#
#  def <<(atype)
#    @factypes << atype
#  end
#  
#  def total
#    return 2
#  end

end

#SAVE DATA:
#{ :name => "diff", :display => "diff", :desc => "Les charges associees a cette facture sont affectees a chaques depenses (pulves et labours).\r\nLa somme de toutes les charges associees a la facture est deduit du cout de la facture et le reste (cout_facture - somme_des_charges) est reparti sur les parcelles associees a la facture."}, 
#{ :name => "total", :display => "cout total", :desc => "Les charges associees a cette facture ne sont pas deduites du cout de la facture.\r\n\r\nIl s'agit simplement de liens virtuels qui permettent d'associer des charges a des facture pour tracer facilement les depenses.\r\n\r\nLe cout de la facture est reparti entre sur les parcelles associees (avec prise en compte du taux associe."}, 
#{ :name => "diff", :display => "diff", :desc => ""}])
