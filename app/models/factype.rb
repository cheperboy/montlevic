class Factype < ActiveRecord::Base
  has_many :factures

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
