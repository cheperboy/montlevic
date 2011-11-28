class CalculateController < ApplicationController

  def export
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="print.xls"'
    headers['Cache-Control'] = ''
    model = Typeculture
    @show = Hash.new()
    @show[:cout_total] = true
    @show[:cout_ha] = true
    @show[:pulves] = true
    @show[:labours] = true
    @show[:total_type] = true
    @show[:total_cat] = true
    @show[:date_surface] = true
    
    if request.post?
      model = params[:column].camelize.constantize unless params[:column].nil?
      @show[:cout_total] = false
      @show[:cout_ha] = false
      @show[:pulves] = false
      @show[:labours] = false
      @show[:total_type] = false
      @show[:total_cat] = false
      @show[:date_surface] = ((@show[:pulves] == true) && ( @show[:labours] == true))
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
    @pulves = @saison.pulves
    @produits = @saison.produits
    @putoproduits = @saison.putoproduits
    @factures = @saison.factures.find(:all, :order => :cout)
    @ventes = @saison.ventes.find(:all, :order => "category_id")
    @types = Factcat.all
    @labour_categories = Category.labours
    @facture_categories = Category.factures
    @pulve_categories = Category.pulves
    @vente_categories = Category.ventes
    
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

  def all
    model = Typeculture
    @show = Hash.new()
    @show[:cout_total] = true
    @show[:cout_ha] = true
    @show[:pulves] = false
    @show[:labours] = true
    @show[:total_type] = true
    @show[:total_cat] = true
    @show[:date_surface] = false
    
    if request.post?
      model = params[:column].camelize.constantize unless params[:column].nil?
      @show[:cout_total] = false
      @show[:cout_ha] = false
      @show[:pulves] = false
      @show[:labours] = false
      @show[:total_type] = false
      @show[:total_cat] = false
      @show[:date_surface] = ((@show[:pulves] == true) && ( @show[:labours] == true))
      unless params[:show].nil?
        @show[:cout_total] = params[:show]['cout_total'] unless params[:show]['cout_total'].nil?
        @show[:cout_ha] = params[:show]['cout_ha'] unless params[:show]['cout_ha'].nil?
        @show[:pulves] = params[:show]['pulves'] unless params[:show]['pulves'].nil?
        @show[:labours] = params[:show]['labours'] unless params[:show]['labours'].nil?
        @show[:total_type] = params[:show]['total_type'] unless params[:show]['total_type'].nil?
        @show[:total_cat] = params[:show]['total_cat'] unless params[:show]['total_cat'].nil?
      end
    end
    @saison = Saison.find(session[:current_saison_id])
    @colonnes = model.find_for_saison()
    if model.eql?(Parcelle)
      typeculture = Typeculture.find_by_name("Ble")
      @colonnes = @saison.parcelles.find( :all,
                                          # :conditions => ["typeculture_id = ?", typeculture],
                                          :order => :typeculture_id
                                        )
    end
    @labours = @saison.labours
    @pulves = @saison.pulves
    @produits = @saison.produits
    @putoproduits = @saison.putoproduits
    @factures = @saison.factures.find(:all, :order => :id)
    @ventes = @saison.ventes.find(:all, :order => "category_id")
    @types = Factcat.all
    @labour_categories = Category.labours
    @facture_categories = Category.factures
    @pulve_categories = Category.pulves
    @vente_categories = Category.ventes
    
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
  
  def categories
    model = Typeculture
    @factcats = Factcat.find(:all)
    
    @show = Hash.new()
    @show[:cout_total] = true
    @show[:cout_ha] = true
    @show[:pulves] = false
    @show[:labours] = true
    @show[:total_type] = true
    @show[:total_cat] = true
    @show[:date_surface] = false
    
    if request.post?
      model = params[:column].camelize.constantize unless params[:column].nil?
      @show[:cout_total] = false
      @show[:cout_ha] = false
      @show[:pulves] = false
      @show[:labours] = false
      @show[:total_type] = false
      @show[:total_cat] = false
      @show[:date_surface] = ((@show[:pulves] == true) && ( @show[:labours] == true))
      unless params[:show].nil?
        @show[:cout_total] = params[:show]['cout_total'] unless params[:show]['cout_total'].nil?
        @show[:cout_ha] = params[:show]['cout_ha'] unless params[:show]['cout_ha'].nil?
        @show[:pulves] = params[:show]['pulves'] unless params[:show]['pulves'].nil?
        @show[:labours] = params[:show]['labours'] unless params[:show]['labours'].nil?
        @show[:total_type] = params[:show]['total_type'] unless params[:show]['total_type'].nil?
        @show[:total_cat] = params[:show]['total_cat'] unless params[:show]['total_cat'].nil?
      end
    end
    @saison = Saison.find(session[:current_saison_id])
    @colonnes = model.find_for_saison()
    if model.eql?(Parcelle)
      typeculture = Typeculture.find_by_name("Ble")
      @colonnes = @saison.parcelles.find( :all,
                                          # :conditions => ["typeculture_id = ?", typeculture],
                                          :order => :typeculture_id
                                        )
    end
    @labours = @saison.labours
    @pulves = @saison.pulves
    @produits = @saison.produits
    @putoproduits = @saison.putoproduits
    @factures = @saison.factures.find(:all, :order => :id)
    @ventes = @saison.ventes.find(:all, :order => "category_id")
    @types = Factcat.all
    @labour_categories = Category.labours
    @facture_categories = Category.factures
    @pulve_categories = Category.pulves
    @vente_categories = Category.ventes
    
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
