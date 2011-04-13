class Application < ActiveRecord::Base

  
  
  SAISON = Setting.find(1).saison_id
#  SAISON_NAME = Setting.find(1).saison.name

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
  
  # Used in Print.rb
  def get_value_or_blank(var, value)
    val = var[value.to_sym]
    return (pretty_csv(val))
  end
  
  # Used in Print.rb
  # Info : same methode declared in Application-helper
  def pretty_csv(val)
    precision = 1
    return nil if (val.equal?(0))
    return nil if (val == 0.0)
    return val.to_i if (val == val.to_i)
    return val if precision == 0
    return (val * 10 ** precision).round.to_f / 10 ** precision
  end
  
end
