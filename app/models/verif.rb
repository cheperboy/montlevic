class Verif < ActiveRecord::Base
  
  attr_accessor :serie,
                :factures, :factypes, :structure, :data, :others, :saisie

  LOW = 0
  HIGH = 1

  Serie = Struct.new(:name, :tests)
  Test = Struct.new(:name, :result, :num, :level, :errors)
  Error = Struct.new(:name, :id, :controller, :url, :datas)

  def init_test(name, level) 
    test = Test.new(name, 0, 0, level, [])
    return test
  end
  
  def init_error(name, id, controller, datas)
    error = Error.new(name, id, controller, nil, datas)
    return error
  end
  
  def initialize
  end

  def run_test
    init_series
    get_result
    end_test
  end
  
  def init_series
    self.serie = []
    self.factures = Serie.new('Tests factures', [])
    self.factypes = Serie.new('Tests factypes', [])
    self.structure = Serie.new('Tests structure', [])
    self.data = Serie.new('Tests data', [])
    self.others = Serie.new('Autres tests', [])
    self.saisie = Serie.new('Saisie', [])
  end

  def end_test
    self.serie << factures
    self.serie << factypes
    self.serie << structure
    self.serie << data
    self.serie << others
    self.serie << saisie
  end

  def get_result
    factures.tests << parcelle_assoc_saison_incoh
    factures.tests << cout_lt_produits_used
    factures.tests << cout_lt_produits_assoc
    factures.tests << report_sans_reportable
    factures.tests << reportable_sans_report
    factures.tests << facdiv_sans_diverse
    factures.tests << diverse_sans_facdiv
    factures.tests << reportable_not_null_or_report_null
    factures.tests << cout_gt_produits_assoc

    factypes.tests << report_factype_null
    factypes.tests << reportable_factype_notnull
    factypes.tests << debit_factype_null_perdu

    structure.tests << ventoparcelle_deleted_ids
    structure.tests << factoparcelle_deleted_ids
    structure.tests << labtoparcelle_deleted_ids
    structure.tests << putoparcelle_deleted_ids
    structure.tests << labtofacture_deleted_ids
    structure.tests << putofacture_deleted_ids

    data.tests << data_contrib_lab
    data.tests << data_contrib_pu

    # saisie.tests << pulve_sans_facture
    saisie.tests << pulve_avec_facture_et_valeur_incoh
    saisie.tests << pulve_cout_produit_null
    # saisie.tests << pulve_sans_facture_service_avec_cout_presta_non_nul
    saisie.tests << produit_sans_facture_avec_pulve
    
  end


  def parcelle_assoc_saison_incoh
    test = init_test('parcelles assoc.saison_id differrente de facture.saison_id', HIGH)
    test.num =0
    Facture.find_by_saison(:all, :order => :id).each do |facture|       
      if facture.parcelle_assoc_saison_incoh.eql?(true)
        test.num += 1
        print = "#{facture.id}: #{facture.name}"
        error = init_error(print, facture.id, 'factures', '')
        test.errors << error
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def cout_lt_produits_assoc
    test = init_test('cout facture inferieur a la somme des produits assoc', HIGH)
    test.num =0
    Facture.find_by_saison(:all, :order => :id).each do |facture|       
      if facture.cout_lt_produits_assoc.eql?(true)
        test.num += 1
        print = "#{facture.name}: #{facture.cout} < #{facture.sum_charges}"
        error = init_error(print, facture.id, 'factures', '')
        test.errors << error
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def cout_gt_produits_assoc
    test = init_test('facture produits dont le cout est superieur a la somme des couts des produits assoc', LOW)
    test.num = 0
    factures = Facture.find_by_saison(:all, :conditions => ["category_id = ?", Category.find_by_code('produits_phyto').id]) 
    factures.each do |facture|
      unless (facture.sum_produits_assoc.almost_eql?(facture.cout, 1))
        test.num += 1
        text = facture.to_s(:default)
        print = "#{facture.name}: #{facture.cout} > #{facture.sum_produits_assoc}"
        error = init_error(print, facture.id, 'factures', '')
        test.errors << error
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def reportable_not_null_or_report_null
    test = init_test('Reportable non null ou report null', HIGH)
    test.num =0
    Facture.find_by_saison(:all, :order => :id).each do |facture|       
      if facture.reportable_not_null_or_report_null.eql?(true)
        test.num += 1
        print = "#{facture.class.to_s} #{facture.name}"
        error = init_error(print, facture.id, 'factures', '')
        test.errors << error
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def cout_lt_produits_used
    test = init_test('cout facture inferieur a somme des produits en terre', HIGH)
    test.num =0
    # Facture.find(:all).each do |facture|
    Facture.find_by_saison(:all, :order => :id).each do |facture|       
      if facture.cout_lt_produits_used.eql?(true)
        test.num += 1
        print = "#{facture.name}: #{facture.cout} < #{facture.sum_produits_used}"
        error = init_error(print, facture.id, 'factures', '')
        test.errors << error
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def reportable_sans_report
    test = init_test('Reportable sans aucun report', LOW)
    test.num =0
    Reportable.find(:all).each do |reportable|    
      if reportable.reports.empty?
        test.num += 1
        error = init_error(reportable.name, reportable.id, 'factures', '')
        test.errors << error
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def report_sans_reportable
    test = init_test('Report associe a un reportable inexistant', HIGH)
    Report.find(:all).each do |report|    
      if report.reportable.nil?
        test.num += 1
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def reportable_factype_notnull
    test = init_test('Reportable ayant un mauvais type de comptabilisation (non null)', HIGH)
    Reportable.find(:all).each do |reportable|    
      unless reportable.factype_id.equal?(Factype.find_by_name('null').id)
        test.num += 1
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  #facture (debit) ayant une comptabilisation NULL mais associee a aucun labour ou pulve
  #donc jamais comptabilisee dans les charges
  def debit_factype_null_perdu
    test = init_test('Debit (Facture) avec factype NULL mais sans labour ni pulve associes', LOW)
    Debit.find(:all).each do |facture|    
      if facture.factype_id.equal?(Factype.find_by_name('null').id) && facture.pulves.empty? && facture.labours.empty?
        test.num += 1
        error = init_error(facture.name, facture.id, 'factures', '')
        test.errors << error
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def report_factype_null
    test = init_test('Report ayant un mauvais type de comptabilisation (null)', LOW)
    Report.find(:all).each do |report|    
      if report.factype.id.equal?(Factype.find_by_name('null').id)
        test.num += 1
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def diverse_sans_facdiv
    test = init_test('Diverse (Facture) sans facdivs', LOW)
    Diverse.find(:all).each do |diverse|    
      if diverse.facdivs.empty?
        test.num += 1
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def facdiv_sans_diverse
    test = init_test('Facdiv associee a une facture (diverse) inexistante', HIGH)
    Facdiv.find(:all).each do |facdiv|    
      if facdiv.facture.nil?
        test.num += 1
        error = init_error(facdiv.name, facdiv.id, nil, '')
        test.errors << error
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def ventoparcelle_deleted_ids
    test = init_test('Ventoparcelle avec vente_id ou parcelle_id faux', HIGH)
    Ventoparcelle.find(:all).each do |obj| 
      if obj.vente.nil? || obj.parcelle.nil?
        test.num += 1
        vente = ''
        vente = 'vente ' + obj.vente_id.to_s + " n'existe pas" if obj.vente.nil? 
        parcelle = ''
        parcelle = 'parcelle ' + obj.parcelle_id.to_s + " n'existe pas" if obj.parcelle.nil? 
        text = 'Ventoparcelle ' + vente + ' | ' + parcelle
        error = init_error(text, obj.id, nil, '')
        test.errors << error
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def factoparcelle_deleted_ids
    test = init_test('Factoparcelle avec facture_id ou parcelle_id faux', HIGH)
    Factoparcelle.find(:all).each do |obj| 
      if obj.facture.nil? || obj.parcelle.nil?
        test.num += 1
        facture = ''
        facture = 'facture ' + obj.facture_id.to_s + " n'existe pas" if obj.facture.nil? 
        parcelle = ''
        parcelle = 'parcelle ' + obj.parcelle_id.to_s + " n'existe pas" if obj.parcelle.nil? 
        text = 'Factoparcelle ' + facture + ' | ' + parcelle
        error = init_error(text, obj.id, nil, '')
        test.errors << error
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def labtofacture_deleted_ids
    test = init_test('Labtofacture avec facture_id ou labour_id faux', HIGH)
    Labtofacture.find(:all).each do |obj| 
      if obj.facture.nil? || obj.labour.nil?
        test.num += 1
        facture = ''
        facture = 'facture ' + obj.facture_id.to_s + " n'existe pas" if obj.facture.nil? 
        labour = ''
        labour = 'labour ' + obj.labour_id.to_s + " n'existe pas" if obj.labour.nil? 
        text = 'Labtofacture ' + facture + ' | ' + facture
        error = init_error(text, obj.id, nil, '')
        test.errors << error
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def labtoparcelle_deleted_ids
    test = init_test('labtoparcelle avec parcelle_id ou labour_id faux', HIGH)
    Labtoparcelle.find(:all).each do |obj| 
      if obj.parcelle.nil? || obj.labour.nil?
        test.num += 1
        parcelle = ''
        parcelle = 'parcelle ' + obj.parcelle_id.to_s + " n'existe pas" if obj.parcelle.nil? 
        labour = ''
        labour = 'labour ' + obj.labour_id.to_s + " n'existe pas" if obj.labour.nil? 
        text = 'Labtoparcelle ' + parcelle + ' | ' + parcelle
        error = init_error(text, obj.id, nil, '')
        test.errors << error
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def putoparcelle_deleted_ids
    test = init_test('putoparcelle avec parcelle_id ou pulve_id faux', HIGH)
    Putoparcelle.find(:all).each do |obj| 
      if obj.parcelle.nil? || obj.pulve.nil?
        test.num += 1
        parcelle = ''
        parcelle = 'parcelle ' + obj.parcelle_id.to_s + " n'existe pas" if obj.parcelle.nil? 
        pulve = ''
        pulve = 'pulve ' + obj.pulve_id.to_s + " n'existe pas" if obj.pulve.nil? 
        text = 'Labtoparcelle ' + parcelle + ' | ' + parcelle
        error = init_error(text, obj.id, nil, '')
        test.errors << error
      end
    end
    test.result = (test.num == 0)    
    return test
  end
  
  def putofacture_deleted_ids
    test = init_test('Putofacture avec facture_id ou pulve_id faux', HIGH)
    Putofacture.find(:all).each do |obj| 
      if obj.facture.nil? || obj.pulve.nil?
        test.num += 1
        facture = ''
        facture = 'facture ' + obj.facture_id.to_s + " n'existe pas" if obj.facture.nil? 
        pulve = ''
        pulve = 'pulve ' + obj.pulve_id.to_s + " n'existe pas" if obj.pulve.nil? 
        text = 'Labtofacture ' + facture + ' | ' + facture
        error = init_error(text, obj.id, nil, '')
        test.errors << error
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def data_contrib_lab
    test = init_test('labour.labtofacture.value superieure a labour.get_cout_total ou a facture.cout', HIGH)
    Labtofacture.find(:all).each do |obj| 
      if obj.labour #test por eviter le bug si labour_id invalide
        if obj.facture #test por eviter le bug si facture_id invalide
          if obj.value > obj.labour.get_cout_total || obj.value > obj.facture.cout
            test.num += 1
            text = 'labour ' + obj.labour.name.to_s + ' (' + obj.labour.get_cout_total.to_s + ' euros) ' 
            text += 'contribution a la facture ' + obj.facture.name.to_s + ' (' + obj.value.to_s + ' euros)' 
            error = init_error(text, obj.labour.id, 'labours', '')
            test.errors << error
          end
        end
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def data_contrib_pu
    test = init_test('pulve.putofacture.value superieure a pulve.cout_total ou a facture.cout', HIGH)
    Putofacture.find(:all).each do |obj| 
      if obj.value > obj.pulve.get_cout_total || obj.value > obj.facture.cout
        test.num += 1
        text = 'pulve ' + obj.pulve.name.to_s + ' (' + obj.pulve.get_cout_total.to_s + ' euros) ' 
        text += 'contribution a la facture ' + obj.facture.name.to_s + ' (' + obj.value.to_s + ' euros)' 
        error = init_error(text, obj.pulve.id, 'pulves', '')
        test.errors << error
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def data_contrib_vente
    test = init_test('vente.ventoparcelle.value superieure a vente.value', HIGH)
    Ventoparcelle.find(:all).each do |obj| 
      if obj.value > obj.vente.value
        test.num += 1
        text = 'vente ' + obj.vente.name.to_s + ' (' + obj.vente.value.to_s + ' euros) ' 
        text += 'contribution a la parcelle ' + obj.parcelle.name.to_s + ' (' + obj.value.to_s + ' euros)' 
        error = init_error(text, obj.vente.id, 'ventes', '')
        test.errors << error
      end
    end
    test.result = (test.num == 0)    
    return test
  end

#Saisie de donnee
  def pulve_sans_facture
    test = init_test('Pulves non associe a une facture', LOW)
    test.num =0
    @pulves = Pulve.find_by_saison(:all)
    unless @pulves.nil?
      @pulves.each do |pulve|    
        if pulve.putofactures.empty?
          test.num += 1
          text = pulve.to_s(:default)
          error = init_error(text, pulve.id, 'pulves', '')
          test.errors << error
        end
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def pulve_avec_facture_et_valeur_incoh
    test = init_test('Pulves associe a une valeur assoc facture incoherente', LOW)
    test.num =0
    @pulves = Pulve.find_by_saison(:all)
    unless @pulves.nil?
      @pulves.each do |pulve|
        var = true
        if pulve.putofactures.empty?
          var = false
        else
          pulve.putofactures.each do |putofacture|
            if (pulve.get_cout_total_produits.almost_eql?(putofacture.value, 2) || 
                pulve.get_cout_total_passage.almost_eql?(putofacture.value, 2))
              var = false
            end
          end
        end
        if var == true
          test.num += 1
          text = pulve.to_s(:default)
          error = init_error(text, pulve.id, 'pulves', '')
          test.errors << error
        end
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def pulve_cout_produit_null
    test = init_test('Pulves dont le cout produit est nul', LOW)
    test.num = 0
    @pulves = Pulve.find_by_saison(:all)
    unless @pulves.nil?
      @pulves.each do |pulve|    
        if pulve.get_cout_total_produits == 0
          test.num += 1
          text = pulve.to_s(:default)
          error = init_error(text, pulve.id, 'pulves', '')
          test.errors << error
        end
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def pulve_sans_facture_service_avec_cout_presta_non_nul
    test = init_test('Pulves dont le cout presta est non nul, sans assoc facture "service_agri"', HIGH)
    test.num = 0
    @pulves = Pulve.find_by_saison(:all)
    unless @pulves.nil?
      @pulves.each do |pulve|
        var = true
        unless pulve.get_cout_total_passage.almost_eql?(0, 1)
          sum_fac_services = 0
          pulve.putofactures.each do |putofacture|
            if putofacture.facture.category_services_agri?
              sum_fac_services += putofacture.value
            end
          end
          if pulve.get_cout_total_passage.almost_eql?(sum_fac_services, 1)
            var = false
          end
        else
          var = false
        end
        if var == true
          test.num += 1
          text = pulve.to_s(:default)
          error = init_error(text, pulve.id, 'pulves', '')
          test.errors << error
        end
      end
    end
    test.result = (test.num == 0)    
    return test
  end

  def produit_sans_facture_avec_pulve
    test = init_test('Produit sans facture mais utilise dans un traitement', HIGH)
    test.num = 0
    @produits = Produit.find_by_saison(:all)
    unless @produits.nil?
      @produits.each do |produit|
        var = false
        if produit.sans_facture_avec_pulve?
          var = true
        end
        if var == true
          test.num += 1
          text = produit.to_s(:default)
          error = init_error(text, produit.id, 'produits', '')
          test.errors << error
        end
      end
    end
    test.result = (test.num == 0)    
    return test
  end





end
