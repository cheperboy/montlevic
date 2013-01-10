class PulvesController < ApplicationController
  before_filter :edit_access,
                :only => [:update, :destroy]

  # REF = 0
  # DESC = 1
  # PRIX = 2

  def by_saison
    @saison = Saison.find_by_year(params[:id])
    respond_to do |format|
      format.xml
    end
  end
  
  def index
    @pulves = Pulve.find_by_saison(:all, :order => :id) 
    if params[:tri]
      @pulves = Pulve.find_by_saison(:all, :order => "#{params[:tri].to_s} #{params[:sens]}") 
    end
    @sum_all_surfaces = 0
    @pulves.each { |pulve| @sum_all_surfaces += pulve.sum_surfaces}
    respond_to do |format|
      format.html
    end
  end

  def export
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="report.xls"'
    headers['Cache-Control'] = ''
    @pulves = Pulve.find_by_saison(:all)
    render :layout => false
  end

  # GET /pulves/1
  # GET /pulves/1.xml
  def show
    @pulve = Pulve.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pulve }
    end
  end

  # GET /pulves/new
  # GET /pulves/new.xml
  def new
    @pulve = Pulve.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pulve }
    end
  end

  # GET /pulves/1/edit
  def edit
    @pulve = Pulve.find(params[:id])
    unless @pulve.saison_id.eql?(current_saison_id)
      respond_to do |format| 
        format.html { redirect_to(@pulve) }
        flash[:error] = 'la campagne de traval est differente de la campagne de ce pulve!'    
      end
    end
  end

  # POST /pulves
  # POST /pulves.xml
  def create
    @pulve = Pulve.new(params[:pulve])
    @pulve.saison_id ||= Setting.get_saison_id
    # transforme les checkbox Typeculture en Factoparcelles
    @pulve.update_typecultures(params[:typecultures])
    @pulve.uniq_parcelles

    respond_to do |format|
      if @pulve.save
        flash[:notice] = 'Pulve ajoute'
        format.html { redirect_to(@pulve) }
        format.xml  { render :xml => @pulve, :status => :created, :location => @pulve }
      else
        add_errors_to_model(@pulve.errors)
        @pulve = Pulve.new(params[:pulve])
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /pulves/1
  # PUT /pulves/1.xml
  def update
    @pulve = Pulve.find(params[:id])

    respond_to do |format|
      if @pulve.update_attributes(params[:pulve])
        @pulve.update_typecultures(params[:typecultures])
        @pulve.uniq_parcelles
        flash[:notice] = 'Pulve mis a jour.'
        format.html { redirect_to(@pulve) }
        format.xml  { head :ok }
      else
        add_errors_to_model(@pulve.errors)
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pulve.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pulves/1
  # DELETE /pulves/1.xml
  def destroy
    @pulve = Pulve.find(params[:id])
    # @pulve.produits ne fonctionne pas car le @pulve sera supprime
    # Donc on recupere les ids des produits du pulve et on charges les produits dans la variable "produits"
    produit_ids = @pulve.produit_ids
    produits = []
    produit_ids.each { |id| produits << Produit.find(id) }

    @pulve.destroy
    produits.each do |produit|
      produit.update_protofacture_stock
    end
    respond_to do |format|
      format.html { redirect_to(pulves_url) }
      format.xml  { head :ok }
    end
  end
  
  def update_star
    logger.error "params : #{params.inspect}"
    star = 0
    if params[:element][:star].eql?("true")
      star = 1
    end
    params[:element][:star] = star
    @element = Pulve.find(params[:id])
    respond_to do |format| 
      if @element.update_attributes(params[:element])
        format.html { redirect_to(@element) }
        format.js	{ head :ok } 
      else
        flash[:error] = 'probleme mise a jour Star ou Adu'
        format.html { render :action => "edit" } 
        format.js	{ head :unprocessable_entity }
      end 
    end
  end

  def update_adu
    logger.error "params : #{params.inspect}"
    adu = 0
    if params[:element][:adu].eql?("true")
      adu = 1
    end
    params[:element][:adu] = adu
    @element = Pulve.find(params[:id])
    respond_to do |format| 
      if @element.update_attributes(params[:element])
        format.html { redirect_to(@element) }
        format.js	{ head :ok } 
      else
        flash[:error] = 'probleme mise a jour Star ou Adu'
        format.html { render :action => "edit" } 
        format.js	{ head :unprocessable_entity }
      end 
    end
  end

end
