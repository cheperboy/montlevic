class LabtoparcellesController < ApplicationController
  # GET /labtoparcelles
  # GET /labtoparcelles.xml
  def index
    @labtoparcelles = Labtoparcelle.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @labtoparcelles }
    end
  end

  # GET /labtoparcelles/1
  # GET /labtoparcelles/1.xml
  def show
    @labtoparcelle = Labtoparcelle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @labtoparcelle }
    end
  end

  # GET /labtoparcelles/new
  # GET /labtoparcelles/new.xml
  def new
    @labtoparcelle = Labtoparcelle.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @labtoparcelle }
    end
  end

  # GET /labtoparcelles/1/edit
  def edit
    @labtoparcelle = Labtoparcelle.find(params[:id])
  end

  # POST /labtoparcelles
  # POST /labtoparcelles.xml
  def create
    @labtoparcelle = Labtoparcelle.new(params[:labtoparcelle])

    respond_to do |format|
      if @labtoparcelle.save
        flash[:notice] = 'Labtoparcelle was successfully created.'
        format.html { redirect_to(@labtoparcelle) }
        format.xml  { render :xml => @labtoparcelle, :status => :created, :location => @labtoparcelle }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @labtoparcelle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /labtoparcelles/1
  # PUT /labtoparcelles/1.xml
  def update
    @labtoparcelle = Labtoparcelle.find(params[:id])

    respond_to do |format|
      if @labtoparcelle.update_attributes(params[:labtoparcelle])
        flash[:notice] = 'Labtoparcelle was successfully updated.'
        format.html { redirect_to(@labtoparcelle) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @labtoparcelle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /labtoparcelles/1
  # DELETE /labtoparcelles/1.xml
  def destroy
    @labtoparcelle = Labtoparcelle.find(params[:id])
    @labtoparcelle.destroy

    respond_to do |format|
      format.html { redirect_to(labtoparcelles_url) }
      format.xml  { head :ok }
    end
  end
end
