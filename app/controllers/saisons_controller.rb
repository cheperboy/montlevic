class SaisonsController < ApplicationController
  before_filter :edit_access,
                :only => [:update, :destroy]

  skip_before_filter :login_required, :only => :index # for raw data acces

  # pour export dans google doc
  # synthese de la saison
  def gdoc_synthese_resultat
    @saison = Saison.find_by_year(params[:id])
    @sum_factures = Facture.synthese_by_cat(@saison)
    @sum_ventes = Vente.synthese_by_cat(@saison) #pour calculer resultat
    respond_to do |format|
      format.html
      format.xml
    end
  end

  def gdoc_synthese_charges
    @saison = Saison.find_by_year(params[:id])
    @sum_factures = Facture.synthese_by_cat(@saison)
    respond_to do |format|
      format.html
      format.xml
    end
  end
  def gdoc_categories_charges
    @saison = Saison.find_by_year(params[:id])
    @sum_factures = Facture.synthese_by_cat(@saison)
    respond_to do |format|
      format.html
      format.xml
    end
  end
  def gdoc_evolution_charges
    @years = []
    @year = params[:id].to_i
    @saison = {}
    @sum_factures = {}
    year = params[:id]
    while (Saison.find_by_year(year))
      @years << year.to_s
      @saison[year.to_sym]       = Saison.find_by_year(year)
      @sum_factures[year.to_sym] = Facture.synthese_by_cat(@saison[year.to_sym])
      year = (year.to_i - 1).to_s
    end
    respond_to do |format|
      format.html
      format.xml
    end
  end

  def gdoc_synthese_ventes
    @saison = Saison.find_by_year(params[:id])
    @sum_ventes = Vente.synthese_by_cat(@saison) #pour calculer resultat
    respond_to do |format|
      format.html
      format.xml
    end
  end
  def gdoc_categories_ventes
    @saison = Saison.find_by_year(params[:id])
    @sum_ventes = Vente.synthese_by_cat(@saison) #pour calculer resultat
    respond_to do |format|
      format.html
      format.xml
    end
  end

  def gdoc_liste_ventes
    @saison = Saison.find_by_year(params[:id])
    @ventes = @saison.ventes.find(:all, :order => :user_id)
    respond_to do |format|
      format.html
      format.xml
    end
  end
  def gdoc_liste_charges
    @saison = Saison.find_by_year(params[:id])
    @factures = @saison.factures.find(:all, :order => :user_id)
    respond_to do |format|
      format.html
      format.xml
    end
  end

  # GET /saisons
  # GET /saisons.xml
  def index
    @saisons = Saison.find(:all, :order => :id)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @saisons }
      format.json  { render :json => @saisons }
    end
  end

  def init_serialized    
    respond_to do |format|
      if Saison::init_serialized
        flash[:notice] = 'init ok.'
      else
        flash[:error] = 'probleme init'
      end
      puts "#{Saison.find(:first).sum_charges.to_yaml}"
      format.html { redirect_to(saisons_url) }
    end
  end

  def select_saison
    # Update Session variable
    session[:current_saison_id] = params[:id].to_i
    #update user preferences
    Myuser.find(session[:user_id]).set_pref_saison(params[:id].to_i)
    respond_to do |format|     
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
