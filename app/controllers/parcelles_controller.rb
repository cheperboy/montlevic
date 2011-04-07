class ParcellesController < ApplicationController

  def index
    @parcelles = Parcelle.find_by_saison(:all)

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
    @parcelles = Parcelle.find_by_saison(:all)
    @parcelle = Parcelle.new
    @parcelle.zonetopas.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @parcelle }
    end
  end

  def edit
    @parcelles = Parcelle.find_by_saison(:all)
    @parcelle = Parcelle.find(params[:id])
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
    if (@parcelle.ventoparcelles.count != 0 || 
        @parcelle.putoparcelles != 0 ||
        @parcelle.factoparcelles != 0 ||
        @parcelle.labtoparcelles != 0 )
      flash[:error] = 'Parcelle non supprimee car associations (Vente, Facture, Labour, Pulve).'
    else
      @parcelle.destroy
      flash[:notice] = 'Parcelle supprimee.'
    end
    respond_to do |format|
      format.html { redirect_to(parcelles_url) }
      format.xml  { head :ok }
    end
  end
end
