class SaisonsController < ApplicationController
before_filter :edit_access,
              :only => [:update, :destroy]

  # GET /saisons
  # GET /saisons.xml
  def index
    @saisons = Saison.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @saisons }
    end
  end

  def select_saison
    logger.error "params:#{params}"
    @setting = Setting.find(:first)
    @saisons = Saison.all
    respond_to do |format|
      if @setting.update_attribute(:saison_id, params[:id])
        @setting.reload
        # Update Session variable
        # current_saison_id = Setting.find(:first).saison.id
        # session[:saison_name] = Setting.find(:first).saison.name
        session[:current_saison_id] = Setting.find(:first).saison_id
        flash[:notice] = 'Saison selectionnee.'
        
      else
        flash[:error] = 'Pas de mise a jour'
      end
      format.html { redirect_to(saisons_url) }
    end
  end

  # GET /saisons/new
  # GET /saisons/new.xml
  def new
    @saison = Saison.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @saison }
    end
  end

  # GET /saisons/1
  # GET /saisons/1.xml
  def show
    @saison = Saison.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @saison }
    end
  end

  # GET /saisons/1/edit
  def edit
    @saison = Saison.find(params[:id])
  end

  # POST /saisons
  # POST /saisons.xml
  def create
    @saison = Saison.new(params[:saison])

    respond_to do |format|
      if @saison.save
        flash[:notice] = 'Saison was successfully created.'
        format.html { redirect_to(@saison) }
        format.xml  { render :xml => @saison, :status => :created, :location => @saison }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @saison.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /saisons/1
  # PUT /saisons/1.xml
  def update
    @saison = Saison.find(params[:id])
    @saison.update_protofacture_stock
logger.error "update saison"
    respond_to do |format|
      if @saison.update_attributes(params[:saison])
        flash[:notice] = 'Saison mis a jour!.'
        format.html { redirect_to(@saison) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @saison.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /saisons/1
  # DELETE /saisons/1.xml
  def destroy
    @saison = Saison.find(params[:id])
    @saison.destroy

    respond_to do |format|
      format.html { redirect_to(saisons_url) }
      format.xml  { head :ok }
    end
  end
end
