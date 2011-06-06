class Analytic < ActiveRecord::Base
  
  attr_accessor :saisons

  # CONSTANTE = 0
  # Colonne = Struct.new(:colonne_id, :type, :datas)

  def initialize

    self.saisons = []
    Saison.find(:all).each do |saison|
      self.saisons[saison.id] = {}
      
      #  init colonnes
      self.saisons[saison.id][:parcelles] = {}
      self.saisons[saison.id][:zones] = {}
      self.saisons[saison.id][:cultures] = {}
      saison.parcelles.each do |parcelle|
        self.saisons[saison.id][:parcelles][parcelle.id] = {}
      end
      saison.typecultures().each do |culture|
        self.saisons[saison.id][:cultures][culture.id] = {}
      end
      saison.zones.each do |zone|
        self.saisons[saison.id][:zones][zone.id] = {}
      end
    end
    logger.error "inspect : " + self.saisons.to_yaml
  end
  
  def set_colonne(saison_id, colonne_type, colonne_id, datas)
    if res.saisons[saison_id]
      if res.saisons[saison_id][colonne_type.to_sym]
        if res.saisons[saison_id][colonne_type.to_sym][colonne_id]
          res.saisons[saison.id][colonne_type.to_sym][colonne_id] = datas
          return true
        end
      end
    else 
      logger.error 'Analytic.Res.saisons... not valid in set_colonne()'
      return false
    end
  end
  
  def get_colonne(saison_id, colonne_type, colonne_id)
    if res.saisons[saison_id]
      if res.saisons[saison_id][colonne_type.to_sym]
        if res.saisons[saison_id][colonne_type.to_sym][colonne_id]
          return res.saisons[saison.id][colonne_type.to_sym][colonne_id]
        end
      end
    else
      logger.error 'Analytic.Res.saisons... not valid in get_colonne()'
      return nil
    end
  end
 
  def init_saisons
    saison = Saison.find(:first)
    campagne = init_campagne(saison.id)
    campagne.parcelles = Colonne.new()
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

  def test
    foo = Analytic.new()
  end

end

# 
# 
