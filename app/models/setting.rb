class Setting < ActiveRecord::Base

  unless Setting.find(:first).nil?
    DETAIL_PARCELLE = Setting.find(:first).value_parcelle
    DETAIL_DESC = Setting.find(:first).detail_desc
    DETAIL_REF = Setting.find(:first).detail_ref
    FLOAT_PRECISION = Setting.find(:first).float_precision
    TEXT_AREA_SIZE = Setting.find(:first).text_area_size

    FACTURE_DIFF_TO_NULL = false
    FACTURE_DIFF_TO_NULL = true if Setting.find(:first).facture_diff_to_null.eql?(1)
    FACTURE_PRESTA_TO_NULL = false
    FACTURE_PRESTA_TO_NULL = true if Setting.find(:first).facture_presta_to_null.eql?(1)

  end
  
  belongs_to :saison
    
  def self.load
    @current_saison_id = Setting.find(:first).saison
  end

  

  
end
