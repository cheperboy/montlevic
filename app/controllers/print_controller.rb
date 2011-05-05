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
    @types = Factcat.all

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
    @colonnes = @saison.parcelles
    @labours = @saison.labours
    @pulves = @saison.pulves
    @factures = @saison.factures
    @ventes = @saison.ventes.find(:all, :order => "category_id")
    @types = Factcat.all

    respond_to do |format|
      @test = Print.new(Parcelle)
      unless @test.nil?
        if @test.calculate
          format.html
        else
          @display = 0
          flash[:error] = "l'affichage par parcelles n'est pas possible pour cette saison"
          format.html
        end
      end
    end
  end
  
  def zones
    @saison = Saison.find(session[:current_saison_id])
    @colonnes = Zone.all
    @labours = @saison.labours
    @pulves = @saison.pulves
    @factures = @saison.factures.find(:all, :order => :cout)
    @ventes = @saison.ventes.find(:all, :order => "category_id")
    @types = Factcat.all

    respond_to do |format|
      @test = Print.new(Zone)
      unless @test.nil?
        if @test.calculate
          format.html
        else
          @display = 0
          flash[:error] = "l'affichage par zones n'est pas possible pour cette saison"
          format.html
        end
      end
    end    
  end  
  
  def typecultures
    @saison = Saison.find(session[:current_saison_id])
    @colonnes = Typeculture.find_for_saison()
    @labours = @saison.labours
    @pulves = @saison.pulves
    @factures = @saison.factures.find(:all, :order => :cout)
    @ventes = @saison.ventes.find(:all, :order => "category_id")
    @types = Factcat.all

    respond_to do |format|
      @test = Print.new(Typeculture)
      unless @test.nil?
        if @test.calculate
          format.html
        else
          @display = 0
          flash[:error] = "l'affichage par type de cultures n'est pas possible pour cette saison"
          format.html
        end
      end
    end    
  end  
  
end
