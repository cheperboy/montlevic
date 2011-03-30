class SettingsController < ApplicationController

  def update
    @setting = Setting.find(params[:id])

    respond_to do |format|
      if @setting.update_attributes(params[:setting])

        session[:current_saison_id] = Setting.find(:first).saison_id
        current_saison_id = Setting.find(:first).saison_id

        flash[:notice] = 'Options mises a jour.'
        format.html { redirect_to :action => "edit", :id => Setting.find(:first).id }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @setting.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_saison
    @setting = Setting.find(:first)
    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        @setting.reload
        
        # Update Session variable
#        current_saison_id = Setting.find(:first).saison.id
#        session[:saison_name] = Setting.find(:first).saison.name
        session[:current_saison_id] = Setting.find(:first).saison_id

        flash[:notice] = 'Saison was successfully updated.'
        format.html { redirect_to(:controller => params[:from][:controller],
                                  :action => params[:from][:action] ) }
        format.js { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { head :unprocessable_entity }
      end
    end
  end

  def index
    respond_to do |format|
      format.html { redirect_to :action => "edit", :id => Setting.find(:first).id}
    end
  end

  # GET /settings/1/edit
  def edit
    @setting = Setting.find(:first)
  end

  # POST /settings
  # POST /settings.xml
  def create
    @setting = Setting.new(params[:setting])

    respond_to do |format|
      if @setting.save
        flash[:notice] = 'Setting was successfully created.'
        format.html { redirect_to(@setting) }
        format.xml  { render :xml => @setting, :status => :created, :location => @setting }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @setting.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @setting = Setting.find(params[:id])
    @setting.destroy

    respond_to do |format|
      format.html { redirect_to(settings_url) }
      format.xml  { head :ok }
    end
  end
  def show
    @setting = Setting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @setting }
    end
  end

  # GET /settings/new
  # GET /settings/new.xml
  def new
    @setting = Setting.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @setting }
    end
  end
end
