class VentesController < ApplicationController

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

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vente }
    end
  end

  # GET /ventes/1/edit
  def edit
    @vente = Vente.find(params[:id])
  end

  # POST /ventes
  # POST /ventes.xml
  def create
    @vente = Vente.new(params[:vente])
    @vente.saison_id = current_saison_id
    respond_to do |format|
      if @vente.save
        flash[:notice] = 'Vente was successfully created.'
        format.html { redirect_to(@vente) }
        format.xml  { render :xml => @vente, :status => :created, :location => @vente }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ventes/1
  # PUT /ventes/1.xml
  def update
    @vente = Vente.find(params[:id])

    respond_to do |format|
      if @vente.update_attributes(params[:vente])
        flash[:notice] = 'Vente was successfully updated.'
        format.html { redirect_to(@vente) }
        format.xml  { head :ok }
      else
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
end
