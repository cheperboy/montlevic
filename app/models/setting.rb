class Setting < ActiveRecord::Base

  unless Setting.find(:first).nil?
    DETAIL_PARCELLE = Setting.find(:first).value_parcelle
    DETAIL_DESC = Setting.find(:first).detail_desc
    DETAIL_REF = Setting.find(:first).detail_ref
  end
  
  belongs_to :saison
    
  def self.load
    session[:saison_id] = Setting.find(:first).saison
  end

end
