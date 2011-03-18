class Report < Facture
  #"Report = Facture fictive" provenant d'un papier d'une saison precedante qui est reporte 
  #a la saison a laquelle appartient ce Report
  set_table_name "factures"
  belongs_to :reportable, :class_name => "Reportable", :foreign_key => :reportable_id


end
