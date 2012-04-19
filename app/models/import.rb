Spreadsheet.client_encoding = 'LATIN1//TRANSLIT//IGNORE'







# Class Pulve: ajouter une validation pour cout_ha_passage>0
# gerer les conversions texte->integer. faire des tests avec excel
# 
# A FAIRE
# 
# Import: realiser l'appel a parcelles.uniq avant pulve.save'
# Import: realiser d'ajout des parcelle d'un pulve






class Import < ActiveRecord::Base
  attr_accessor :row_id,      # nombre d'elements lu lors de l'analyse du fichier
                :import_size, # nombre d'elements importes avec succes
                :type,        # 'pulves', 'factures'
                :elts,        # tableau de Pulves, Factures...
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

  def initialize(elt_type)
    @sym = elt_type
    @saison = Setting.get_saison
    @last_pulve_id = nil
    @import_size   = 0
    @row_id        = 0
    @has_errors    = false
    @has_warnings  = false
    @has_invalids  = false
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
    puts "\t#{@row_id}"
    @parcelles[@row_id].each {|x| puts "\t\t#{x.name.to_s}" }
    pulve.update_attributes(
      :name            => name,
      :user_id         => user_id, 
      :category_id     => category_id,
      :date            => date, 
      :cout_ha_passage => cout_ha_passage) 
      
    check_pulve_already_imported(pulve, @row_id)
      
    check_parcelles_size(@row_id)
    return(pulve)
  end
  def read_putoproduit(row)
    putoproduit = Putoproduit.new()
    produit_id = get_putoproduit_produit_id(row[XLS_PUTOPRODUIT_PRODUIT_CODE], @row_id)
    dosage = get_putoproduit_dosage(row[XLS_PUTOPRODUIT_DOSAGE], @row_id)
    putoproduit.update_attributes(
      :produit_id => produit_id, 
      :dosage     => dosage) 
    return(putoproduit)
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
      import_putoproduit(elt, index)
    else
      add_remark("le fichier comporte un type invalid #2")
    end
  end
  def import_pulve(elt, index)
    elt.saison_id = @saison.id
    
    # elt.saison_id = Setting.get_saison_id #if (index != 3)
    # transforme les checkbox Typeculture en Factoparcelles
    elt.uniq_parcelles
    if elt.save
      @import_size += 1
      @last_pulve_id = elt.id
    else
      self.add_error(elt.errors, index)
    end
  end
    
  def import_putoproduit(elt, index)
    elt.saison_id = Setting.get_saison_id
    elt.pulve_id = @last_pulve_id
    if elt.save
      @import_size += 1
    else
      self.add_error(elt.errors, index)
    end
  end
    
  def add_error(error, id)   
    @errors[id] << "#{error}" if error.class.eql?(String) 
    if !error.class.eql?(String) 
      error.each do |err, err_id|
        @errors[id] << "#{err.to_s}: #{err_id.to_s}"
      end
    end
    @has_errors = true
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
            culture.parcelles.each do |parcelle|
              add_culture(culture, id)
            end
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

# Check elements
  def check_pulve_already_imported(element, id)
    Pulve.find_by_saison(:all).each do |pulve|
      if (pulve.name.eql?(element.name))
        invalid = "semble etre deja importe"
        add_warning(invalid, id) unless warning_already_exist(invalid, id)
      end
    end
  end  
  def check_parcelles_size(id)
    if @parcelles[id].size.eql?(0)
      warning = "aucune parcelle identifiee"
      add_warning(warning, id)
    end
  end
  
# Read Putoproduits fields
  def get_putoproduit_dosage(dosage, id)
    if (dosage.class.eql?(Integer) || dosage.class.eql?(Float))
      return dosage
    else
      invalid = "le dosage n'est pas un nombre valide"
      add_invalid(invalid, id)
      return nil
    end
  end
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
  
end