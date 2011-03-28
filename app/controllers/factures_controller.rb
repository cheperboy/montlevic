class FacturesController < ApplicationController

  def modif
    @factures = Facture.find_by_sql("select * from 'factures'")
    @factures.each do |facture|
      facture[:type] = 'Debit'
      logger.info 'modif facture : ' + facture.id
      facture.save!
    end

  end
   
  def toggle_star
    @facture = Facture.find(params[:id])
    if @facture.star != 1
       @facture.star = 1
    else
      @facture.star = 0
    end
    if @facture.save
      render(:layout => false)
    end
  end
  
  def toggle_adu
    @facture = Facture.find(params[:id])
    if @facture.adu != 1
       @facture.adu = 1
    else
      @facture.adu = 0
    end
    if @facture.save
      render(:layout => false)
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
  
  def index
    @factures = Facture.find_by_saison(:all, :order => 'ref DESC')
    respond_to do |format|
      format.html
    end
  end

  def diverses
    @factures = Diverse.find_by_saison(:all, :order => 'ref DESC')
    respond_to do |format|
      format.html { render :action => "index_diverses" }
    end
  end

  def index_types
    @factures = Debit.find_by_saison(:all)
    @reportables = Reportable.find_by_saison(:all)
    @reports = Report.find_by_saison(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @factures }
    end
  end

  def reports
    @saisons = Saison.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @factures }
    end
  end

  # GET /factures/1
  # GET /factures/1.xml
  def show
    @facture = Facture.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @facture }
    end
  end

  # GET /factures/1/edit
  def edit
    @facture = Facture.find(params[:id])
  end

  def new
    @facture ||= Facture.new
    respond_to do |format|
      format.html
    end
  end

  def create
    errors = []
    if params[:reportable] == '1'
      @facture = Reportable.new(params[:facture])
      @facture[:factype_id] = Factype.find_by_name('null').id
    else
      @facture = Debit.new(params[:facture])
    end
#    unless @facture.valid?
#    end
    respond_to do |format|
      if @facture.save
        flash[:notice] = 'Enregistrement facture OK.'
        format.html { redirect_to(factures_url) }
      else
        flash[:error] = 'Facture Invalide :<br>'
        @facture.errors.each do |type, name|
          flash[:error] += '- <b>' + type.to_s + '</b> ' + name.to_s + '<br>'
        end
        @facture = Facture.new(params[:facture])
        format.html { render :action => "new" }
      end
    end
  end

  def new_diverse
    @facture = Facture.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @facture }
    end
  end

  def create_diverse
    errors = []
    user = User.find_by_name('divers')
    params[:facture][:cout] = 0
    @facture = Diverse.new(params[:facture])
    @facture.factype_id = Factype.find_by_name('total').id
    @facture.user_id = user
       
    respond_to do |format|
      if @facture.save
        flash[:notice] = 'Enregistrement report OK.'
        format.html { redirect_to(factures_url) }
      else
        flash[:error] = 'Facture Invalide :<br>'
        @facture.errors.each do |type, name|
          flash[:error] += '- <b>' + type.to_s + '</b> ' + name.to_s + '<br>'
        end
        @facture = Facture.new(params[:facture])
        format.html { render :action => "new_diverse" }
      end
    end
  end

  def new_report
    @facture = Facture.new
    @reportables = Reportable.find(:all)
    if params[:reportable_id]
      @reportable = Reportable.find(params[:reportable_id])
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @facture }
    end
  end

  def create_report
    errors = []
    @reportable = Reportable.find(params[:facture][:reportable_id])
    @report = Report.new(@reportable.attributes.merge({
                    :name => params[:facture][:name],
                    :cout => params[:facture][:cout],
                    :desc => params[:facture][:desc],
                    :star => params[:facture][:star],
                    :adu => params[:facture][:adu],
                    :factype_id => params[:facture][:factype_id],
                    :reportable_id => @reportable.id,
                    :type => 'Report'}))

    respond_to do |format|
      if @report.save
        flash[:notice] = 'Enregistrement report OK.'
        format.html { redirect_to(facture_url(@reportable)) }
      else
          #ajouter les erreurs de validation
          flash[:error] = 'Facture Invalide :<br>'
          @report.errors.each do |type, name|
          flash[:error] += '- <b>' + type.to_s + '</b> ' + name.to_s + '<br>'
        end
        @facture = Facture.new(params[:facture])
        @reportables = Reportable.find(:all)
        format.html { render :action => "new_report" }
      end
    end
  end

  def new_debit_to_reportable
    if params[:debit_id]
      @debit = Debit.find(params[:debit_id])
    end
    @debits = Debit.find(:all)
    @facture = Facture.new
    respond_to do |format|
      format.html
    end
  end

  def create_debit_to_reportable
    @new_report = Debit.find(params[:debit][:id])

    @reportable = Reportable.new(@new_report.attributes.merge({
                    :factype_id => Factype.find_by_name('null').id,
                    :type => 'Reportable'}))
    
    if @reportable.save
      @new_report[:type] = 'Report'
      @new_report[:reportable_id] = @reportable.id
      @new_report[:factype_id] = params[:facture][:factype_id]
      @new_report[:name] = params[:facture][:name]
      @new_report[:cout] = params[:facture][:cout]

      respond_to do |format|
        if @new_report.save
          flash[:notice] = 'Facture (Debit) transformee en Report, OK'
          format.html { redirect_to(facture_url(@reportable)) }
        else
          flash[:error] = 'Probleme : Facture (Debit) en Report'
          format.html { render :action => "reports" }
        end
      end
    end
  end

  def update
    @facture = Facture.find(params[:id])
    param_type = @facture.class.to_s.downcase.to_sym
    respond_to do |format|
      if @facture.update_attributes(params[param_type])
        if @facture.class.equal?(Report)
          flash[:notice] = 'Modification du Report "' + @facture.name + '" OK.'
          format.html { redirect_to(facture_url(@facture.reportable)) }
        else
          flash[:notice] = 'Modification de la facture (' + @facture.class.to_s + ') "' + @facture.name + '" OK.'
          format.html { render :action => "show" }
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @facture.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @facture = Facture.find(params[:id])
    if @facture.class == Reportable && @facture.reports.count != 0
      flash[:error] = 'Facture Reportable avec reports : Non Supprimee'
    elsif @facture.class == Diverse && @facture.facdivs.count != 0
      flash[:error] = 'Facture Diverse avec facdivs : Non Supprimee'
    else
      @facture.destroy
      flash[:notice] = 'Facture Supprimee'
    end

    respond_to do |format|
      if @facture.class.equal?(Report)
        flash[:notice] = 'Suppression du Report "' + @facture.name + '" OK.'
        format.html { redirect_to(facture_url(@facture.reportable)) }
      else
        format.html { redirect_to(factures_url) }
        format.xml  { head :ok }
      end
    end
  end
end
