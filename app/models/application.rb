class Application < ActiveRecord::Base
  
  SAISON = Setting.find(1).saison_id
  SAISON_NAME = Setting.find(1).saison.name


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

