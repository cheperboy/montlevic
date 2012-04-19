class ImportController < ApplicationController
  MSG_FILE_HAS_WARNINGS = "Verifier les Warnings avant d'importer"
  MSG_FILE_HAS_INVALIDS = "Fichier non valid. <br>Corriger le fichier puis relancer l'importation"
  MSG_FILE_HAS_ERRORS   = "Erreurs lors de l'importation. certains elements n'ont pas ete enregistres"
  MSG_ALL_IMPORTED_OK   = "Tout les elements ont ete importes avec succes"
  MSG_FILE_IS_VALID     = "Fichier OK pour l'importation"

  def import_pulves
    puts "\nImport_pulves"
    @state = :read
    @force = false
    @force = true if params[:force].eql?('true')
    
    sheet = Import.load_sheet('pulves')    
    @import = Import.new(:pulves)
    @import.read_elements(sheet)

    if ((@import.has_invalids.eql?(false) && @import.has_warnings.eql?(false)) ||
    (@import.has_warnings.eql?(true) && @force.eql?(true) && @import.has_invalids.eql?(false)))
      @state = :import
      # @import.elts.each_index {|x| puts "\t\t#{x.to_s}" }
      #importer tout
      @import.import_elements
      if @import.has_errors?
        flash.now[:error] = "#{MSG_FILE_HAS_ERRORS}<br>#{@import.import_size.to_s}/#{@import.row_id.to_s} elements importes"
      else
        if @import.import_size != @import.row_id
          flash.now[:error] = "bug: certains elements non importes mais pas d'erreur trouvee<br> #{@import.import_size.to_s}/#{@import.row_id.to_s} elements importes"
        else
          flash.now[:notice] = "#{MSG_ALL_IMPORTED_OK}<br>#{@import.import_size.to_s}/#{@import.row_id.to_s} elements importes"
        end
      end
    else #state==:analyse
      if @import.has_warnings?
        flash.now[:notice] = MSG_FILE_HAS_WARNINGS
      elsif @import.has_invalids?
        flash.now[:error] = MSG_FILE_HAS_INVALIDS
      else
        flash.now[:notice] = MSG_FILE_IS_VALID
      end
    end
    
    respond_to do |format|
      format.html { render(:action => :import_pulves) }
    end
  end

end



 
