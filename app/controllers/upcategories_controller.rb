class UpcategoriesController < ApplicationController
  # GET /upcategories
  # GET /upcategories.xml
  def index
    @upcategories = Upcategory.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @upcategories }
    end
  end

  # GET /upcategories/1
  # GET /upcategories/1.xml
  def show
    @upcategory = Upcategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @upcategory }
    end
  end

  # GET /upcategories/new
  # GET /upcategories/new.xml
  def new
    @upcategory = Upcategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @upcategory }
    end
  end

  # GET /upcategories/1/edit
  def edit
    @upcategory = Upcategory.find(params[:id])
  end

  # POST /upcategories
  # POST /upcategories.xml
  def create
    @upcategory = Upcategory.new(params[:upcategory])

    respond_to do |format|
      if @upcategory.save
        flash[:notice] = 'Upcategory was successfully created.'
        format.html { redirect_to(@upcategory) }
        format.xml  { render :xml => @upcategory, :status => :created, :location => @upcategory }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @upcategory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /upcategories/1
  # PUT /upcategories/1.xml
  def update
    @upcategory = Upcategory.find(params[:id])

    respond_to do |format|
      if @upcategory.update_attributes(params[:upcategory])
        flash[:notice] = 'Upcategory was successfully updated.'
        format.html { redirect_to(@upcategory) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @upcategory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /upcategories/1
  # DELETE /upcategories/1.xml
  def destroy
    @upcategory = Upcategory.find(params[:id])

    respond_to do |format|
      if @upcategory.categories.nil?
        @upcategory.destroy
        flash[:notice] = 'Upcategory supprimee'
        format.html { redirect_to(upcategories_url) }
        format.xml  { head :ok }
      else
        flash[:error] = 'Upcategory non supprimee car des categories sont associees'
        format.html { redirect_to(upcategories_url) }
        format.xml  { head :ok }
      end
    end
  end
end
