class Setting < ActiveRecord::Base
  
  DETAIL_PARCELLE = Setting.find(:first).value_parcelle
  DETAIL_DESC = Setting.find(:first).detail_desc
  DETAIL_REF = Setting.find(:first).detail_ref
  
  belongs_to :saison
  
  
  def self.load
    session[:saison_id] = Setting.find(1).saison
  end
      
end
