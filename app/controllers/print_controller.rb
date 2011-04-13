class PrintController < ApplicationController

  def csv
    unless params[:model] == nil
      model = params[:model]
    else
      model = Zone
    end
    @labours = Labour.find_by_saison(:all)
    @pulves = Pulve.find_by_saison(:all)
    @factures = Facture.find_by_saison(:all, :order => "category_id")
    @ventes = Vente.find_by_saison(:all, :order => "category_id")
    @types = Category.find_all_by_upcategory_id(Upcategory.find_by_name('facture'))

    @csv = Print.new
    @csv.init_display

    unless params[:print] == nil
      [Labour, Pulve, Facture, Vente].each do |model| 
        sym = model.to_s.downcase.pluralize.to_sym
        @csv.display[sym] = params[:print][sym].to_i
#       @csv.display[:labours] = params[:print][:detail_labours].to_i
      end
    end
    
    @csv.calculate(model)
    @csv.generate_csv(model)
  end

  def parcelles
    @saison = Saison.find(session[:current_saison_id])
    @labours = @saison.labours
    @pulves = @saison.pulves
    @factures = Facture.find_by_saison(:all, :order => "category_id")
    @ventes = Vente.find_by_saison(:all, :order => "category_id")
    @types = Category.find_all_by_upcategory_id(Upcategory.find_by_name('facture'))

    @test = Print.new
    respond_to do |format|
      unless @test.calculate(Parcelle).nil?
        format.html
      else
        @display = 0
        flash[:error] = "l'affichage par parcelles n'est pas possible pour cette saison"
        format.html
      end
    end    
  end  
  
  def zones
    @labours = Labour.find_by_saison(:all)
    @pulves = Pulve.find_by_saison(:all)
    @factures = Facture.find_by_saison(:all, :order => "category_id")
    @ventes = Vente.find_by_saison(:all, :order => "category_id")
    @types = Category.find_all_by_upcategory_id(Upcategory.find_by_name('facture'))

    @test = Print.new
    respond_to do |format|
      unless @test.calculate(Zone).nil?
        format.html
      else
        @display = 0
        flash[:error] = "l'affichage par zones n'est pas possible pour cette saison"
        format.html 
      end
    end    
  end  
  
  def typecultures
    @labours = Labour.find_by_saison(:all)
    @pulves = Pulve.find_by_saison(:all)
    @factures = Facture.find_by_saison(:all, :order => "category_id")
    @ventes = Vente.find_by_saison(:all, :order => "category_id")
    @types = Category.find_all_by_upcategory_id(Upcategory.find_by_name('facture'))
    @test = Print.new
    respond_to do |format|
      unless @test.calculate(Typeculture).nil?
        format.html
      else
        @display = 0
        flash[:error] = "l'affichage par type de culture n'est pas possible"
        format.html
      end
    end    
  end  
  
end
