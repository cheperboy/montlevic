class ChargesController < ApplicationController
  
  def modif
    @facture = Charge.find(:all)
    @facture.each do |facture|
      facture.type = 'Debit'
      facture.save
    end   
  end
     
  def toggle_star
    @facture = Charge.find(params[:id])
    if @facture.star != 1
       @facture.star = 1
    else
      @facture.star = 0
    end
    if @facture.save
      render :partial => "list", :layout => false
    else
      render(:layout => false)
    end
  end
  
  def toggle_adu
    @facture = Charge.find(params[:id])
    if @facture.adu != 1
       @facture.adu = 1
    else
      @facture.adu = 0
    end
    if @facture.save
      render(:layout => false)
    end
  end

  def index
    @factures = Charge.find(:all)
#    @papiers  = Debit.find_papier(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @factures }
    end
  end

  def liste
    options = nil
    unless params[:order].nil?
      order = params[:order]
    end
    @factures = Facture.find_not_papier(:all, :order => order)
    @papiers  = Facture.find_papier(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @factures }
    end
  end

  # GET /factures/1
  # GET /factures/1.xml
  def show
    @facture = Charge.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @facture }
    end
  end

  # GET /factures/new
  # GET /factures/new.xml
  def new
    @facture = Charge.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @facture }
    end
  end

  # GET /factures/1/edit
  def edit
    @facture = Charge.find(params[:id])
  end

  # POST /factures
  # POST /factures.xml
  def create
    if params[:facture][:report] == 1
      @facture = Reportable.new(params[:facture])
    else
      @facture = Facture.new(params[:facture])
    end
#    elsif params[:type] == Report.to_s
#      @facture = Report.new(params[:facture])
#    else
#      flash[:error] = 'Erreur [params[:type] not good!] Appeler Matthieu !'
#    end
#    @facture = Debit.new(params[:facture])
    @facture.saison_id = Application::SAISON
    respond_to do |format|
      if @facture.save
        flash[:notice] = 'Enregistrement facture OK.'
        format.html { redirect_to(factures_url) }
        format.xml  { render :xml => @facture, :status => :created, :location => @facture }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @facture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /factures/1
  # PUT /factures/1.xml
  def update
    @facture = Charge.find(params[:id])

    respond_to do |format|
      if @facture.update_attributes(params[:facture])
        flash[:notice] = 'Modification facture OK.'
        format.html { redirect_to(factures_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @facture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /factures/1
  # DELETE /factures/1.xml
  def destroy
    @facture = Charge.find(params[:id])
    @facture.destroy

    respond_to do |format|
      format.html { redirect_to(factures_url) }
      format.xml  { head :ok }
    end
  end

  def list
    space = ' '
    order = params[:order] unless params[:order].nil?

    search = {:n => 1}
    search = {1 => {}}
    search = {1 => {:key => 'saison_id', :value => Application::SAISON, :sign => 'LIKE'}}
    
    #conditions = ["saison_id=#{Application::SAISON}"]
    conditions = ''
    search[:n]
    search.each do |col, opt|
      condition += opt[:key] + space + opt[:sign] + space + '?, '         
    end
    search.each do |col, opt|
      condition += opt[:key] + space + opt[:sign] + space + '?, '         
    end
    
    @elements = Facture.find(:all, :order => order, :conditions => conditions)
    
    unless params[:name].nil?
      conditions = ["name LIKE %#{params[:name]}%"]
      @f = @f.find( :conditions => conditions)
    end
    
    unless params[:ref].nil?
#      conditions = ["name LIKE ?", "%#{params[:name]}%"]
    end
    @elements = @f
    
#    (1..Facture::COLS_COUNT).each do |col|
#      colonne = Facture::COLS_NAME[col]
##      unless Facture::COLS_LINK[col] == 'false'
#       
#       logger.debug '-> COLONNE=' + col.to_s
#       logger.debug '-> COLNAME=' + colonne.to_s
#       unless col == 10
#        unless params[colonne.to_sym].nil?
#          logger.debug 'COLONNE=' + col.to_s
#          conditions += ["#{colonne} LIKE ?", "%#{params[colonne.to_sym]}%"]
#        end
#      end
#    end
    
    #@elements = Facture.find(:all, :order => order, :conditions => conditions)
    if request.xml_http_request?
      render :partial => "list", :layout => false
    else
      render :partial => "list", :layout => false
    end
  end
  

end
