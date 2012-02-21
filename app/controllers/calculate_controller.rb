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
    @labour_categories = Category.labours_cats
    @facture_categories = Category.factures_cats
    @pulve_categories = Category.produits_cats
    @vente_categories = Category.ventes_cats
    
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
    @labour_categories = Category.labours_cats
    @facture_categories = Category.factures_cats
    @pulve_categories = Category.produits_cats
    @vente_categories = Category.ventes_cats
    
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
    coltype = Typeculture
    reload_cache = false
    if request.post?
      coltype = params[:column].camelize.constantize unless params[:column].nil?
      reload_cache = true if params[:reload_cache]
    end
    @factcats =     Factcat.find(:all)
    @saison =       Saison.find(session[:current_saison_id])
    @colonnes =     coltype.find_for_saison()
    @labours =      @saison.labours
    @pulves =       @saison.pulves
    @produits =     @saison.produits
    @putoproduits = @saison.putoproduits
    @factures =     @saison.factures.find(:all, :order => :id)
    @ventes =       @saison.ventes.find(:all, :order => "category_id")
    @types =        Factcat.all
    @labour_categories =  Category.labours_cats
    @facture_categories = Category.factures_cats
    @pulve_categories =   Category.produits_cats
    @vente_categories =   Category.ventes_cats
    
    respond_to do |format|
      set_cache(@saison.id, coltype, reload_cache)
      @test = get_cache(@saison.id, coltype)
      unless @test.nil?
        format.html
      else
        @display = 0
        flash[:error] = "l'affichage par type de cultures n'est pas possible pour cette saison"
        format.html
      end
    end    
  end  
  
  def get_cache(saison_id, col)
    logger.error "getting cache #{saison_id}/#{col}"
    cache_id = get_cache_id(saison_id, col)
    return Rails.cache.read(cache_id)
  end
  
  def set_cache(saison_id, col, reload)
    logger.error "set_cache. saison: #{saison_id}/col: #{col} reload: #{reload.to_s}"
    cache_id = get_cache_id(saison_id, col)
    if (Rails.cache.read(cache_id).nil? || reload.eql?(true))
      @resultat = Calculate.new(col)
      @resultat.calculate
      Rails.cache.write(cache_id, @resultat)
      logger.error "\t#{cache_id} just cached \n"
    else
      logger.error "\t#{cache_id} already cached \n"
    end
  end
   
  def get_cache_id(saison_id, col)
    cache_id = ""
    cache_id += saison_id.to_s
    cache_id += "/"
    cache_id += col.to_s
    return(cache_id)
  end

  def get_saison_from_cache_id(cache_id)
    cache_id.split('/')[0]
  end
  
end
