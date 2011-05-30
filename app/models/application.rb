class Application < ActiveRecord::Base

  SAISON = Setting.find(1).saison_id

  # HEADER_KEY = 0
  # HEADER_VALUE = 1
  # HEADER_UNIT = 2
  # HEADER_FILTER = 3
  
  LABOUR_HEAD = [
  	['star', 'star', ''], 
  	['adu', 'adu', ''], 
  	['id', 'id', ''], 
  	['typecultures', 'Cultures', ''], 
  	['category_name', 'categorie', ''], 
  	['user_name', 'Presta', ''], 
  	['name', 'nom', ''], 
  	['cout_ha_passage', 'Cout Ha', '€/Ha'], 
  	['print_date', 'date', '']]
  
  PULVE_HEAD = [
  	['star', 'star', '', true, :check_box], 
  	['adu', 'adu', '', true, :check_box], 
  	['id', 'id', '', false], 
  	['typecultures', 'Cultures', '', false], 
  	['category_name', 'categorie', '', false, :text_field], 
  	['user_name', 'Presta', '', false, :text_field], 
  	['name', 'nom', '', true, :text_field], 
  	['dosage', 'Dosage', 'L/Ha', false], 
  	['cout_ha_passage', 'Cout Ha', '€/Ha', false], 
  	['print_date', 'date', '', false]]

  FACTURE_HEAD = [
  	['star', 'star', ''], 
  	['adu', 'adu', ''], 
  	['id', 'id', ''], 
  	['category_name', 'cat', ''], 
  	['factcat_name', 'class', ''], 
  	['print_factype', 'compta', ''], 
  	['type', 'type', ''], 
  	['user_name', 'Presta', ''], 
  	['name', 'nom', ''], 
  	['cout', 'Cout', '€'], 
    # ['ref_client', 'Ref Client, '€'], 
    # ['ref', 'Ref', '€'], 
  	['print_date', 'date', '']]

  
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
