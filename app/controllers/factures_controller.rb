class FacturesController < ApplicationController
  before_filter :edit_access,
                :only => [:update, :destroy, :create_debit_to_reportable]


  def index
    @factures = Facture.find_by_saison(:all) 
    # if params[:tri]
    #   @factures = Facture.find_by_saison(:all, :order => "#{params[:tri].to_s} #{params[:sens]}") 
    #   @tri = params[:tri]
    #   @sens = params[:sens]
    # end
    respond_to do |format|
      format.html
    end
  end

  def index_paye
    @factures = Facture.find_real_by_saison(:all, :order => :id) 
    if params[:tri]
      @factures = Facture.find_real_by_saison(:all, :order => "#{params[:tri].to_s} #{params[:sens]}") 
      @tri = params[:tri]
      @sens = params[:sens]
    end
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

  def show
    @facture = Facture.find(params[:id])
    @show = {}
    @show[:used] = false
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @facture }
    end
  end

  def edit
    @facture = Facture.find(params[:id])
  end

  def new
    @facture ||= Facture.new
    @categories = Category.for_factures
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
    @facture.saison_id = current_saison_id
    @facture.factcat_id = Category.find(params[:facture][:category_id]).factcat_id
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
    params[:facture][:cout] = 0
    @facture = Diverse.new(params[:facture])
       
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

  def update_star
    star = 0
    if params[:facture][:star].eql?("true")
      star = 1
    end
    params[:facture][:star] = star
    @facture = Facture.find(params[:id])
    respond_to do |format| 
      if @facture.update_attributes(params[:facture])
        format.html { redirect_to(@facture) }
        format.js	{ head :ok } 
      else
        flash[:error] = 'probleme mise a jour Star ou Adu'
        format.html { render :action => "edit" } 
        format.js	{ head :unprocessable_entity }
      end 
    end
  end

  def update_adu
    adu = 0
    if params[:facture][:adu].eql?("true")
      adu = 1
    end
    params[:facture][:adu] = adu
    @facture = Facture.find(params[:id])
    respond_to do |format| 
      if @facture.update_attributes(params[:facture])
        format.html { redirect_to(@facture) }
        format.js	{ head :ok } 
      else
        flash[:error] = 'probleme mise a jour Star ou Adu'
        format.html { render :action => "edit" } 
        format.js	{ head :unprocessable_entity }
      end 
    end
  end

  def update
    @facture = Facture.find(params[:id])  
    param_type = @facture.class.to_s.downcase.to_sym
    respond_to do |format|
      if @facture.update_attributes(params[param_type])
        # extract factcat from category and save it
        @facture.update_factcat
        # @facture.factcat_id = Category.get_factcat(params[param_type][:category_id]).id
        logger.error "Category.find(params[param_type][:category_id]).factcat_id : #{Category.find(params[param_type][:category_id]).factcat_id}"
        logger.error "Category.find(31).factcat_id #{Category.find(31).factcat_id}"
        logger.error "@facture.factcat_id #{@facture.factcat_id}"
        
        # transforme les checkbox Typeculture en Factoparcelles
        @facture.update_typecultures(params[:typecultures])
        @facture.uniq_parcelles
        if @facture.class.equal?(Report)
          flash[:notice] = 'Modification du Report "' + @facture.name + '" OK.'
          format.html { redirect_to(facture_url(@facture.reportable)) }
        else
          flash[:notice] = 'Modification de la facture (' + @facture.class.to_s + ') "' + @facture.name + '" OK.'
          format.html { redirect_to(facture_url(@facture)) }
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @facture.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @facture = Facture.find(params[:id])

    #Ne pas supprimer une facture Reportable avec des reports
    if (@facture.class == Reportable && (@facture.charges? || @facture.reports.count != 0))
      flash[:error] = 'Facture Reportable avec reports ou associations : Non Supprimee'

    #Ne pas supprimer une facture Diverse comportant des fiches
    elsif @facture.class == Diverse && @facture.facdivs.count != 0
      flash[:error] = 'Facture Diverse avec facdivs : Non Supprimee'

    #Ne pas supprimer une facture Report comportant des associations
    elsif (@facture.class == Report && @facture.charges?)
      flash[:error] = 'Facture Report avec associations : Non Supprimee'

    #Ne pas supprimer une facture Debit comportant des associations
     elsif @facture.class == Debit && @facture.charges?
        flash[:error] = 'Facture avec association (Vente, Labour ou Pulve) : Non Supprimee'

     else
        @facture.destroy
        flash[:notice] = 'Facture Supprimee'
      end

    respond_to do |format|
      if @facture.class.equal?(Report)
        format.html { redirect_to(facture_url(@facture.reportable)) }
      else
        format.html { redirect_to(factures_url) }
        format.xml  { head :ok }
      end
    end
  end
end
