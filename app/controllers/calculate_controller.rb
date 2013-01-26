require "yaml"
class CalculateController < ApplicationController
  def export
    coltype = Typeculture
    reload_cache = false
    if request.post?
      coltype = params[:column].camelize.constantize unless params[:column].nil?
      reload_cache = true if params[:reload_cache]
    end
    @factcats =     Category.get_factcats      
    @saison =       Saison.find(current_saison_id)
    @colonnes =     coltype.find_for_saison()
    @labours =      @saison.labours
    @pulves =       @saison.pulves
    @produits =     @saison.produits
    @putoproduits = @saison.putoproduits
    @factures =     @saison.factures.find(:all, :order => :id)
    @ventes =       @saison.ventes.find(:all, :order => "category_id")
    @facture_categories = Category.root_facture.children
    @pulve_categories =   Category.root_pulve.children
    @labour_categories =  Category.root_labour.children
    @vente_categories =   Category.root_vente.children
    
    #calcul des donnees
    @test = Calculate.new(coltype)
    @test.calculate
    # 
    #creation du fichier xls
    # export = Analytic_xls.new()
    # export.write
    # 
    # #telechargement du fichier
    # buffer = StringIO.new
    # export.book.write(buffer)
    # buffer.rewind
    # send_data buffer.read   
    @line = 1
    name = "export analytic #{@saison.name}"
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = "attachment; filename='#{name}.xls'"
    headers['Cache-Control'] = ''
    render(:layout=>false)   
  end

  def categories
    t0 = Time.now
    coltype = Typeculture
    reload_cache = false
    if request.post?
      coltype = params[:column].camelize.constantize unless params[:column].nil?
      reload_cache = true if params[:reload_cache]
    end
    @factcats =     Category.get_factcats
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
            
      @test = Calculate.new(coltype)
      @test.calculate
      @t1 = Time.now
      unless @test.nil?
        format.html
        logger.error "Time Calculate: #{Time.now - t0}"
      else
        @display = 0
        flash[:error] = "l'affichage par type de cultures n'est pas possible pour cette saison"
        format.html
      end
    end    
  end  
  
  def test_set_cache
    # c = Calculate.new(Typeculture)
    # c.calculate
    c = {}
    c[:toto] = "titi"
    c[:myhash] = {}
    c[:myhash][:hash1] = []
    c[:myhash][:hash1] = [1, 2, 3]
    c[:myhash][:hash2] = {}
    c[:myhash][:hash2][:key1] = 12
    Rails.cache.write(1, YAML::dump(c))
    respond_to do |format|
      format.html { redirect_to(saisons_url) }
    end
  end
  
  def test_reset_cache
    Rails.cache.write(1, "empty")
    respond_to do |format|
      format.html { redirect_to(saisons_url) }
    end
  end
  
  def test_get_cache
    return YAML::load(Rails.cache.read(1))
    respond_to do |format|
      format.html { redirect_to(saisons_url) }
    end
  end
  
  def get_cache(saison_id, col)
    logger.error "getting cache #{saison_id}/#{col}"
    cache_id = get_cache_id(saison_id, col)
    # return Analytic.from_json(Rails.cache.read(cache_id))
    return YAML::load(Rails.cache.read(cache_id))
  end
  
  def set_cache(saison_id, col, reload)
    logger.error "set_cache. saison: #{saison_id}/col: #{col} reload: #{reload.to_s}"
    cache_id = get_cache_id(saison_id, col)
    if (Rails.cache.read(cache_id).nil? || reload.eql?(true))
      @test = Calculate.new(col)
      @test.calculate
      Rails.cache.write(cache_id, @test)
      logger.error "\t#{cache_id} just cached \n"
    else
      logger.error "\t#{cache_id} already cached \n"
    end
  end
   
  def set_cache_from_button
    # get variables from params
    saison_id = params[:saison_id]
    col       = params[:col].camelize.constantize unless params[:col].nil?
    
    reload    = true    
    logger.error "set_cache. saison: #{saison_id}/col: #{col} reload: #{reload.to_s}"
    cache_id = get_cache_id(saison_id, col)
    respond_to do |format|
      unless col.nil? 
        if (Rails.cache.read(cache_id).nil? || reload.eql?(true))
          t0 = Time.now
          @test = Calculate.new(col)
          @test.calculate
          t1 = Time.now
          logger.error "Time to Calculate : #{t1 - t0}"
          logger.error "read @test #{@test.res.get_saison_datas(@test.sid, :name)}"
          logger.error "read @test.res.saisons #{@test.res.saisons[@test.sid].to_s}"
          
          Rails.cache.write(cache_id, YAML::dump(@test.res.saisons))
          # Rails.cache.write(cache_id, @test.res.to_json)
          logger.error "\t#{cache_id} just cached \n"
        end
      else
        logger.error "\t#{cache_id} already cached \n"
      end
      format.html { redirect_to(saisons_url) }
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
  

  # def export
  #   headers['Content-Type'] = "application/vnd.ms-excel"
  #   headers['Content-Disposition'] = 'attachment; filename="print.xls"'
  #   headers['Cache-Control'] = ''
  #   model = Typeculture
  #   @show = Hash.new()
  #   @show[:cout_total] = true
  #   @show[:cout_ha] = true
  #   @show[:pulves] = true
  #   @show[:labours] = true
  #   @show[:total_type] = true
  #   @show[:total_cat] = true
  #   @show[:date_surface] = true
  #   
  #   if request.post?
  #     model = params[:column].camelize.constantize unless params[:column].nil?
  #     @show[:cout_total] = false
  #     @show[:cout_ha] = false
  #     @show[:pulves] = false
  #     @show[:labours] = false
  #     @show[:total_type] = false
  #     @show[:total_cat] = false
  #     @show[:date_surface] = ((@show[:pulves] == true) && ( @show[:labours] == true))
  #     unless params[:show].nil?
  #       @show[:cout_total] = params[:show]['cout_total'] unless params[:show]['cout_total'].nil?
  #       @show[:cout_ha] = params[:show]['cout_ha'] unless params[:show]['cout_ha'].nil?
  #       @show[:pulves] = params[:show]['pulves'] unless params[:show]['pulves'].nil?
  #       @show[:labours] = params[:show]['labours'] unless params[:show]['labours'].nil?
  #       @show[:total_type] = params[:show]['total_type'] unless params[:show]['total_type'].nil?
  #       @show[:total_cat] = params[:show]['total_cat'] unless params[:show]['total_cat'].nil?
  #     end
  #   end
  #   @colonnes = model.find_for_saison()
  #   @saison = Saison.find(session[:current_saison_id])
  #   @labours = @saison.labours
  #   @pulves = @saison.pulves
  #   @produits = @saison.produits
  #   @putoproduits = @saison.putoproduits
  #   @factures = @saison.factures.find(:all, :order => :cout)
  #   @ventes = @saison.ventes.find(:all, :order => "category_id")
  #   @types = Factcat.all
  #   @labour_categories = Category.labours_cats
  #   @facture_categories = Category.factures_cats
  #   @pulve_categories = Category.produits_cats
  #   @vente_categories = Category.ventes_cats
  #   
  #   respond_to do |format|
  #     @test = Calculate.new(model)
  #     unless @test.nil?
  #       if @test.calculate
  #         format.html
  #       else
  #         @display = 0
  #         flash[:error] = "l'affichage par type de cultures n'est pas possible pour cette saison"
  #         format.html
  #       end
  #     end
  #   end    
  # end  

  # def all
  #   model = Typeculture
  #   @show = Hash.new()
  #   @show[:cout_total] = true
  #   @show[:cout_ha] = true
  #   @show[:pulves] = false
  #   @show[:labours] = true
  #   @show[:total_type] = true
  #   @show[:total_cat] = true
  #   @show[:date_surface] = false
  #   
  #   if request.post?
  #     model = params[:column].camelize.constantize unless params[:column].nil?
  #     @show[:cout_total] = false
  #     @show[:cout_ha] = false
  #     @show[:pulves] = false
  #     @show[:labours] = false
  #     @show[:total_type] = false
  #     @show[:total_cat] = false
  #     @show[:date_surface] = ((@show[:pulves] == true) && ( @show[:labours] == true))
  #     unless params[:show].nil?
  #       @show[:cout_total] = params[:show]['cout_total'] unless params[:show]['cout_total'].nil?
  #       @show[:cout_ha] = params[:show]['cout_ha'] unless params[:show]['cout_ha'].nil?
  #       @show[:pulves] = params[:show]['pulves'] unless params[:show]['pulves'].nil?
  #       @show[:labours] = params[:show]['labours'] unless params[:show]['labours'].nil?
  #       @show[:total_type] = params[:show]['total_type'] unless params[:show]['total_type'].nil?
  #       @show[:total_cat] = params[:show]['total_cat'] unless params[:show]['total_cat'].nil?
  #     end
  #   end
  #   @saison = Saison.find(session[:current_saison_id])
  #   @colonnes = model.find_for_saison()
  #   if model.eql?(Parcelle)
  #     typeculture = Typeculture.find_by_name("Ble")
  #     @colonnes = @saison.parcelles.find( :all,
  #                                         # :conditions => ["typeculture_id = ?", typeculture],
  #                                         :order => :typeculture_id
  #                                       )
  #   end
  #   @labours = @saison.labours
  #   @pulves = @saison.pulves
  #   @produits = @saison.produits
  #   @putoproduits = @saison.putoproduits
  #   @factures = @saison.factures.find(:all, :order => :id)
  #   @ventes = @saison.ventes.find(:all, :order => "category_id")
  #   @types = Factcat.all
  #   @labour_categories = Category.labours_cats
  #   @facture_categories = Category.factures_cats
  #   @pulve_categories = Category.produits_cats
  #   @vente_categories = Category.ventes_cats
  #   
  #   respond_to do |format|
  #     @test = Calculate.new(model)
  #     unless @test.nil?
  #       if @test.calculate
  #         format.html
  #       else
  #         @display = 0
  #         flash[:error] = "l'affichage par type de cultures n'est pas possible pour cette saison"
  #         format.html
  #       end
  #     end
  #   end    
  # end  
  
end
