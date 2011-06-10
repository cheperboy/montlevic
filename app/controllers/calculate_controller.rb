class CalculateController < ApplicationController
  def all
    model = Typeculture
    @show = Hash.new()
    @show[:cout_total] = true
    @show[:cout_ha] = true
    @show[:pulves] = true
    @show[:labours] = true
    @show[:total_type] = true
    @show[:total_cat] = true
    
    if request.post?
      model = params[:column].camelize.constantize unless params[:column].nil?
      @show[:cout_total] = false
      @show[:cout_ha] = false
      @show[:pulves] = false
      @show[:labours] = false
      @show[:total_type] = false
      @show[:total_cat] = false
      unless params[:show].nil?
        @show[:cout_total] = params[:show]['cout_total'] unless params[:show]['cout_total'].nil?
        @show[:cout_ha] = params[:show]['cout_ha'] unless params[:show]['cout_ha'].nil?
        @show[:pulves] = params[:show]['pulves'] unless params[:show]['pulves'].nil?
        @show[:labours] = params[:show]['labours'] unless params[:show]['labours'].nil?
        @show[:total_type] = params[:show]['total_type'] unless params[:show]['total_type'].nil?
        @show[:total_cat] = params[:show]['total_cat'] unless params[:show]['total_cat'].nil?
      end
    end
    @colonnes = model.find_for_saison()
    @saison = Saison.find(session[:current_saison_id])
    @labours = @saison.labours
    @factures = @saison.factures.find(:all, :order => :cout)
    @ventes = @saison.ventes.find(:all, :order => "category_id")
    @types = Factcat.all
    @labour_categories = Category.labours
    @facture_categories = Category.factures
    @pulve_categories = Category.pulves
    @pulves = @saison.pulves
    
    respond_to do |format|
      @test = Calculate.new(model)
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
