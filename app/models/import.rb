require "jcode"

class Import < ActiveRecord::Base
  attr_accessor :all_valid, :row_num, 
    :import_size, #nombre d'elements importes avec succes
    :type,  # 'pulves', 'factures'
    :elts,    #:pulves, :factures
    :warnings, :invalids, :errors,
    :has_warnings, :has_invalids, :has_errors
    
  # ----- Constantes -----

  XLS_ROW_NUM                  = 0
  XLS_TYPE                     = 1

  XLS_PULVE_COUT_HA_PASSAGE    = 2
  XLS_PULVE_DATE               = 3
  XLS_PULVE_CATEGORY           = 4
  XLS_PULVE_NAME               = 5
  XLS_PULVE_USER               = 6

  XLS_PUTOPRODUIT_PRODUIT_CODE = 8
  XLS_PUTOPRODUIT_DOSAGE       = 9

  def initialize(elt_type)
    @sym = elt_type
    @last_pulve_id = nil
    @import_size   = 0
    @row_num       = 0
    @all_valid     = true
    @has_errors    = false
    @has_warnings  = false
    @has_invalids  = false
    @elts     = [] #elements 
    @invalids = [] #invalids 
    @warnings = [] #warnings 
    @errors   = [] #errors 
    @remarks   = [] #general errors, not affected to a specific row 
  end

  #lecture du fichier
  def read_elements(sheet)
    @row_num = 0
    sheet.each do |row|
      unless ignore_this_row(row)
        @elts[@row_num]     = []
        @invalids[@row_num] = []
        @warnings[@row_num] = []
        @errors[@row_num] = []
        element = read_element(row)
        @elts[@row_num] = element
        @row_num += 1
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
    cout_ha_passage = get_cout_ha_passage(row[XLS_PULVE_COUT_HA_PASSAGE], @row_num)
    category_id = get_category(row[XLS_PULVE_CATEGORY], @row_num)
    user_id     = get_user_id(row[XLS_PULVE_USER], @row_num)
    date        = get_date(row[XLS_PULVE_DATE], @row_num)
    name        = get_name(row[XLS_PULVE_NAME], @row_num)
    pulve.update_attributes(
      :name            => name,
      :user_id         => user_id, 
      :category_id     => category_id,
      :date            => date, 
      :cout_ha_passage => cout_ha_passage) 
    check_pulve_already_imported(pulve, @row_num)
    return(pulve)
  end
  def read_putoproduit(row)
    putoproduit = Putoproduit.new()
    produit_id = get_putoproduit_produit_id(row[XLS_PUTOPRODUIT_PRODUIT_CODE], @row_num)
    dosage = get_putoproduit_dosage(row[XLS_PUTOPRODUIT_DOSAGE], @row_num)
    putoproduit.update_attributes(
      :produit_id => produit_id, 
      :dosage     => dosage) 
    return(putoproduit)
  end
  
# Import des elements
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
    elt.saison_id = Setting.get_saison_id
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
  
# Elements
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
  
# Pulves
  def get_cout_ha_passage(cout_ha_passage, id)
    if (cout_ha_passage.class.eql?(Integer) || cout_ha_passage.class.eql?(Float))
      return cout_ha_passage
    else
      invalid = "cout_ha_passage n'est pas un nombre"
      add_invalid(invalid, id)
    end
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
  def check_pulve_already_imported(element, id)
    Pulve.find_by_saison(:all).each do |pulve|
      if (pulve.name.eql?(element.name))
        invalid = "semble etre deja importe"
        add_warning(invalid, id) unless warning_already_exist(invalid, id)
      end
    end
  end
  
# Putoproduits

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

  def self.load_sheet(name)
    book = Spreadsheet.open Rails.root.join('doc', 'xls_import', 'pulves.xls')
    raise 'book not found' if book.nil?
    sheet = book.worksheet name
    raise 'book not found' if sheet.nil?
    return sheet
  end

  def find_user_old(code)
    ret = retour.new()
    if user = User.find_by_code(code)
      ret.data = user
    else
      ret.invalids = 'user not found'
      ret.valid = false
    end
    return ret
  end

# Helper
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
    return elt.name   if elt.class.eql?(Pulve)
  end  


end