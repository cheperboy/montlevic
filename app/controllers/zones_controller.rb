class ZonesController < ApplicationController
  before_filter :edit_access,
                :only => [:update, :destroy]
  def index
    @zones = Zone.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @zones }
    end
  end

  def show
    @zones = Zone.all
    @zone = Zone.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @zone }
    end
  end

  def new
    @zones = Zone.all
    @zone = Zone.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @zone }
    end
  end

  def edit
    @zones = Zone.all
    @zone = Zone.find(params[:id])
  end

  def create
    @zones = Zone.all
    @zone = Zone.new(params[:zone])

    respond_to do |format|
      if @zone.save
        flash[:notice] = 'Zone was successfully created.'
        format.html { redirect_to(zones_url) }
        format.xml  { render :xml => @zone, :status => :created, :location => @zone }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @zone.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @zones = Zone.all
    @zone = Zone.find(params[:id])

    respond_to do |format|
      if @zone.update_attributes(params[:zone])
        flash[:notice] = 'Zone was successfully updated.'
        format.html { redirect_to(zones_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @zone.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @zone = Zone.find(params[:id])
    @zone.destroy

    respond_to do |format|
      format.html { redirect_to(zones_url) }
      format.xml  { head :ok }
    end
  end
end
