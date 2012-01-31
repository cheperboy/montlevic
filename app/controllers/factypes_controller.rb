class FactypesController < ApplicationController
  before_filter :edit_access,
                :only => [:update, :destroy]

  # GET /factypes
  # GET /factypes.xml
  def index
    @factypes = Factype.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @factypes }
    end
  end

  # GET /factypes/1
  # GET /factypes/1.xml
  def show
    @factype = Factype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @factype }
    end
  end

  # GET /factypes/new
  # GET /factypes/new.xml
  def new
    @factype = Factype.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @factype }
    end
  end

  # GET /factypes/1/edit
  def edit
    @factype = Factype.find(params[:id])
  end

  # POST /factypes
  # POST /factypes.xml
  def create
    @factype = Factype.new(params[:factype])

    respond_to do |format|
      if @factype.save
        flash[:notice] = 'Factype was successfully created.'
        format.html { redirect_to(factypes_url) }
        format.xml  { render :xml => @factype, :status => :created, :location => @factype }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @factype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /factypes/1
  # PUT /factypes/1.xml
  def update
    @factype = Factype.find(params[:id])

    respond_to do |format|
      if @factype.update_attributes(params[:factype])
        flash[:notice] = 'Factype was successfully updated.'
        format.html { redirect_to(factypes_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @factype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /factypes/1
  # DELETE /factypes/1.xml
  def destroy
    @factype = Factype.find(params[:id])
    @factype.destroy

    respond_to do |format|
      format.html { redirect_to(factypes_url) }
      format.xml  { head :ok }
    end
  end
end
