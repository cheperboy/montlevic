class Saisie < ActiveRecord::Base
  
  attr_accessor :serie,
                :pulves

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
    self.pulves = Serie.new('Tests pulves', [])
  end

  def end_test
    self.serie << pulves
  end

  def get_result
    pulves.tests << reportable_sans_report
    pulves.tests << pulve_avec_facture_et_valeur_incoh
  end

  def reportable_sans_report
    test = init_test('Reportable sans aucun report', LOW)
    test.num =0
    Reportable.find(:all).each do |reportable|    
      if true
        test.num += 1
        error = init_error('reportable.name', 'reportable.id', 'factures')
        test.errors << error
      end
    end
    test.result = (test.num == 0)    
    return test
  end
  
  def pulve_avec_facture_et_valeur_incoh
    test = init_test('Pulves non associe a une facture', LOW)
    test.num =0
    @pulves = Pulve.find_by_saison(:all)
    unless @pulves.nil?
      @pulves.each do |pulve|    
        if pulve.putofactures.empty?
          test.num += 1
          error = init_error('pulve.name', 'pulve.id', 'pulves')
          test.errors << error
        end
      end
    end
    test.result = (test.num == 0)    
    return test
  end


end

# 
# 
