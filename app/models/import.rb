Spreadsheet.client_encoding = 'LATIN1//TRANSLIT//IGNORE'
# TODO: Class Pulve: ajouter une validation pour cout_ha_passage>0
# TODO: gerer les conversions texte->integer. faire des tests avec excel
# TODO: Verifier aue pulve.after_save est coherent meme si appele plusieur foir pour un meme pulve
# TODO: probleme d'enregistrement du texte copier/coller du web: erreur utf8
# TODO: pour tout les type qui doivent avoir un code unique, vertifier l'unicite avant import de tt les elts


class Import < ActiveRecord::Base

  # has_attached_file :file

  attr_accessor :row_id,        # nombre d'elements lu lors de l'analyse du fichier
                :import_size,   # nombre d'elements importes avec succes
                :read_size,     # nombre d'elements a importer (pulves, factures, mais pas putoproduits, putoparcelles, ...)
                :type,          # 'pulves', 'factures'
                :elts,          # tableau de Pulves, Factures...
                :assoc_produits,# tableau de produits d'un element
                :parcelles,     # tableau de parcelles d'un elt
                :cultures,      # tableau de cultures d'un elt
                :remarks,       # tableau d'info/erreurs sur le fichier, non specifique a une row
                :warnings,      # warnings array, filled when reading elements
                :invalids,      # invalids (like errors) array, filled when reading elements
                :errors,        # errors array, filled when importing elements
                :has_warnings,  :has_invalids,  :has_errors #presence of error/warnings/invalids

  # ----- Constantes -----
if true
  # Erreurs
  IMPORT_TYPE_INVALID = "le fichier comporte un type invalid"
  IMPORT_TYPE_UNDEFINED = "type non defini"

  # Elements
  XLS_ROW_NUM                  = 0
  XLS_TYPE                     = 1

  # Labours
  XLS_LABOUR_COUT_HA_PASSAGE    = 2
  XLS_LABOUR_DATE               = 3
  XLS_LABOUR_CATEGORY           = 4
  XLS_LABOUR_NAME               = 5
  XLS_LABOUR_USER               = 6
  XLS_LABOUR_TYPECULTURS        = 7
  XLS_LABOUR_PARCELLES          = 8
  XLS_LABOUR_DESC               = 9
  XLS_LABOUR_INFO               = 10
  XLS_LABOUR_STAR               = 11
  XLS_LABOUR_ADU                = 12

  # Pulves
  XLS_PULVE_COUT_HA_PASSAGE    = 2
  XLS_PULVE_DATE               = 3
  XLS_PULVE_CATEGORY           = 4
  XLS_PULVE_NAME               = 5
  XLS_PULVE_USER               = 6
  XLS_PULVE_TYPECULTURS        = 7
  XLS_PULVE_PARCELLES          = 8
  XLS_PULVE_DESC               = 9
  XLS_PULVE_INFO               = 10
  XLS_PULVE_STAR               = 11
  XLS_PULVE_ADU                = 12

  XLS_PUTOPRODUIT_PRODUIT_CODE = 13
  XLS_PUTOPRODUIT_DOSAGE       = 14
  XLS_PUTOPRODUIT_QUANTITE     = 15
  XLS_PUTOPRODUIT_DESTOCKER    = 16
  XLS_PUTOPRODUIT_DOSAGE_VRAI  = 17
  XLS_PUTOPRODUIT_DOSAGE_DESC  = 18

  XLS_PULVES_DATAS_COLUMN_USERS     = 1 #col pour ecrir la liste des users codes
  XLS_PULVES_DATAS_COLUMN_PARCELLES = 2 #col pour ecrir la liste des parcelles codes
  XLS_PULVES_DATAS_COLUMN_CULTURES  = 3 #col pour ecrir la liste des typecultures codes

  # Factures
  XLS_FACTURE_COUT        = 2
  XLS_FACTURE_DATE        = 3
  XLS_FACTURE_CATEGORY    = 4
  XLS_FACTURE_NAME        = 5
  XLS_FACTURE_USER        = 6
  XLS_FACTURE_REF_PERSO   = 7
  XLS_FACTURE_REF_CLIENT  = 8
  XLS_FACTURE_TYPECULTURS = 9
  XLS_FACTURE_PARCELLES   = 10
  XLS_FACTURE_DESC        = 11
  XLS_FACTURE_INFO        = 12
  XLS_FACTURE_STAR        = 13
  XLS_FACTURE_ADU         = 14
  
  XLS_PROTOFACTURE_PRODUIT_CODE = 15
  XLS_PROTOFACTURE_PRIX_UNIT    = 16
  XLS_PROTOFACTURE_QUANTITE     = 17


  # Ventes
  XLS_VENTE_PRIX          = 2
  XLS_VENTE_DATE          = 3
  XLS_VENTE_CATEGORY      = 4
  XLS_VENTE_NAME          = 5
  XLS_VENTE_USER          = 6
  XLS_VENTE_REF_PERSO     = 7
  XLS_VENTE_REF_CLIENT    = 8
  XLS_VENTE_TYPECULTURS   = 9
  XLS_VENTE_PARCELLES     = 10
  XLS_VENTE_DESC          = 11
  XLS_VENTE_INFO          = 12
  XLS_VENTE_STAR          = 13
  XLS_VENTE_ADU           = 14
  XLS_VENTE_QUANTITE      = 15
  XLS_VENTE_PRIX_UNITAIRE = 16
  XLS_VENTE_AJUST         = 17
  XLS_VENTE_CALCUL_AUTO   = 18
  XLS_VENTE_UNIT          = 19
  XLS_VENTE_POIDS_BOTTE   = 20
  
  # Produits
  XLS_PRODUIT_UNIT     = 2
  XLS_PRODUIT_CATEGORY = 3
  XLS_PRODUIT_NAME     = 4
  XLS_PRODUIT_CODE     = 5
  XLS_PRODUIT_DESC     = 6
  XLS_PRODUIT_INFO     = 7
  XLS_PRODUIT_STAR     = 8
  XLS_PRODUIT_ADU      = 9
end
  def initialize(elt_type)
    # if false
    # Protofacture.find(:all).each do |f|
    #   if 73 <= f.id && f.id <= 88
    #     puts "delete #{f.id}"
    #     f.destroy
    #   end
    # end
    # Facture.find(:all).each do |f|
    #   if f.id > 154
    #     puts "delete #{f.id}"
    #     f.destroy
    #   end
    # end
      # Pulve.find(:all).each do |pu|
      #   if pu.id > 77
      #     puts "delete #{pu.id}"
      #     pu.destroy
      #   end
      # end
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
    @assoc_produits = [] # Used only for pulves import
    @protofacs = [] # Used only for factures import
    @elts      = []  
    @parcelles = []
    @cultures  = []
    @invalids  = []  
    @warnings  = []  
    @errors    = []  
    @remarks   = [] #general errors, not affected to a specific row 
  end

  # verifie que la saison indiquee en case B2 du fichier excel est bien l'annee de la saison courante (saison.year)
  def wrong_saison(sheet)
    puts "saison lue dans fichier excel : #{sheet[1,1].to_i}"
    puts "saison courante : #{@saison.year.to_i}"
    
    return !(sheet[1,1].to_i.eql?(@saison.year.to_i))
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
    case @sym
    when :pulves
      if row[XLS_TYPE].eql?('pulve')
        @read_size += 1
        return read_pulve(row)
      elsif row[XLS_TYPE].eql?('produit')
        return read_putoproduit(row)
      else
        read_type_error = true
      end
    when :labours
      if row[XLS_TYPE].eql?('labour')
        @read_size += 1
        return read_labour(row)
      else
        read_type_error = true
      end
    when :factures
      if row[XLS_TYPE].eql?('facture')
        @read_size += 1
        return read_facture(row)
      elsif row[XLS_TYPE].eql?('produit')
        return read_protofacture(row)
      else
        read_type_error = true
      end
    when :ventes
      if row[XLS_TYPE].eql?('vente')
        @read_size += 1
        return read_vente(row)
      else
        read_type_error = true
      end
    when :produits
      if row[XLS_TYPE].eql?('produit')
        @read_size += 1
        return read_produit(row)
      else
        read_type_error = true
      end
    # ajout d'une remark car type non defini
    else
      add_remark("#{IMPORT_TYPE_UNDEFINED} - #{row}")
    end
    # ajout d'une remark si un type n'a pas ete reconnu pendant la lecture
    add_remark("#{IMPORT_TYPE_INVALID} - #{row}") if read_type_error    
  end
  
  def read_pulve(row)
    pulve = Pulve.new()
    cout_ha_passage = get_numeric_field(row[XLS_PULVE_COUT_HA_PASSAGE], @row_id, 'cout ha passage', {:invalid => :error, :if_neg => :error})
    category_id     = get_category(row[XLS_PULVE_CATEGORY], @row_id, :pulve)
    user_id         = get_user_id(row[XLS_PULVE_USER], @row_id)
    date            = get_date(row[XLS_PULVE_DATE], @row_id)
    name            = get_name(row[XLS_PULVE_NAME], @row_id)
    parcelles       = get_parcelles(row[XLS_PULVE_PARCELLES], @row_id)
    cultures        = get_cultures(row[XLS_PULVE_TYPECULTURS], @row_id)
    desc            = get_text(row[XLS_PULVE_DESC], @row_id, 'description')
    info            = get_text(row[XLS_PULVE_INFO], @row_id, 'info')
    star            = get_boolean_field(row[XLS_PULVE_STAR],  @row_id, 'star',  {:invalid => :warning})
    adu             = get_boolean_field(row[XLS_PULVE_ADU],   @row_id, 'adu',   {:invalid => :warning})
    pulve.update_attributes(
      :cout_ha_passage => cout_ha_passage,
      :name            => name,
      :user_id         => user_id, 
      :category_id     => category_id,
      :date            => date, 
      :desc            => desc, 
      :info            => info, 
      :star            => star, 
      :adu             => adu
    ) 
    @last_pulve_read = @row_id
    @assoc_produits[@last_pulve_read] = []
    # check_parcelles_and_cultures_size(@row_id)
    check_if_pulve_exist(pulve, @row_id)
    return(pulve)
  end
  def read_putoproduit(row)
    elt             = Putoproduit.new()
    elt.produit_id  = get_putoproduit_produit_id(row[XLS_PUTOPRODUIT_PRODUIT_CODE], @row_id)
    elt.dosage      = get_numeric_field(row[XLS_PUTOPRODUIT_DOSAGE],      @row_id, 'dosage',      {:if_neg => :error})
    elt.dosage_vrai = get_numeric_field(row[XLS_PUTOPRODUIT_DOSAGE_VRAI], @row_id, 'dosage vrai', {:if_neg => :error})
    elt.quantite    = get_numeric_field(row[XLS_PUTOPRODUIT_QUANTITE],    @row_id, 'quantite',    {:if_neg => :error})
    elt.destocker   = get_boolean_field(row[XLS_PUTOPRODUIT_DESTOCKER],   @row_id, 'destocker',   {:invalid => :warning})
    # puts "\t#{elt.to_yaml}"
    @assoc_produits[@last_pulve_read] << elt

    check_putoproduit(elt, @row_id)
    return(elt)
  end
  
  def read_labour(row)
    labour = Labour.new()
    labour.cout_ha_passage = get_numeric_field(row[XLS_LABOUR_COUT_HA_PASSAGE], @row_id, 'cout ha passage', {:invalid => :error, :if_neg => :error})
    labour.category_id     = get_category(row[XLS_LABOUR_CATEGORY], @row_id, :labour)
    labour.user_id         = get_user_id(row[XLS_LABOUR_USER], @row_id)
    labour.date            = get_date(row[XLS_LABOUR_DATE], @row_id)
    labour.name            = get_name(row[XLS_LABOUR_NAME], @row_id)
    labour.desc            = get_text(row[XLS_LABOUR_DESC], @row_id, 'description')
    labour.info            = get_text(row[XLS_LABOUR_INFO], @row_id, 'info')
    labour.star            = get_boolean_field(row[XLS_LABOUR_STAR],  @row_id, 'star',  {:invalid => :warning})
    labour.adu             = get_boolean_field(row[XLS_LABOUR_ADU],   @row_id, 'adu',   {:invalid => :warning})
    parcelles              = get_parcelles(row[XLS_LABOUR_PARCELLES], @row_id)
    cultures               = get_cultures(row[XLS_LABOUR_TYPECULTURS], @row_id)
    #TODO supprimer la ligne suivante inutile
    @last_labour_read = @row_id
    check_if_labour_exist(labour, @row_id)
    return(labour)
  end

  def read_vente(row)
    vente = Vente.new()
    vente.prix          = get_numeric_field(row[XLS_VENTE_PRIX], @row_id, 'prix', {:invalid => :error, :if_neg => :error})
    vente.date          = get_date(row[XLS_VENTE_DATE], @row_id)
    vente.quantite      = get_numeric_field(row[XLS_VENTE_QUANTITE], @row_id, 'quantite', {:invalid => :error, :if_neg => :error})
    vente.ajust         = get_numeric_field(row[XLS_VENTE_AJUST], @row_id, 'ajust')
    vente.prix_unitaire = get_numeric_field(row[XLS_VENTE_PRIX_UNITAIRE], @row_id, 'prix_unitaire')
    vente.calcul_auto   = get_boolean_field(row[XLS_VENTE_CALCUL_AUTO], @row_id, 'calcul_auto')
    vente.poids_botte   = get_numeric_field(row[XLS_VENTE_POIDS_BOTTE], @row_id, 'poids_botte')
    vente.unit          = get_text(row[XLS_VENTE_UNIT], @row_id, 'unit')
    vente.category_id   = get_category(row[XLS_VENTE_CATEGORY], @row_id, :vente)
    vente.user_id       = get_user_id(row[XLS_VENTE_USER], @row_id)
    vente.name          = get_name(row[XLS_VENTE_NAME], @row_id)
    vente.desc          = get_text(row[XLS_VENTE_DESC], @row_id, 'description')
    vente.info          = get_text(row[XLS_VENTE_INFO], @row_id, 'info')
    vente.star          = get_boolean_field(row[XLS_VENTE_STAR],  @row_id, 'star',  {:invalid => :warning})
    vente.adu           = get_boolean_field(row[XLS_VENTE_ADU],   @row_id, 'adu',   {:invalid => :warning})
    vente.ref           = get_text(row[XLS_VENTE_REF_PERSO],   @row_id, 'ref')
    vente.ref_client    = get_text(row[XLS_VENTE_REF_CLIENT],   @row_id, 'ref_client')
    parcelles           = get_parcelles(row[XLS_VENTE_PARCELLES], @row_id)
    cultures            = get_cultures(row[XLS_VENTE_TYPECULTURS], @row_id)
    #TODO supprimer la ligne suivante inutile
    @last_vente_read = @row_id
    check_if_vente_exist(vente, @row_id)
    return(vente)
  end

  def read_facture(row)
    fac             = Debit.new()
    fac.cout        = get_numeric_field(row[XLS_FACTURE_COUT], @row_id, 'cout', {:if_neg => :error, :invalid => :error})
    fac.category_id = get_category(row[XLS_FACTURE_CATEGORY], @row_id, :facture)
    fac.user_id     = get_user_id(row[XLS_FACTURE_USER], @row_id)
    fac.date        = get_date(row[XLS_FACTURE_DATE], @row_id)
    fac.name        = get_text(row[XLS_FACTURE_NAME], @row_id, "nom", {:if_null => :error})
    fac.ref         = get_text(row[XLS_FACTURE_REF_PERSO], @row_id, "ref", {:if_null => :warning})
    fac.ref_client  = get_text(row[XLS_FACTURE_REF_CLIENT], @row_id, "ref_client", {:if_null => :warning})
    fac.desc        = get_text(row[XLS_FACTURE_DESC], @row_id, 'description')
    fac.info        = get_text(row[XLS_FACTURE_INFO], @row_id, 'info')
    fac.star        = get_boolean_field(row[XLS_FACTURE_STAR],   @row_id, 'star',   {:invalid => :warning})
    fac.adu         = get_boolean_field(row[XLS_FACTURE_ADU],   @row_id, 'adu',   {:invalid => :warning})
    fac.factype_id  = Factype::DIFF
    get_parcelles(row[XLS_FACTURE_PARCELLES], @row_id)
    get_cultures(row[XLS_FACTURE_TYPECULTURS], @row_id)
    # fac.saison_id   = 0 # Modifier la structure de la table pour autoriser l'in

    @last_fac_read = @row_id
    @assoc_produits[@last_fac_read] = []
    # check_parcelles_and_cultures_size(@row_id)
    check_if_facture_exist(fac, @row_id)
    return(fac)
  end
  def read_protofacture(row)
    elt            = Protofacture.new()
    elt.produit_id = get_putoproduit_produit_id(row[XLS_PROTOFACTURE_PRODUIT_CODE], @row_id)
    elt.prix_unit  = get_numeric_field(row[XLS_PROTOFACTURE_PRIX_UNIT], @row_id, 'prix unitaire', {:if_neg => :error})
    elt.quantite   = get_numeric_field(row[XLS_PROTOFACTURE_QUANTITE],    @row_id, 'quantite',    {:if_neg => :error})
    # puts "\t#{elt.to_yaml}"
    @assoc_produits[@last_fac_read] << elt

    check_protofacture(elt, @row_id)
    return(elt)
  end
  
  def read_produit(row)
    produit             = Produit.new()
    produit.category_id = get_category(row[XLS_PRODUIT_CATEGORY], @row_id, :produit)
    produit.unit        = get_text(row[XLS_PRODUIT_UNIT],         @row_id, 'unite',           {:if_null => :error})
    produit.name        = get_text(row[XLS_PRODUIT_NAME],         @row_id, 'nom',             {:if_null => :error})
    produit.code        = get_text(row[XLS_PRODUIT_CODE],         @row_id, 'code',            {:if_null => :error})
    produit.desc        = get_text(row[XLS_PRODUIT_DESC],         @row_id, 'description')
    produit.info        = get_text(row[XLS_PRODUIT_INFO],         @row_id, 'info')
    produit.star        = get_boolean_field(row[XLS_PRODUIT_STAR],@row_id, 'star', {:invalid => :warning})
    produit.adu         = get_boolean_field(row[XLS_PRODUIT_ADU], @row_id, 'adu',   {:invalid => :warning})
    check_if_produit_exist(produit, @row_id)
    return(produit)
  end

# Import Elements
  def import_elements
    puts "importing"
    @elts.each_with_index do |elt, index|
      import_element(elt, index)
    end
  end  

  # dispatch to import_charge() with correct model name
  def import_element(elt, index)
    if elt.class.eql?(Pulve)
      import_charge(elt, index)
    elsif elt.kind_of?(Facture)
      import_charge(elt, index)
    elsif elt.kind_of?(Vente)
      import_charge(elt, index)
    elsif elt.kind_of?(Produit)
      import_charge(elt, index)
    elsif elt.kind_of?(Labour)
      import_charge(elt, index)
    elsif (elt.kind_of?(Putoproduit) || elt.kind_of?(Protofacture))
      # do nothing
    else
      add_remark("le fichier comporte un type invalid #2")
    end
  end
  
  # import pulve, facture or produit and call import_model_assoc() if needed
  def import_charge(elt, index)
    import_ok = true
    import_failed = true
    merge_parcelles_and_cultures(elt, index)
    elt.saison_id = @saison.id
    elt.set_prix if (elt.type.eql?(Vente) && elt.calcul_auto.eql?(1)) # specifique Vente : pour calcul auto
    if elt.save
      #import associated parcelles
      @parcelles[index].each do |assoc_parcelle|
        res = import_parcelle_assoc(elt, assoc_parcelle, index)
        import_ok = false if res==false
      end
      #import associated products
      unless @assoc_produits[index].nil?
        @assoc_produits[index].each do |produit_assoc|
          res = import_produit_assoc(elt, produit_assoc, index)
          import_ok = false if res==false
        end
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
    
  # import a produit associated to a parcelle
  def import_parcelle_assoc(elt, parcelle, index)
    import_sucess = false
    if elt.kind_of?(Pulve)
      parcelle_assoc = Putoparcelle.new(
        :pulve_id    => elt.id,
        :parcelle_id => parcelle.id,
        :value       => 1)
    elsif elt.kind_of?(Labour)
      parcelle_assoc = Labtoparcelle.new(
        :labour_id    => elt.id,
        :parcelle_id => parcelle.id,
        :value       => 1)
    elsif elt.kind_of?(Vente)
      parcelle_assoc = Ventoparcelle.new(
        :vente_id    => elt.id,
        :parcelle_id => parcelle.id,
        :value       => 1)
    elsif elt.kind_of?(Facture)
      parcelle_assoc = Factoparcelle.new(
        :facture_id    => elt.id,
        :parcelle_id => parcelle.id,
        :value       => 1)
    end
    if parcelle_assoc && parcelle_assoc.valid?
      if parcelle_assoc.save
        import_sucess = true
      else
        self.add_error("parcelle '#{parcelle.try(:name)}' non enregistree", index)
        self.add_error(parcelle_assoc.errors, index)
      end
    else # parcelle_assoc not valid
      self.add_error("parcelle '#{parcelle.try(:name)}' non valide", index)
      self.add_error(parcelle_assoc.errors, index) if parcelle_assoc
      return false
    end
    return import_sucess
  end

  # import a produit associated to a facture
  def import_produit_assoc(elt, produit_assoc, index)
    import_ok = true
    produit_assoc.facture_id = elt.id if elt.kind_of?(Facture)
    produit_assoc.pulve_id = elt.id if elt.kind_of?(Pulve)
    if produit_assoc.save
      # update stock produit according to putoproduit quantity 
      # amount of stock increase when produit is baught
      produit_assoc.produit.update_protofacture_stock
      import_ok = true
    else
      import_ok = false
      produit = produit_assoc.try(:produit).try(:name) || ''
      self.add_error("produit '#{produit}' non valide", index)
      self.add_error(produit_assoc.errors, index)
    end
    return import_ok
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
    # inspect_errors(id)     
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
      invalid = 'utilisateur non valide'
      add_invalid(invalid, id)
    end
  end
  def get_name(name, id)
    if (!name.nil? && name.class.eql?(String))
      return name
    else
      puts "DEBUG NAME #{name}"
      invalid = 'nom non valid'
      add_invalid(invalid, id)
    end
  end

  def get_date(date_raw, id)
  # puts "DEBUG 3 #{date_raw.class}"
    if date_raw.class.eql?(String)
      return date_raw
    elsif date_raw.class.eql?(DateTime)
      date = "#{date_raw.year}-#{date_raw.month}-#{date_raw.day}"
    else
      invalid = "la date n'est au bon format"
      add_invalid(invalid, id)
    end
  end  

  def get_date_old(date, id)
    if date.class.eql?(String)
      return date
    else
      invalid = "la date n'est au bon format"
      add_invalid(invalid, id)
    end
  end  

  def get_parcelles(parcelles_raw, id)
    # puts "parcelles_raw #{parcelles_raw}"
    if parcelles_raw.class.eql?(String)
      parcelles = parcelles_raw.split(/,\s*/)
      unless parcelles.size.eql?(0)
        parcelles.each do |parcelle_code|
          puts "\tparcelle_code #{parcelle_code}"
          parcelle = @saison.parcelles.find_by_code(parcelle_code)
          unless parcelle.nil?
            puts "\t\tparcelle found"
            add_parcelle(parcelle, id)
          else
            puts "\t\tparcelle NOT found"
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
          culture = Typeculture.find_by_code(culture_code)
          unless culture.nil?
            add_culture(culture, id)
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
  # root = :pulve, :facture, ...
  def get_category(category_code, id, root_cat)
    root = Category.root_pulve    if root_cat.eql?(:pulve)
    root = Category.root_labour   if root_cat.eql?(:labour)
    root = Category.root_facture  if root_cat.eql?(:facture)
    root = Category.root_produit  if root_cat.eql?(:produit)
    root = Category.root_vente  if root_cat.eql?(:vente)
    category = Category.find_by_code(category_code)
    if (root && category && category.root.eql?(root))
      return category.id
    else
      invalid = "categorie non valide #{category_code}"
      add_invalid(invalid, id)
    end
  end
  
  # call this just before importing a element
  # this updates @parcelles[elt_id] by merging @cultures[elt_id] et @parcelles[elt_id]   
  def merge_parcelles_and_cultures(pulve, id)
    # puts "\tmerge_parcelles_and_cultures"
    @cultures[id].each do |culture|
      # puts "\t#{culture.code}"      
      @parcelles[id] << Parcelle.get_parcelles_from_culture(culture)
    end
    @parcelles[id] = @parcelles[id].flatten.uniq
    # @parcelles[id].each {|p| puts "\t\t#{p.code}"}      
  end

# Check elements
  def check_if_pulve_exist(element, id)
    Pulve.find_by_saison(:all).each do |pulve|
      if (pulve.name.eql?(element.name))
        invalid = "semble etre deja importe"
        add_warning(invalid, id) unless warning_already_exist(invalid, id)
      end
    end
  end  
  def check_if_labour_exist(element, id)
    Labour.find_by_saison(:all).each do |labour|
      if (labour.name.eql?(element.name))
        invalid = "semble etre deja importe"
        add_warning(invalid, id) unless warning_already_exist(invalid, id)
      end
    end
  end  
  def check_if_facture_exist(element, id)
    Facture.find_by_saison(:all).each do |elt|
      if (elt.name.eql?(element.name))
        invalid = "semble etre deja importe"
        add_warning(invalid, id) unless warning_already_exist(invalid, id)
      end
    end
  end  
  def check_if_vente_exist(element, id)
    Vente.find_by_saison(:all).each do |elt|
      if (elt.name.eql?(element.name))
        invalid = "semble etre deja importe"
        add_warning(invalid, id) unless warning_already_exist(invalid, id)
      end
    end
  end  
  def check_if_produit_exist(element, id)
    Produit.find_by_saison(:all).each do |elt|
      if (elt.code.eql?(element.code))
        msg = "ce code existe deja"
        add_invalid(msg, id) unless invalid_already_exist(msg, id)
        return
      end
      if (elt.name.eql?(element.name))
        msg = "ce nom est deja utilise"
        add_warning(msg, id) unless warning_already_exist(msg, id)
      end
    end
  end  

  # obsolete : on autorise le fait d'indiquer aucune parcelle
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
  def check_protofacture(protofac, id)
    if protofac.quantite.nil? || protofac.quantite.blank?
      invalid = "indiquer prix unitaire et quantite"
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

  # :if_null => :error.   add_error   if value is null
  #          :warning  add_warning if value is null
  def get_text(value, id, field, *args)
    opt = args.extract_options!
    value = value.to_s
    if value.eql?("")
      msg = "#{field} doit ne doit pas etre nul"
      if (opt[:if_null].eql?(:error)) # generate an error if value == ''
        add_invalid(msg, id)
        nil
      elsif (opt[:if_null].eql?(:warning)) # generate an invalid if value == ''
        add_warning(msg, id)
        nil
      end
    end
    value
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
    # 2012/06/29 modif find produit pour selectionne par saison et par code
    # avant la saison n'etait pas prise en compte
  def get_putoproduit_produit_id(produit_code, id)
    # if produit = Produit.find_by_code(produit_code)
    if produit = Produit.find_by_saison(:first, :conditions => ["code = ?", produit_code])
      return produit.id
    else
      invalid = "le code produit n'existe pas"
      add_invalid(invalid, id)
      return nil
    end
  end

# Read File
  # def self.load_sheet_from_db_without_rescue(file, sheet_name)
  #   book = Spreadsheet.open file
  #   puts "CATCH ERROR"
  #   raise 'book not found' if book.nil?
  #   sheet = book.worksheet sheet_name
  #   raise 'book not found' if sheet.nil?
  #   return sheet
  # end
  
  def self.load_sheet_from_db(file, sheet_name)
    book = Spreadsheet.open file
    sheet = book.worksheet sheet_name
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
    if (elt.kind_of?(Putoproduit) || elt.kind_of?(Protofacture))
      return "?" if elt.produit.nil?      
      return elt.try(:produit).try(:code)
    end
    return elt.name if elt.name
  end  
  def self.print_elt_type(elt)
    return "?" if elt.nil?
    return "&nbsp;&nbsp;&nbsp;produit" if (elt.kind_of?(Putoproduit) || elt.kind_of?(Protofacture))
    return elt.class.to_s.downcase
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
  end

  
end