class ImportController < ApplicationController
  MSG_FILE_HAS_WARNINGS  = "Verifier les Warnings avant d'importer"
  MSG_FILE_HAS_INVALIDS  = "Fichier non valid. <br>Corriger le fichier puis relancer l'importation"
  MSG_FILE_HAS_ERRORS    = "Erreurs lors de l'importation. certains elements n'ont pas ete enregistres"
  MSG_ALL_IMPORTED_OK    = "Tout les elements ont ete importes avec succes"
  MSG_FILE_IS_VALID      = "Fichier OK pour l'importation"
  MSG_FILE_SHEET_INVALID = "onglet non trouve dans le fichier excel"
  MSG_FILE_EMPTY         = "Erreur fichier"

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
    Setting.get_saison.produits.all.each {|p| @produits << p.code }
    Setting.get_saison.parcelles.all.each {|p| @parcelles << p.code }
    Setting.get_saison.typecultures.each {|t| @typecultures << t.code }
  end

  def import(sheet)
    action = "import_#{sheet}"
    @import = Import.new(sheet.to_sym)
    @file_error = true
    @state = :read
    @state = :import if params[:import].eql?('true')

    #get file from the database
    file = Store.get_file_for_import

    #Read provided excel sheet from given file and load it
    unless file.nil?
      sheet = Import.load_sheet_from_db(file, sheet)
      unless sheet.nil?
        @file_error = nil
        @import.read_elements(sheet)
        file.close
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
      if @import.has_warnings?
        flash.now[:notice] = MSG_FILE_HAS_WARNINGS
      elsif @import.has_invalids?
        flash.now[:error] = MSG_FILE_HAS_INVALIDS
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

  def import_produits
    sheet = 'produits'
    import(sheet)
  end

  def import_factures
    sheet = 'factures'
    import(sheet)
  end

  def import_pulves_old
    @file_error = true
    @state = :read
    @state = :import if params[:import].eql?('true')

    @import = Import.new(:pulves)

    #get file from the database
    file = Store.get_file_for_import

    #Read provided excel sheet from given file and load it
    unless file.nil?
      sheet = Import.load_sheet_from_db(file, 'pulves')
      unless sheet.nil?
        @file_error = nil
        @import.read_elements(sheet)
        file.close
      else
        flash.now[:error] = "#{MSG_FILE_SHEET_INVALID}"
      end
    else
      flash.now[:error] = "#{MSG_FILE_EMPTY}"
    end
    # launch import if force is true AND no invalids
    if (@state.eql?(:import) && @import.has_invalids.eql?(false))
      puts "\n\nImport_pulves"
      # @import.elts.each_index {|x| puts "\t\t#{x.to_s}" }
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
      puts "\n\nRead_pulves"
      if @import.has_warnings?
        flash.now[:notice] = MSG_FILE_HAS_WARNINGS
      elsif @import.has_invalids?
        flash.now[:error] = MSG_FILE_HAS_INVALIDS
      elsif @file_error
        #do nothing, flash.error already set
      else
        flash.now[:notice] = MSG_FILE_IS_VALID
      end
    end
    
    respond_to do |format|
      format.html { render(:action => :import_pulves) }
    end
  end
  def import_produits_old
    @state = :read
    @state = :import if params[:import].eql?('true')
    #Read provided excel sheet
    sheet = Import.load_sheet('import.xls', 'produits')
    @import = Import.new(:produits)
    @import.read_elements(sheet)
    
    # launch import if force is true AND no invalids
    if (@state.eql?(:import) && @import.has_invalids.eql?(false))
      puts "\n\nImport_produits"
      # @import.elts.each_index {|x| puts "\t\t#{x.to_s}" }
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
      puts "\n\nRead_produits"
      if @import.has_warnings?
        flash.now[:notice] = MSG_FILE_HAS_WARNINGS
      elsif @import.has_invalids?
        flash.now[:error] = MSG_FILE_HAS_INVALIDS
      else
        flash.now[:notice] = MSG_FILE_IS_VALID
      end
    end
    
    respond_to do |format|
      format.html { render(:action => :import_produits) }
    end
  end
  def import_factures_old
    @state = :read
    @force = false
    @force = true if params[:force].eql?('true')

    sheet = Import.load_sheet('import.xls', 'factures')
    @import = Import.new(:factures)
    @import.read_elements(sheet)

    # launch import if force is true AND no invalids
    if (@force.eql?(true) && @import.has_invalids.eql?(false))
      puts "\n\nImport_factures"
      @state = :import
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
    else #state==:analyse
      puts "\n\nRead_Factures"
      if @import.has_warnings?
        flash.now[:notice] = MSG_FILE_HAS_WARNINGS
      elsif @import.has_invalids?
        flash.now[:error] = MSG_FILE_HAS_INVALIDS
      else
        flash.now[:notice] = MSG_FILE_IS_VALID
      end
    end
  end
    
end



