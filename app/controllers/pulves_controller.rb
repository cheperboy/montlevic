class PulvesController < ApplicationController
  # GET /pulves
  # GET /pulves.xml
  def index
 #   @pulves = Pulve.find_by_saison(:all)
# TODO onglet verif saisie donnees : verifier que les pulves qui ont un prix/L sont lies a une facture

    # @pulves = Pulve.find_by_saison(:all, :order => :id) do
    #   saison = Setting.find(:first).saison_id
    #   name.contains? params[:filter][:name] if params[:filter] && params[:filter][:name]
    #   # category.name.contains? 'i'
    #   star == 1 if ((params[:filter]) && (params[:filter][:star]))
    #   adu == 1  if params[:filter] && params[:filter][:adu]
    # end
    @pulves = Pulve.find_with_saison(:all, :order => :id) 
    if params[:tri]
      @pulves = Pulve.find_with_saison(:all, :order => params[:tri].to_sym) 
    end
    respond_to do |format|
      format.html
    end
  end

  def export
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="report.xls"'
    headers['Cache-Control'] = ''
    @pulves = Pulve.find_by_saison(:all)
    render :layout => false
  end

  # GET /pulves/1
  # GET /pulves/1.xml
  def show
    @pulve = Pulve.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pulve }
    end
  end

  # GET /pulves/new
  # GET /pulves/new.xml
  def new
    @pulve = Pulve.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pulve }
    end
  end

  # GET /pulves/1/edit
  def edit
    @pulve = Pulve.find(params[:id])
  end

  # POST /pulves
  # POST /pulves.xml
  def create
    @pulve = Pulve.new(params[:pulve])
    @pulve.saison_id = current_saison_id

    respond_to do |format|
      if @pulve.save
        flash[:notice] = 'Pulve ajoute'
        format.html { redirect_to(@pulve) }
        format.xml  { render :xml => @pulve, :status => :created, :location => @pulve }
      else
        add_errors_to_model(@pulve.errors)
        @pulve = Pulve.new(params[:pulve])
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /pulves/1
  # PUT /pulves/1.xml
  def update
    @pulve = Pulve.find(params[:id])

    respond_to do |format|
      if @pulve.update_attributes(params[:pulve])
        flash[:notice] = 'Pulve mis a jour.'
        format.html { redirect_to(@pulve) }
        format.xml  { head :ok }
      else
        add_errors_to_model(@pulve.errors)
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pulve.errors, :status => :unprocessable_entity }
      end
    end
  end

  def actualize
    @pulve = Pulve.find(params[:id])

    respond_to do |format|
      if @pulve.update_attributes(params[:pulve])
        flash[:notice] = 'Pulve was successfully updated.'
        format.html { redirect_to(@pulve) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pulve.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pulves/1
  # DELETE /pulves/1.xml
  def destroy
    @pulve = Pulve.find(params[:id])
    @pulve.destroy

    respond_to do |format|
      format.html { redirect_to(pulves_url) }
      format.xml  { head :ok }
    end
  end
  def toggle_star
    @obj = Pulve.find(params[:id])
    if @obj.star != 1
       @obj.star = 1
    else
      @obj.star = 0
    end
    if @obj.save
      render(:layout => false)
    end
  end  
  
  def toggle_adu
    @obj = Pulve.find(params[:id])
    if @obj.adu != 1
       @obj.adu = 1
    else
      @obj.adu = 0
    end
    if @obj.save
      render(:layout => false)
    end
  end  
end
