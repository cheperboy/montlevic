class Application < ActiveRecord::Base
  
  SAISON = Setting.find(1).saison_id
  SAISON_NAME = Setting.find(1).saison.name

  TOTAL = Factype.find_by_name("total").id
  NULL = Factype.find_by_name("null").id
  DIFF = Factype.find_by_name("diff").id

#  def factype(object)
#    unless object.factype.nil?  
#      id = object.factype_id
#    end
#  end
#  
#  def factype_name(object)
#    for type in Factype::TYPES
#      if type_id == object.id
#        return type.name
#      end
#    end
#  end

  
  
  
end

