class PrintCsv < ActiveRecord::Base
  require 'csv'

  def pretty_csv(val)
    precision = 1
    return nil if (val.equal?(0))
    return nil if (val == 0.0)
    return val.to_i if (val == val.to_i)
    return val if precision == 0
    return (val * 10 ** precision).round.to_f / 10 ** precision
  end
  
  def csv_put_tete(w, model)
    row = []
    ((self.csv[:nb_cols] * 2) + self.csv[:nb_row_before]).times { row << nil }
    csv_write(w, row)
    
    row.clear
    row = [model.to_s.pluralize]
    ((self.csv[:nb_cols] * 2) + self.csv[:nb_row_before] - 1 ).times { row << nil }
    csv_write(w, row)
    row.clear
  end
    
  def csv_init
    self.csv = {}
    self.csv[:html] = ''
    self.csv[:nb_cols] = self.Tcols[:length]
    self.csv[:nb_row_before] = 5
    self.csv[:nb_row_total] = csv[:nb_cols] + self.csv[:nb_row_before]
  end
  
  def csv_write(w, row)
    logger.info 'CSV' + row.to_s
    w << row
    row.each do |col|
      self.csv[:html] += col.to_s + ', '
    end    
    self.csv[:html] += '<br>'  
  end

  def csv_tete(w)
    row = []
    self.csv[:nb_row_before].times do row << nil end
    self.Tcols[:ids].each do |id|
      row << self.Tcols[id][:name]
      row << (self.Tcols[id][:surface].to_s + ' Ha')
    end
    csv_write(w, row)  
    
    row.clear
    row = [nil, 'nom', 'passage Ha', 'total/Ha', 'total'] 
    entete = ['c/Ha', 'total']
    (self.csv[:nb_cols]).times { row += entete }
    csv_write(w, row)
  end
  
  def csv_labours(w)
    row = []
    csv_put_tete(w, 'labour')
    @labours.each do |labour|
      dep = self.Tlabours[labour.id]
      cell = labour.parcelles.length.to_s
      cell += ' p - '
      cell += pretty_csv(dep[:surface_total]).to_s
      cell += ' ha'
      row << cell
      row << labour.name
      row << pretty_csv(dep[:ha_passage]).to_s
      row << pretty_csv(dep[:ha_total]).to_s
      self.Tcols[:ids].each do |id|
        row << pretty_csv(dep[id][:ha])
        row << pretty_csv(dep[id][:total])
      end
      csv_write(w, row)
      row.clear
    end
    
    #Total labour
    row.clear
    row << ['Total Labour']
    (self.csv[:nb_row_before] - 3).times { row << nil }    
    row << pretty_csv(self.Tlabours[:total])
    row << pretty_csv(self.Tlabours[:ha_total])
    self.Tcols[:ids].each do |id|
      row <<  pretty_csv(self.Tcols[id][:labours][:ha])
      row <<  pretty_csv(self.Tcols[id][:labours][:total])
    end
    csv_write(w, row)  
  end

  def csv_pulves(w)
    csv_put_tete(w, 'pulve')
    row = []
    @pulves.each do |pulve|
      dep = self.Tpulves[pulve.id]
      cell = pulve.parcelles.length.to_s
      cell += ' p - '
      cell += pretty_csv(dep[:surface_total]).to_s
      cell += ' ha'
      row << cell
      row << pulve.name
      cell = pretty_csv(dep[:ha_passage]).to_s
      cell += ' + '
      cell += pretty_csv(dep[:ha_produit]).to_s
      cell += ' = '
      cell += pretty_csv(dep[:total]).to_s
      row << cell
      row << pretty_csv(dep[:ha_total]).to_s
      self.Tcols[:ids].each do |id|
        row << pretty_csv(dep[id][:ha])
        row << pretty_csv(dep[id][:total])
      end
      csv_write(w, row)
      row.clear
    end

    row.clear
    row << ['Total Pulves']
    (self.csv[:nb_row_before] - 3).times { row << nil }    
    row << pretty_csv(self.Tpulves[:ha_total])
    row << pretty_csv(self.Tpulves[:total])
    self.Tcols[:ids].each do |id|
      row <<  pretty_csv(self.Tcols[id][:pulves][:ha])
      row <<  pretty_csv(self.Tcols[id][:pulves][:total])
    end
    csv_write(w, row)  
  end
  
  def csv_factures(w)
    row = []
    csv_put_tete(w, 'facture')
    @factures.each do |facture|
      dep = self.Tfactures[facture.id]
      cell = facture.parcelles.length.to_s
      cell += ' p - '
      cell += pretty_csv(dep[:surface_total]).to_s
      cell += ' ha'
      row << cell
      row << facture.name
      row << pretty_csv(dep[:total]).to_s
      row << pretty_csv(dep[:ha]).to_s
      self.Tcols[:ids].each do |id|
        row << pretty_csv(dep[id][:ha])
        row << pretty_csv(dep[id][:total])
      end
      csv_write(w, row)
      row.clear
    end
    
    #Total
    row.clear
    row << ['Total Factures']
    (self.csv[:nb_row_before] - 3).times { row << nil }    
    row << pretty_csv(self.Tfactures[:ha][:sum])
    row << pretty_csv(self.Tfactures[:total][:sum])
    self.Tcols[:ids].each do |id|
      row <<  pretty_csv(self.Tcols[id][:factures][:ha][:sum])
      row <<  pretty_csv(self.Tcols[id][:factures][:total][:sum])
    end
    csv_write(w, row)  
  end
  
  def csv_total_charges(w)
    row = []
    csv_put_tete(w, 'vente')
    @ventes.each do |pulve|
      dep = self.Tpulves[pulve.id]
    end
  end
  
  def write_csv2
    
    csv_init()
  #Labours
    #tete  
    row.clear
    ((nb_cols * 2)+ nb_cols_before).times { row << nil }
    writer << row
    
    row.clear
    row = ['Labours']
    ((nb_cols * 2)+ nb_cols_before - 1 ).times { row << nil }
    writer << row
    
    #each labour
    row.clear
    @labours.each do |labour|
      dep = self.Tlabours[labour.id]
      cell = labour.parcelles.length.to_s
      cell += ' p - '
      cell += pretty_csv(dep[:surface_total]).to_s
      cell += ' ha'
      row << cell
      row << labour.name
      row << pretty_csv(dep[:ha_passage]).to_s
      row << pretty_csv(dep[:ha_total]).to_s
      self.Tcols[:ids].each do |id|
        row <<  get_value_or_blank(dep[id], "cout_ha")
        row <<  get_value_or_blank(dep[id], "cout_total") 
      end
      writer << row
      row.clear
    end
    
    #Total labour
    row.clear
    row << ['Total Labour']
    (nb_cols_before - 2).times { row << nil }
    
    row << pretty_csv(self.Tlabours[:total])
    self.Tcols[:ids].each do |id|
      row <<  get_value_or_blank(self.Tcols[id][:labours], "cout_ha")
      row <<  get_value_or_blank(self.Tcols[id][:labours], "cout_total")
    end
    writer << row
    row.clear

    
  #Pulves
    #tete  
    row.clear
    ((nb_cols * 2)+ nb_cols_before).times { row << nil }
    writer << row
    
    row.clear
    row = ['Pulves']
    ((nb_cols * 2)+ nb_cols_before - 1 ).times { row << nil }
    writer << row
    
    #each pulve
    row.clear
    @pulves.each do |pulve|
      dep = self.Tpulves[pulve.id]
      cell = pulve.parcelles.length.to_s
      cell += ' p - '
      cell += pretty_csv(dep[:surface_total]).to_s
      cell += ' ha'
      row << cell
      row << pulve.name
      
      cell = pretty_csv(dep[:ha_passage]).to_s
      cell += ' + '
      cell += pretty_csv(dep[:ha_produit]).to_s
      row << cell
      row << pretty_csv(dep[:ha_total]).to_s
      self.Tcols[:ids].each do |id|
        row <<  get_value_or_blank(dep[id], "cout_ha")
        row <<  get_value_or_blank(dep[id], "cout_total") 
      end
      writer << row
      row.clear
    end   
    
    #Total pulve
    row.clear
    row << ['Total Pulves']
    (nb_cols_before - 2).times { row << nil }
    
    row << pretty_csv(self.Tpulves[:total])
    self.Tcols[:ids].each do |id|
      row <<  get_value_or_blank(self.Tcols[id][:pulves], "cout_ha")
      row <<  get_value_or_blank(self.Tcols[id][:pulves], "cout_total")
    end
    writer << row
    row.clear

  #Factures
    #tete  
    row.clear
    ((nb_cols * 2)+ nb_cols_before).times { row << nil }
    writer << row
    
    row.clear
    row = ['Factures']
    ((nb_cols * 2)+ nb_cols_before - 1 ).times { row << nil }
    writer << row
    
    #each facture
    row.clear
    @factures.each do |facture|
      dep = self.Tfactures[facture.id]
      cell = facture.parcelles.length.to_s
      cell += ' p - '
      cell += pretty_csv(dep[:surface_total]).to_s
      cell += ' ha'
      row << cell
      row << facture.name
     
      row << pretty_csv(dep[:ha]).to_s
      row << pretty_csv(dep[:total]).to_s
      self.Tcols[:ids].each do |id|
        row <<  get_value_or_blank(dep[id], "cout_ha")
        row <<  get_value_or_blank(dep[id], "cout_total") 
      end
      writer << row
      row.clear
    end   

    #Total facture par type
      for type in @types
        row.clear
        row << 'Total '+ type.name
        (nb_cols_before - 2).times { row << nil }
        
        row << pretty_csv(self.Tfactures[:total][type.name]).to_s
        self.Tcols[:ids].each do |id|
          row <<  pretty_csv(self.Tcols[id][:charges][:ha][type.name])
          row <<  pretty_csv(self.Tcols[id][:charges][:total][type.name])
        end
        writer << row
        row.clear
      end
    
    #Total facture
    row.clear
    row << ['Total Factures']
    (nb_cols_before - 2).times { row << nil }
    
    row << pretty_csv(self.Tfactures[:total][:sum])
    self.Tcols[:ids].each do |id|
      row <<  get_value_or_blank(self.Tcols[id][:factures][:ha], "sum")
      row <<  get_value_or_blank(self.Tcols[id][:factures][:total], "sum")
    end
    writer << row
    row.clear


    #Total total
    row.clear
    row << ['Total']
    (nb_cols_before - 3).times { row << nil }
    
    row << pretty_csv(self.Tcols[:ha])
    row << pretty_csv(self.Tcols[:total])
    self.Tcols[:ids].each do |id|
      row <<  get_value_or_blank(self.Tcols[id][:charges][:ha], "sum")
      row <<  get_value_or_blank(self.Tcols[id][:charges][:total], "sum")
    end
    writer << row
    row.clear
    
  end
  
end
