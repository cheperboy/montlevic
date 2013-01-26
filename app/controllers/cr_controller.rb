class CrController < ApplicationController

  def test
    logger.error "test"
    coltype = Typeculture
    reload_cache = false
    if request.post?
      coltype = params[:column].camelize.constantize unless params[:column].nil?
      reload_cache = true if params[:reload_cache]
    end
    @factcats =     Category.get_factcats
    @factcats.each { |f| logger.error "#{f.id} - #{f.name}"}
      
    @saison =       Saison.find(current_saison_id)
    @colonnes =     coltype.find_for_saison()
    @labours =      @saison.labours
    @pulves =       @saison.pulves
    @produits =     @saison.produits
    @putoproduits = @saison.putoproduits
    @factures =     @saison.factures.find(:all, :order => :id)
    @ventes =       @saison.ventes.find(:all, :order => "category_id")
    # @labour_categories =  Category.labours_cats
    # @facture_categories = Category.factures_cats
    # @pulve_categories =   Category.produits_cats
    @facture_categories = Category.root_facture.children
    @pulve_categories =   Category.root_pulve.children
    @labour_categories =  Category.root_labour.children
    @vente_categories =   Category.root_vente.children
    
    respond_to do |format|

      # set_cache(@saison.id, coltype, reload_cache)
      # @test = get_cache(@saison.id, coltype)

      @test = CR.new(coltype)
      @test.calculate

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
