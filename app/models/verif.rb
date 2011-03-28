class Verif < ActiveRecord::Base
  
  attr_accessor :serie,
                :factures, :factypes, :structure, :others

  LOW = 0
  HIGH = 1

  Serie = Struct.new(:name, :tests)
  Test = Struct.new(:name, :result, :num, :level, :errors)
  Error = Struct.new(:name, :id, :controller, :url)

  def init_test(name, level) 
    test = Test.new(name, 0, 0, level, [])
    return test
  end
  
  def init_error(name, id, controller) 
    error = Error.new(name, id, controller, nil)
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
    self.others = Serie.new('Autres tests', [])
  end

  def end_test
    self.serie << factures
    self.serie << factypes
    self.serie << structure
    self.serie << others
  end

  def get_result
    factures.tests << report_sans_reportable
    factures.tests << reportable_sans_report
    factures.tests << facdiv_sans_diverse
    factures.tests << diverse_sans_facdiv
    
    factypes.tests << report_factype_null
    factypes.tests << reportable_factype_notnull
    factypes.tests << debit_factype_null_perdu

    structure.tests << ventoparcelle_deleted_ids
    structure.tests << factoparcelle_deleted_ids
    structure.tests << labtoparcelle_deleted_ids
    structure.tests << putoparcelle_deleted_ids
    structure.tests << labtofacture_deleted_ids
    structure.tests << putofacture_deleted_ids
  end

  def reportable_sans_report
    test = init_test('Reportable sans aucun report', LOW)
    test.num =0
    Reportable.find(:all).each do |reportable|    
      if reportable.reports.empty?
        test.num += 1
        error = init_error(reportable.name, reportable.id, 'factures')
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
    test = init_test('Debit (Facture) avec factype NULL mais sans labour ni pulve associes)', LOW)
    Debit.find(:all).each do |facture|    
      if facture.factype_id.equal?(Factype.find_by_name('null').id) && facture.pulves.empty? && facture.labours.empty?
        test.num += 1
        error = init_error(facture.name, facture.id, 'factures')
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
        error = init_error(facdiv.name, facdiv.id, nil)
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
        error = init_error(text, obj.id, nil)
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
        error = init_error(text, obj.id, nil)
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
        error = init_error(text, obj.id, nil)
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
        error = init_error(text, obj.id, nil)
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
        error = init_error(text, obj.id, nil)
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
        error = init_error(text, obj.id, nil)
        test.errors << error
      end
    end
    test.result = (test.num == 0)    
    return test
  end




end
