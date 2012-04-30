Spreadsheet.client_encoding = 'LATIN1//TRANSLIT//IGNORE'
# TODO: Class Pulve: ajouter une validation pour cout_ha_passage>0
# TODO: gerer les conversions texte->integer. faire des tests avec excel
# TODO: Verifier aue pulve.after_save est coherent meme si appele plusieur foir pour un meme pulve


class Import < ActiveRecord::Base
  attr_accessor :row_id,      # nombre d'elements lu lors de l'analyse du fichier
                :import_size, # nombre d'elements importes avec succes
                :read_size,   # nombre d'elements a importer (pulves, factures, mais pas putoproduits, putoparcelles, ...)
                :type,        # 'pulves', 'factures'
                :elts,        # tableau de Pulves, Factures...
                :putoprods,   # tableau de produits d'un pulve
                :parcelles,   # tableau de parcelles d'un elt
                :cultures,   # tableau de cultures d'un elt
                :remarks,     # tableau d'info sur le fichier, non specifique a une row
                :warnings,      :invalids,      :errors,    #tableaux d'erreurs
                :has_warnings,  :has_invalids,  :has_errors #presence d'erreur

  # ----- Constantes -----

  XLS_ROW_NUM                  = 0
  XLS_TYPE                     = 1

  XLS_PULVE_COUT_HA_PASSAGE    = 2
  XLS_PULVE_DATE               = 3
  XLS_PULVE_CATEGORY           = 4
  XLS_PULVE_NAME               = 5
  XLS_PULVE_USER               = 6
  XLS_PULVE_TYPECULTURS        = 7
  XLS_PULVE_PARCELLES          = 8
  XLS_PULVE_DESC               = 9
  XLS_PULVE_INFO               = 10

  XLS_PUTOPRODUIT_PRODUIT_CODE = 11
  XLS_PUTOPRODUIT_DOSAGE       = 12
  XLS_PUTOPRODUIT_DOSAGE_VRAI  = 13
  XLS_PUTOPRODUIT_QUANTITE     = 14
  XLS_PUTOPRODUIT_DESTOCKER    = 15

  XLS_PULVES_USERS_COLUMN      = 31 #col pour ecrir la liste des users codes

  def initialize(elt_type)
    # Pulve.find(:all).each do |pu|
    #   if pu.id > 77
    #     puts "delete #{pu.id}"
    #     pu.destroy
    #   end
    # end
    # Putoproduit.find(:all).each do |pu|
    #   if pu.pulve_id.nil?
    #     puts "delete #{pu.id}"
    #     pu.destroy
    #   end
    # end

    @sym = elt_type
    @saison = Setting.get_saison
    @last_pulve_id = nil
    @import_size   = 0
    @read_size     = 0
    @row_id        = 0
    @has_errors    = false
    @has_warnings  = false
    @has_invalids  = false
    @putoprods = [] # Used only for pulves import
    @elts      = []  
    @parcelles = []
    @cultures  = []
    @invalids  = []  
    @warnings  = []  
    @errors    = []  
    @remarks   = [] #general errors, not affected to a specific row 
  end

  #lecture du fichier
  def read_elements(sheet)
    @row_id = 0
    sheet.each do |row|
      unless ignore_this_row(row)
        @elts[@row_id]      = []
        @parcelles[@row_id] = []
        @cultures[@row_id] = []
        @invalids[@row_id]  = []
        @warnings[@row_id]  = []
        @errors[@row_id]    = []
        element = read_element(row)
        @elts[@row_id] = element
        @row_id += 1
      end
    end
  end
  def read_element(row)
    if row[XLS_TYPE].eql?('pulve')
      @read_size += 1
      return read_pulve(row)
    elsif row[XLS_TYPE].eql?('putoproduit')
      return read_putoproduit(row)
    else
      add_remark("le fichier comporte un type invalid")
    end
  end
  def read_pulve(row)
    pulve = Pulve.new()
    cout_ha_passage = get_cout_ha_passage(row[XLS_PULVE_COUT_HA_PASSAGE], @row_id)
    category_id = get_category(row[XLS_PULVE_CATEGORY], @row_id)
    user_id     = get_user_id(row[XLS_PULVE_USER], @row_id)
    date        = get_date(row[XLS_PULVE_DATE], @row_id)
    name        = get_name(row[XLS_PULVE_NAME], @row_id)
    parcelles   = get_parcelles(row[XLS_PULVE_PARCELLES], @row_id)
    cultures    = get_cultures(row[XLS_PULVE_TYPECULTURS], @row_id)
    desc        = get_text(row[XLS_PULVE_DESC], @row_id)
    info        = get_text(row[XLS_PULVE_INFO], @row_id)
    pulve.update_attributes(
      :name            => name,
      :user_id         => user_id, 
      :category_id     => category_id,
      :date            => date, 
      :cout_ha_passage => cout_ha_passage) 
    @last_pulve_read = @row_id
    @putoprods[@last_pulve_read] = []
    check_parcelles_and_cultures_size(@row_id)
    check_pulve_already_imported(pulve, @row_id)
    return(pulve)
  end
  def read_putoproduit(row)
    elt             = Putoproduit.new()
    elt.produit_id  = get_putoproduit_produit_id(row[XLS_PUTOPRODUIT_PRODUIT_CODE], @row_id)
    elt.dosage      = get_numeric_field(row[XLS_PUTOPRODUIT_DOSAGE],      @row_id, 'dosage',      {:if_neg => :error})
    elt.dosage_vrai = get_numeric_field(row[XLS_PUTOPRODUIT_DOSAGE_VRAI], @row_id, 'dosage vrai', {:if_neg => :error})
    elt.quantite    = get_numeric_field(row[XLS_PUTOPRODUIT_QUANTITE],    @row_id, 'quantite',    {:if_neg => :error})
    elt.destocker   = get_boolean_field(row[XLS_PUTOPRODUIT_DESTOCKER],   @row_id, 'destocker',   {:invalid => :warning})
    puts "\t#{elt.to_yaml}"
    @putoprods[@last_pulve_read] << elt

    check_putoproduit(elt, @row_id)
    return(elt)
  end
  
# Import Elements
  def import_elements
    @elts.each_with_index do |elt, index|
      import_element(elt, index)
    end
  end  
  def import_element(elt, index)
    if elt.class.eql?(Pulve)
      import_pulve(elt, index)
    elsif elt.class.eql?(Putoproduit)
      #import_putoproduit(elt, index)
    else
      add_remark("le fichier comporte un type invalid #2")
    end
  end
  
  def import_pulve(elt, index)
    import_ok = true
    import_failed = true
    merge_parcelles_and_cultures(elt, index)
    elt.saison_id = @saison.id
    if elt.save
      @parcelles[index].each do |parcelle|
        res = import_putoparcelle(elt, parcelle, index)
        import_ok = false if res==false
      end
      @putoprods[index].each do |putoprod|
        res = import_putoproduit(elt, putoprod, index)
        import_ok = false if res==false
      end
      elt.reload # get the record from db
      elt.save!  # force the call to after_save to update putoproduits
      # elt.putoparcelles.each {|p| puts "\t\t\t\t#{p.parcelle.name}" }
      if import_ok.eql?(false)
        elt.destroy
      else
        @import_size += 1
      end
    else #elt not saved
      self.add_error(elt.errors, index)
    end
  end
    
  def import_putoparcelle(pulve, parcelle, index)
    import_sucess = false
    putopar = Putoparcelle.new(
    :pulve_id     => pulve.id,
    :parcelle_id  => parcelle.id,
    :value => 1)
    
    if putopar.valid?
      if putopar.save
        import_sucess = true
      else
        self.add_error("parcelle '#{parcelle.try(:name)}' non enregistree", index)
        self.add_error(putopar.errors, index)
      end
    else # putopar not valid
      self.add_error("parcelle '#{parcelle.try(:name)}' non valide", index)
      self.add_error(putopar.errors, index)
      return false
    end
    return import_sucess
  end
  def import_putoproduit(pulve, putoprod, index)
    import_ok = true
    putoprod.pulve_id = pulve.id
    if putoprod.save
      import_ok = true
    else
      import_ok = false
      produit = putoprod.try(:produit).try(:name) || ''
      self.add_error("produit '#{produit}' non valide", index)
      self.add_error(putoprod.errors, index)
    end
    return import_ok
  end
    
  def inspect_errors(id)
    # puts "\t\t#{id.to_s} @errors size:#{@errors[id].size.to_s}"
    @errors[id].each do |err, err_id|
      # puts "\t\terror :#{err_id.to_s}: #{err.to_s}"
    end
  end
  def add_error(error, id)  
    if error.class.eql?(String)
      @errors[id] << "#{error}"
    else
      error.each do |err, err_id|
        @errors[id] << "#{err.to_s}: #{err_id.to_s}"
      end
    end
    @has_errors = true
    inspect_errors(id)     
  end

  # True/False
  def has_warnings?
    has_warnings.eql?(true)
  end
  def has_invalids?
    has_invalids.eql?(true)
  end
  def has_errors?
    has_errors.eql?(true)
  end

private
  def add_remark(remark)
    @remarks << "#{remark}"
  end
  def add_invalid(invalid, id)
    @invalids[id] << "#{invalid}"
    @has_invalids = true
  end
  def add_parcelle(parcelle, id)
    @parcelles[id] << parcelle
  end
  def add_culture(culture, id)
    @cultures[id] << culture
  end
  def add_warning(warning, id)
    @warnings[id] << "#{warning}"
    @has_warnings = true
  end

  def invalid_already_exist(invalid, id)
    @invalids[id].include?(invalid)
  end
  def warning_already_exist(warning, id)
    @warnings[id].include?(warning)
  end
  
# Read Element fields
  def get_user_id(user_code, id)
    if user = User.find_by_code(user_code)
      return user.id
    else
      invalid = 'user not found'
      add_invalid(invalid, id)
    end
  end
  def get_name(name, id)
    if (!name.nil? && name.class.eql?(String))
      return name
    else
      invalid = 'nom non valid'
      add_invalid(invalid, id)
    end
  end
  def get_date(date, id)
    if date.class.eql?(String)
      return date
    else
      invalid = "la date n'est au bon format"
      add_invalid(invalid, id)
    end
  end  
  def get_text(text, id)
    return text
  end
  def get_parcelles(parcelles_raw, id)
    if parcelles_raw.class.eql?(String)
      parcelles = parcelles_raw.split(/,\s*/)
      unless parcelles.size.eql?(0)
        parcelles.each do |parcelle_code|
          parcelle = @saison.parcelles.find_by_code(parcelle_code)
          unless parcelle.nil?
            add_parcelle(parcelle, id)
          else
            invalid = "parcelle '#{parcelle_code}' non trouvee"
            add_invalid(invalid, id)
          end
        end
      else
        invalid = "parcelles non valides"
        add_invalid(invalid, id)        
      end
    end
  end
  def get_cultures(cultures_raw, id)
    if cultures_raw.class.eql?(String)
      cultures = cultures_raw.split(/,\s*/)
      unless cultures.size.eql?(0)
        cultures.each do |culture_code|
          culture = @saison.typecultures.find { |t| t.code == culture_code }
          unless culture.nil?
            # culture.parcelles.each do |parcelle|
              add_culture(culture, id)
            # end
          else
            invalid = "culture '#{culture_code}' non trouvee"
            add_invalid(invalid, id)
          end
        end
      else
        invalid = "cultures non valides"
        add_invalid(invalid, id)
      end
    end
  end

# Read Pulve fields
  def get_cout_ha_passage(cout_ha_passage, id)
      return cout_ha_passage
    # else
    #   invalid = "cout_ha_passage n'est pas un nombre"
    #   add_invalid(invalid, id)
    # end
  end
  def get_category(category_code, id)
    category = Category.find_by_code(category_code)
    if (category && category.parent.eql?(Category.root_pulve))
      return category.id
    else
      invalid = 'categorie non valide'
      add_invalid(invalid, id)
    end
  end

  # doit etre appeler juste avant import d'un element
  # remplace @parcelles[elt_id] par le merge de @cultures[elt_id] et @parcelles[elt_id]   
  def merge_parcelles_and_cultures(pulve, id)
    parcelles = []
    parcelles = @parcelles[id].uniq
    @cultures[id].each do |culture|
      culture.parcelles.each do |parcelle|
        parcelles << parcelle
      end
    end
    @parcelles[id] = parcelles.uniq
    # puts "\tParcelles"
    # @parcelles[id].each do |msg|
    #   puts "\t\t#{msg.name.to_s}"
    # end
    # 
    # puts "\tCultures"
    # @cultures[id].uniq.each do |culture|
    #   puts "\t\t#{culture.name.to_s}"
    #   culture.parcelles.each do |parcelle|
    #     puts "\t\t\t#{parcelle.name.to_s}"
    #   end
    # end    
  end

# Check elements
  def check_pulve_already_imported(element, id)
    Pulve.find_by_saison(:all).each do |pulve|
      if (pulve.name.eql?(element.name))
        invalid = "semble etre deja importe"
        add_warning(invalid, id) unless warning_already_exist(invalid, id)
      end
    end
  end  
  def check_parcelles_and_cultures_size(id)
    if @parcelles[id].size.eql?(0) && @cultures[id].size.eql?(0)
      warning = "aucune parcelle identifiee"
      add_warning(warning, id)
    end
  end
  
  def check_putoproduit(putoproduit, id)
    if putoproduit.destocker.nil? && putoproduit.quantite.blank? && putoproduit.dosage.nil?
      invalid = "indiquer dosage ou quantite ou destocker"
      add_invalid(invalid, id)
    end
  end
  
# Read Elements fields
  def is_numeric?(value)
    # return false
    (!value.nil? && !value.to_i.eql?('') && (value.class.eql?(Integer) || value.class.eql?(Float)))
  end
  def is_boolean?(value)
    value.eql?('oui') || value.eql?('non') || value.eql?('') || value.nil?
  end  
  def booleanize(value)
    return 1 if (is_boolean?(value) && value.eql?('oui'))
    return nil
  end

  # :invalid => :error.   add_error   if value is not valide
  #             :warning  add_warning if value is not valide
  # :if_neg => :error/:warning
  def get_numeric_field(value, id, field, *args)
    opt = args.extract_options!
    if is_numeric?(value)
      if (value < 0)
        if (opt[:if_neg].eql?(:error)) # generate an error if value < 0
          invalid = "#{field} doit etre > 0"
          add_invalid(invalid, id)
          nil
        elsif opt[:if_neg].eql?(:warning) # generate a warning if value < 0
          warning = "#{field} n'est pas > 0"
          add_warning(warning, id)
          nil
        else
          #return value even if value<0
        end
      end
      value
    else
      if (opt[:invalid].eql?(:error)) # required => generate an error
        invalid = "#{field} doit etre un nombre valide"
        add_invalid(invalid, id)
      elsif opt[:invalid].eql?(:warning) # not required => generate a warning
        warning = "#{field} n'est pas un nombre valide"
        add_warning(warning, id)
      end
    return nil
    end
  end
  def get_boolean_field(value, id, field, *args)
    opt = args.extract_options!
    if is_boolean?(value)
      return booleanize(value)
    else
      if (opt[:invalid].eql?(:error))
        invalid = "#{field} doit etre 'oui/non'"
        add_invalid(invalid, id)
      elsif opt[:invalid].eql?(:warning)# not required
        warning = "#{field} n'est pas 'oui/non' valide"
        add_warning(warning, id)
      end
    return nil
    end
  end

# Read Putoproduits fields
  def get_putoproduit_produit_id(produit_code, id)
    if produit = Produit.find_by_code(produit_code)
      return produit.id
    else
      invalid = "le code produit n'existe pas"
      add_invalid(invalid, id)
      return nil
    end
  end

# Read File
  def self.load_sheet(name)
    book = Spreadsheet.open Rails.root.join('doc', 'xls_import', 'pulves.xls')
    raise 'book not found' if book.nil?
    sheet = book.worksheet name
    raise 'book not found' if sheet.nil?
    return sheet
  end

  def self.load_book(book_name)
    book = Spreadsheet.open Rails.root.join('doc', 'xls_import', book_name)
    raise 'book not found' if book.nil?
    return book
  end

# Helper methods
  def ignore_this_row(row)
    if ((row[XLS_ROW_NUM].eql?('#')) ||
    ((row[XLS_TYPE].nil?) &&
    (row[XLS_PULVE_COUT_HA_PASSAGE].nil?) && 
    (row[XLS_PULVE_NAME].nil?) && 
    (row[XLS_PULVE_DATE].nil?)))
      return true
    else
      return nil
    end
  end
  def self.print_elt_name(elt)
    return "?" if elt.nil?
    if elt.class.eql?(Putoproduit)
      return "?" if elt.produit.nil?      
      return elt.try(:produit).try(:code)
    end
    return elt.name if elt.class.eql?(Pulve)
  end  
  def self.print_elt_type(elt)
    return "?" if elt.nil?
    return "pulve" if elt.class.eql?(Pulve)
    return "&nbsp;&nbsp;produit" if elt.class.eql?(Putoproduit)
  end  
  def self.import_td_validity_class(error_array)
    return 'bg-red' if error_array.size>0
    return 'bg-green'
  end
  def self.read_td_validity_class(invalids_array, warnings_array)
    return 'bg-red'     if invalids_array.size>0
    return 'bg-orange'  if warnings_array.size>0
    return 'bg-green'
  end

# File preparation

  def self.prepare_pulve_sheet(sheet, users, type)
    index = 0
    sheet.each do |row|
      row[XLS_PULVES_USERS_COLUMN] = users[index]
      index += 1
    end
  end

  
end