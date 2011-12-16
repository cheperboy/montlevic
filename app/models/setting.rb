class Setting < ActiveRecord::Base
  # t.integer "saison_id",                    :null => false
  # t.integer "value_parcelle",               :limit => 2
  # t.integer "detail_desc",                  :limit => 2
  # t.integer "detail_ref",                   :limit => 2
  # t.integer "float_precision"
  # t.string  "text_area_size"
  # t.integer "show_reportable",              :limit => 2

  unless Setting.find(:first).nil?
    DETAIL_PARCELLE = Setting.find(:first).value_parcelle
    DETAIL_DESC = Setting.find(:first).detail_desc
    DETAIL_REF = Setting.find(:first).detail_ref
    FLOAT_PRECISION = Setting.find(:first).float_precision
    TEXT_AREA_SIZE = Setting.find(:first).text_area_size

    SHOW_REPORTABLE = false
    SHOW_REPORTABLE = true if Setting.find(:first).show_reportable.eql?(1)
    
    CHARGES_INCLUDE_MAISON = false
    CHARGES_INCLUDE_MAISON = true if Setting.find(:first).charges_include_maison.eql?(1)
    CHARGES_INCLUDE_INVEST = false
    CHARGES_INCLUDE_INVEST = true if Setting.find(:first).charges_include_invest.eql?(1)
    CHARGES_INCLUDE_STOCK_PRODUIT = false
    CHARGES_INCLUDE_STOCK_PRODUIT = true if Setting.find(:first).charges_include_stock_produit.eql?(1)
  end
  
  belongs_to :saison
    
  def self.load
    @current_saison_id = Setting.find(:first).saison
  end

  

  
end
