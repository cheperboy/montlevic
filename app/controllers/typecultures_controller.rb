class TypeculturesController < ApplicationController
  before_filter :edit_access,
                :only => [:update, :destroy]
                
  # GET /typecultures
  # GET /typecultures.xml
  def index
    @typecultures = Typeculture.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @typecultures }
    end
  end

  # GET /typecultures/1
  # GET /typecultures/1.xml
  def show
    @typeculture = Typeculture.find(params[:id])
    @typecultures = Typeculture.all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @typeculture }
    end
  end

  # GET /typecultures/new
  # GET /typecultures/new.xml
  def new
    @typeculture = Typeculture.new
    @typecultures = Typeculture.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @typeculture }
    end
  end

  # GET /typecultures/1/edit
  def edit
    @typeculture = Typeculture.find(params[:id])
    @typecultures = Typeculture.all
  end

  # POST /typecultures
  # POST /typecultures.xml
  def create
    @typeculture = Typeculture.new(params[:typeculture])

    respond_to do |format|
      if @typeculture.save
        flash[:notice] = 'Typeculture was successfully created.'
        format.html { redirect_to(typecultures_url) }
        format.xml  { render :xml => @typeculture, :status => :created, :location => @typeculture }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @typeculture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /typecultures/1
  # PUT /typecultures/1.xml
  def update
    @typeculture = Typeculture.find(params[:id])

    respond_to do |format|
      if @typeculture.update_attributes(params[:typeculture])
        flash[:notice] = 'Typeculture mis a jour!.'
        format.html { redirect_to(typecultures_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @typeculture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /typecultures/1
  # DELETE /typecultures/1.xml
  def destroy
    @typeculture = Typeculture.find(params[:id])
    name = @typeculture.name

    respond_to do |format|
      if (@typeculture.parcelles.size == 0)
        @typeculture.destroy
        flash[:notice] = 'le type de culture "'+ name +'" a ete supprime.'
        format.html { redirect_to(typecultures_url) }
        format.xml  { head :ok }
      else
        flash[:error] = 'Impossible de supprimer, "'+ name +'"est lie a des parcelles.'
        format.html { redirect_to(typecultures_url) }
        format.xml  { render :xml => @typeculture.errors, :status => :unprocessable_entity }
      end
    end
  end

end
