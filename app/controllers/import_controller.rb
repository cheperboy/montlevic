class ImportController < ApplicationController


  def test
    @import = Import.new(:pulves)
    # @import.read_sheet(sheet)
    @import.row_num = 10
    @import.calculate
    
  end

  def import_pulves
    sheet = Import.load_sheet('pulves')    
    @result = {}
    @result[:import_ok] = true
    @result[:errors] = []
    
    @import = Import.new(:pulves)
    @import.read_sheet(sheet)
    # puts "datas: #{@datas.inspect}" 
    # if @all_valid.eql?(true)
    #   flash[:notice] += "Creation des pulves suivants:<br>"
    #   #importer tout
    #   @datas[:datas][:pulves].each do |pulve|
    #     @pulve = Pulve.new(pulve)
    #     @pulve.saison_id = current_saison_id
    #     # transforme les checkbox Typeculture en Factoparcelles
    #     # @pulve.update_typecultures(params[:typecultures])
    #     @pulve.uniq_parcelles
    #     if @pulve.save
    #       flash[:notice] += "- #{pulve.name}<br>"
    #     else
    #       @result[:import_ok] = false
    #       # @result[:errors] += @pulve.errors.to_s
    #     end
    #   end
    # else
      puts "from controller. row_num= #{@import.row_num.to_s}"
      # [1..2].each do |id|
      #   @datas[:errors][id].each {|msg| puts "\t\t- #{msg}"}
      # end
      
      @import.datas[:errors][1].each {|msg| puts "\t\t- #{msg}"}
      flash[:error] = "Erreurs, Verifier le Fichier"
    # end
    
    respond_to do |format|
      format.html { render(:action => :import_pulves) }
    end
  end

end