class ParcellesController < ApplicationController
  before_filter :edit_access,
                :only => [:update, :destroy]

  skip_before_filter :login_required, :only => :index_raw# for raw data acces

  def index_raw
    @saison = Saison.find(:last)
    @parcelles = @saison.parcelles # used only for raw data acces (xml & json)
    respond_to do |format|
      # format.html # index.html.erb
      format.xml  # { render :xml => @parcelles }
      format.json  { render :json => @parcelles }
    end
  end

  def index
    @typecultures = Typeculture.find_for_saison()
    @saison = Setting.find(:first).saison
    @parcelles = @saison.parcelles # used only for raw data acces (xml & json)

    respond_to do |format|
      format.html # index.html.erb
      # use index_raw for the following requests  
      format.xml  { render :xml => @parcelles }
      # format.json  { render :json => @parcelles }
    end
  end

  def index_edit
    @saison = Setting.find(:first).saison
    @parcelles = @saison.parcelles

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @parcelles }
    end
  end

  def show
    @parcelle = Parcelle.find(params[:id])
    @parcelles = Parcelle.find_by_saison(:all)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @parcelle }
    end
  end

  def new
    @saison = Setting.find(:first).saison
    @parcelles = Parcelle.find_by_saison(:all)
    @parcelle = Parcelle.new
    @parcelle.zonetopas.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @parcelle }
    end
  end

  def edit
    @typecultures = Typeculture.find_for_saison()
    @saison = Setting.find(:first).saison
    @parcelles = Parcelle.find_by_saison(:all)
    @parcelle = Parcelle.find(params[:id])
    unless @parcelle.saison_id.eql?(current_saison_id)
      respond_to do |format| 
        format.html { redirect_to(parcelles_url) }
        flash[:error] = 'la campagne de travail est differente de la campagne de cet element!'    
      end
    end
  end

  def create
    @parcelles = Parcelle.find_by_saison(:all)
    @parcelle = Parcelle.new(params[:parcelle])
    @parcelle.saison_id = current_saison_id
    respond_to do |format|
      if @parcelle.save
        flash[:notice] = 'Parcelle enregistree'
        format.html { redirect_to(@parcelle) }
        format.xml  { render :xml => @parcelle, :status => :created, :location => @parcelle }
      else
        logger.error @parcelle.errors.to_s
        format.html { render :action => "new" }
        format.xml  { render :xml => @parcelle.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @parcelles = Parcelle.find_by_saison(:all)
    @parcelle = Parcelle.find(params[:id])
    respond_to do |format|
      if @parcelle.update_attributes(params[:parcelle])
        flash[:notice] = 'Parcelle mise a jour'
        format.html { redirect_to(@parcelle) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @parcelle.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @parcelle = Parcelle.find(params[:id])
    if (@parcelle.ventoparcelles.count > 0 || 
        @parcelle.putoparcelles.count > 0 || 
        @parcelle.factoparcelles.count > 0 || 
        @parcelle.labtoparcelles.count > 0)
        flash[:error] = 'Parcelle non supprimee car associations (Pulves, Labours, ...)'
#        flash[:error] = '(Vente). Parcelle - ' + @parcelle.name + ' ventoparcelles.count = ' + @parcelle.ventoparcelles.count.to_s
    else
#      logger.debug('(Vente). Parcelle - ' + @parcelle.name + ' ventoparcelles.count = ' + @parcelle.ventoparcelles.count.to_s)
      @parcelle.destroy
      flash[:notice] = 'Parcelle supprimee.'
    end
    respond_to do |format|
      format.html { redirect_to(parcelles_url) }
      format.xml  { head :ok }
    end
  end

  def export
    file = Parcelle.export_by_saison()
    date = Date.today.strftime("%Y/%m/%d")
    send_data file.string, :filename => "Parcelles-#{date}.xls", :type =>  "application/vnd.ms-excel"    
  end
    
end
