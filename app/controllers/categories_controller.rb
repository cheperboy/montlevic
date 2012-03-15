class CategoriesController < ApplicationController
  before_filter :edit_access,
                :only => [:update, :destroy]

  # GET /categories
  # GET /categories.xml
  
  def test
    # respond_to do |format|
    #   format.haml
    # end
  end
  
  def index
    @categories = Category.find(:all, :order => :upcategory_id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.xml
  def create
    params[:category][:factcat_id] = 11
    params[:category][:upcategory_id] = 11
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        flash[:notice] = 'Category was successfully created.'
        format.html { redirect_to(categories_url) }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category mis a jour!.'
        format.html { redirect_to(categories_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    if admin?
      @category = Category.find(params[:id])
      @category.destroy
  
      respond_to do |format|
        format.html { redirect_to(categories_url) }
        format.xml  { head :ok }
      end
    else
      respond_to do |format|
        flash[:error] = 'Admin Only'      
        format.html { redirect_to(categories_url) }
      end
    end
  end
end
