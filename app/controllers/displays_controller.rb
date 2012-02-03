class DisplaysController < ApplicationController
  # GET /displays
  # GET /displays.xml
  def index
    @displays = Display.find(:all)

#BEGIN
    @parcelles = Parcelle.find(:all, :order => "typeculture_id")
    @labours = Labour.find(:all)
    @pulves = Pulve.find(:all)
    @factures = Facture.find(:all, :order => "category_id")
    @types = Category.find_all_by_upcategory_id(Upcategory.find_by_name('facture'))
    
  #Init Hparcelles 
    @Hparcelles = {}
    for parcelle in @parcelles
      @Hparcelles[parcelle.id] = {}
      @Hparcelles[parcelle.id] = {:pulves => {}, :labours => {}, :factures => {}, :total => {} }
      @Hparcelles[parcelle.id][:factures][:cout_ha] = {}
      @Hparcelles[parcelle.id][:factures][:cout_total] = {}
      @Hparcelles[parcelle.id][:labours][:cout_ha] = 0
      @Hparcelles[parcelle.id][:labours][:cout_total] = 0
      @Hparcelles[parcelle.id][:pulves][:cout_ha] = 0
      @Hparcelles[parcelle.id][:pulves][:cout_total] = 0
      @Hparcelles[parcelle.id][:total][:cout_ha] = {}
      @Hparcelles[parcelle.id][:total][:cout_total] = {}
      
      @Hparcelles[parcelle.id][:factures][:cout_total][:sum_total] = 0  
      @Hparcelles[parcelle.id][:factures][:cout_ha][:sum_ha] = 0  
      @Hparcelles[parcelle.id][:total][:cout_total][:sum_total] = 0  
      @Hparcelles[parcelle.id][:total][:cout_ha][:sum_ha] = 0  

      for type in @types
        @Hparcelles[parcelle.id][:factures][:cout_total][type.name] = 0  
        @Hparcelles[parcelle.id][:factures][:cout_ha][type.name] = 0  
        @Hparcelles[parcelle.id][:total][type.name] = {}
        @Hparcelles[parcelle.id][:total][type.name] = {}
      end
    end
#END

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @displays }
    end
  end

  # GET /displays/1
  # GET /displays/1.xml
  def show
    @display = Display.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @display }
    end
  end

  # GET /displays/new
  # GET /displays/new.xml
  def new
    @display = Display.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @display }
    end
  end

  # GET /displays/1/edit
  def edit
    @display = Display.find(params[:id])
  end

  # POST /displays
  # POST /displays.xml
  def create
    @display = Display.new(params[:display])

    respond_to do |format|
      if @display.save
        flash[:notice] = 'Display was successfully created.'
        format.html { redirect_to(@display) }
        format.xml  { render :xml => @display, :status => :created, :location => @display }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @display.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /displays/1
  # PUT /displays/1.xml
  def update
    @display = Display.find(params[:id])

    respond_to do |format|
      if @display.update_attributes(params[:display])
        flash[:notice] = 'Display mis a jour!.'
        format.html { redirect_to(@display) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @display.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /displays/1
  # DELETE /displays/1.xml
  def destroy
    @display = Display.find(params[:id])
    @display.destroy

    respond_to do |format|
      format.html { redirect_to(displays_url) }
      format.xml  { head :ok }
    end
  end
end
