class Application < ActiveRecord::Base

  SAISON = Setting.find(1).saison_id

  LABOUR_HEAD = [
  	['star', 'star', ''], 
  	['adu', 'adu', ''], 
  	['id', 'id', ''], 
  	['category_name', 'categorie', ''], 
  	['user_name', 'Presta', ''], 
  	['name', 'nom', ''], 
  	['cout_ha_passage', 'Cout Ha', '€/Ha'], 
  	['print_date', 'date', '']]
  
  PULVE_HEAD = [
  	['star', 'star', ''], 
  	['adu', 'adu', ''], 
  	['id', 'id', ''], 
  	['typecultures', 'Cultures', ''], 
  	['category_name', 'categorie', ''], 
  	['user_name', 'Presta', ''], 
  	['name', 'nom', ''], 
  	['dosage', 'Dosage', 'L/Ha'], 
  	['cout_ha_passage', 'Cout Ha', '€/Ha'], 
  	['print_date', 'date', '']]

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
