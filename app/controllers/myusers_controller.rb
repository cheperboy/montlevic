class MyusersController < ApplicationController
  before_filter :admin_access

  # GET /myusers
  # GET /myusers.xml
  def index
    @myusers = Myuser.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @myusers }
    end
  end

  # GET /myusers/1
  # GET /myusers/1.xml
  def show
    @myuser = Myuser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @myuser }
    end
  end

  # GET /myusers/new
  # GET /myusers/new.xml
  def new
    @myuser = Myuser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @myuser }
    end
  end

  # GET /myusers/1/edit
  def edit
    @myuser = Myuser.find(params[:id])
  end

  # POST /myusers
  # POST /myusers.xml
  def create
    @myuser = Myuser.new(params[:myuser])

    respond_to do |format|
      if @myuser.save
        flash[:notice] = 'Myuser was successfully created.'
        format.html { redirect_to(@myuser) }
        format.xml  { render :xml => @myuser, :status => :created, :location => @myuser }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @myuser.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /myusers/1
  # PUT /myusers/1.xml
  def update
    @myuser = Myuser.find(params[:id])

    respond_to do |format|
      if @myuser.update_attributes(params[:myuser])
        flash[:notice] = 'Myuser was successfully updated.'
        format.html { redirect_to(@myuser) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @myuser.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /myusers/1
  # DELETE /myusers/1.xml
  def destroy
    @myuser = Myuser.find(params[:id])
    @myuser.destroy

    respond_to do |format|
      format.html { redirect_to(myusers_url) }
      format.xml  { head :ok }
    end
  end
end
