# bug: une erreur vue a la lecture du fichier (exemple saison fichier differente de Setting.saison_id)
    # -> pas d'affichage des elements mais le bouton "importer" est toujours present et actif.
    #  par contre ce bouton semble etre sans consequences si on clique
    
class ImportController < ApplicationController
  MSG_FILE_HAS_WARNINGS  = "Verifier les Warnings avant d'importer"
  MSG_FILE_HAS_INVALIDS  = "Fichier non valid. <br>Corriger le fichier puis relancer l'importation"
  MSG_FILE_HAS_ERRORS    = "Erreurs lors de l'importation. certains elements n'ont pas ete enregistres"
  MSG_ALL_IMPORTED_OK    = "Tout les elements ont ete importes avec succes"
  MSG_FILE_IS_VALID      = "Fichier OK pour l'importation"
  MSG_FILE_SHEET_INVALID = "onglet non trouve dans le fichier excel"
  MSG_FILE_EMPTY         = "Erreur fichier"
  MSG_WRONG_SAISON       = "Saison en case B2 du fichier excel differente de la saison courante du logiciel"

  def index
    redirect_to(:action => :prepare)
  end

  def test
    puts "test"
    logger.error "logger"
    file = File.open("#{Store.first.file.url}")
    stores = Store.find(:all)
    store = Store.new
  end

  def prepare
    # @import = Import.new(:pulves)
    # @toto = Object.new
    # puts "@import.inspect: #{@import.to_yaml}"
    # @file = params[:store][:file] if params[:store]
    if params[:store] && !params[:store][:file].nil?
      Store.clean
      @file = Store.new(params[:store])
      @file.save_to_db(Store::IMPORT)
    end
    #prepare
    @users        = ['Prestataires']
    @parcelles    = ['Parcelles']
    @produits     = ['Produits']
    @typecultures = ['Cultures']
    User.all.each {|u| @users << u.code }
    current_saison = Saison.find(current_saison_id)
    current_saison.produits.all.each {|p| @produits << p.code }
    current_saison.parcelles.all.each {|p| @parcelles << p.code }
    current_saison.typecultures.each {|t| @typecultures << t.code }
  end

  def import(sheet)
    action = "import_#{sheet}"
    @import = Import.new(sheet.to_sym)
    @file_error = true
    @state = :read
    @state = :import if params[:import].eql?('true')

    #get file from the database
    file = Store.get_file_for_import_from_s3
    # file = Store.get_file_for_import
    
    #Read provided excel sheet from given file and load it
    unless file.nil?
      sheet = Import.load_sheet_from_db(file, sheet)
      unless sheet.nil?
        unless @import.wrong_saison(sheet)
          @file_error = nil
          @import.read_elements(sheet)
          file.close
        else
          flash.now[:error] = "#{MSG_WRONG_SAISON}"
        end
      else
        flash.now[:error] = "#{MSG_FILE_SHEET_INVALID}"
      end
    else
      flash.now[:error] = "#{MSG_FILE_EMPTY}"
    end
    # launch import if force is true AND no invalids
    if (@state.eql?(:import) && @import.has_invalids.eql?(false))
      #importer tout
      @import.import_elements
      if @import.has_errors?
        flash.now[:error] = "#{MSG_FILE_HAS_ERRORS}<br>#{@import.import_size.to_s}/#{@import.read_size.to_s} elements importes"
      else
        if @import.import_size != @import.read_size
          flash.now[:error] = "bug: certains elements non importes mais pas d'erreur trouvee<br> #{@import.import_size.to_s}/#{@import.read_size.to_s} elements importes"
        else
          flash.now[:notice] = "#{MSG_ALL_IMPORTED_OK}<br>#{@import.import_size.to_s}/#{@import.read_size.to_s} elements importes"
        end
      end
    else #state==:read
      if @import.has_invalids?
        flash.now[:error] = MSG_FILE_HAS_INVALIDS
      elsif @import.has_warnings?
        flash.now[:notice] = MSG_FILE_HAS_WARNINGS
      elsif @file_error
        #do nothing, flash.error already set
      else
        flash.now[:notice] = MSG_FILE_IS_VALID
      end
    end    
    respond_to do |format|
      format.html { render(:action => action.to_sym) }
    end    
  end
  
  def import_pulves
    sheet = 'pulves'
    import(sheet)
  end

  def import_labours
    sheet = 'labours'
    import(sheet)
  end

  def import_produits
    sheet = 'produits'
    import(sheet)
  end

  def import_factures
    sheet = 'factures'
    import(sheet)
  end

  def import_ventes
    sheet = 'ventes'
    import(sheet)
  end

end



