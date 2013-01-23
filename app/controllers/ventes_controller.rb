class VentesController < ApplicationController
  before_filter :edit_access,
                :only => [:update, :destroy]

  skip_before_filter :login_required, :only => [:by_saison, :analytic] # for raw data acces

  def by_saison
    @saison = Saison.find_by_year(params[:id])
    respond_to do |format|
      format.xml
    end
  end

  def analytic
    @saison = Saison.find_by_year(params[:id])
    @sum = Vente.synthese_by_cat(@saison)
    respond_to do |format|
      format.html
      format.xml
    end
  end

  def toggle_star
    @vente = Vente.find(params[:id])
    if @vente.star != 1
       @vente.star = 1
    else
      @vente.star = 0
    end
    if @vente.save
      render(:layout => false)
    end
  end
  
  def toggle_adu
    @vente = Vente.find(params[:id])
    if @vente.adu != 1
       @vente.adu = 1
    else
      @vente.adu = 0
    end
    if @vente.save
      render(:layout => false)
    end
  end

  # GET /ventes
  # GET /ventes.xml
  def index
    @ventes = Vente.find_by_saison(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ventes }
    end
  end

  # GET /ventes/1
  # GET /ventes/1.xml
  def show
    @vente = Vente.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vente }
    end
  end

  # GET /ventes/new
  # GET /ventes/new.xml
  def new
    @vente = Vente.new
    @action = 'new'
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vente }
    end
  end

  # GET /ventes/1/edit
  def edit
    @vente = Vente.find(params[:id])
    @action = 'edit'
    unless @vente.saison_id.eql?(current_saison_id)
      respond_to do |format|
        format.html { redirect_to(@vente) }
        flash[:error] = 'la campagne de travail est differente de la campagne de cette vente!'
      end
    end    
  end

  def create
    puts "call action create!"
    @vente = Vente.new(params[:vente])
    @vente.saison_id = current_saison_id
    # si calcul_auto? alors on set le prix
    # if params[:vente][:calcul_auto].to_i.eql?(1)
    #   @vente.set_prix 
    # end
    @vente.update_typecultures(params[:typecultures])
    @vente.uniq_parcelles
    respond_to do |format|
      if @vente.save
        @vente.set_prix if @vente.calcul_auto.eql?(1)
        flash[:notice] = 'Vente was successfully created.'
        format.html { redirect_to(@vente) }
        format.xml  { render :xml => @vente, :status => :created, :location => @vente }
      else
        @action = 'edit'
        add_errors_to_model(@vente.errors)
        format.html { render :action => "new" }
        format.xml  { render :xml => @vente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ventes/1
  # PUT /ventes/1.xml
  def update
    @vente = Vente.find(params[:id])
    # si calcul_auto? alors on set un prix fake pour passer la validation
    # if params[:vente][:calcul_auto].to_i.eql?(1) 
    #   params[:vente][:prix] = 0
    # end
    respond_to do |format|
      if @vente.update_attributes(params[:vente])
        # si calcul_auto? alors on set le prix
        @vente.set_prix if @vente.calcul_auto.eql?(1)
        @vente.update_typecultures(params[:typecultures])
        @vente.uniq_parcelles
        flash[:notice] = 'Vente mis a jour!.'
        format.html { redirect_to(@vente) }
        format.xml  { head :ok }
      else
        @action = 'edit'
        add_errors_to_model(@vente.errors)
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ventes/1
  # DELETE /ventes/1.xml
  def destroy
    @vente = Vente.find(params[:id])
    @vente.destroy

    respond_to do |format|
      format.html { redirect_to(ventes_url) }
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
    @element = Vente.find(params[:id])
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
    @element = Vente.find(params[:id])
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
