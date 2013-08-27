class FacturesController < ApplicationController
  before_filter :edit_access,
                :only => [:update, :update_multiple, :destroy, :create_debit_to_reportable]

  skip_before_filter :login_required, :only => [:by_saison, :export_analytic] # for raw data acces

  def by_saison
    @saison = Saison.find_by_year(params[:id])
    respond_to do |format|
      format.xml
    end
  end

  def export_analytic
    @saison = Saison.find_by_year(params[:id])
    @sum = Facture.synthese_by_cat(@saison)
    respond_to do |format|
      format.html
      format.xml
    end
  end
  
  def index
    # @factures = Facture.find_by_saison(:all, :limit => 10 )
    # @factures = Facture.find_by_saison(:all, :order => "id DESC")
    # @factures = Facture.find_by_saison(:all)
    @factures = Facture.all(:all, 
                            :conditions => ["saison_id = ?", current_saison_id],
                            :order => "id DESC"
                            # :limit => 10
                            )
  
    # if params[:tri]
    #   @factures = Facture.find_by_saison(:all, :order => "#{params[:tri].to_s} #{params[:sens]}") 
    #   @tri = params[:tri]
    #   @sens = params[:sens]
    # end
    respond_to do |format|
      format.html
      format.xml  { render :xml => @factures }
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
    unless @facture.saison_id.eql?(current_saison_id)
      respond_to do |format| 
        format.html { redirect_to(@facture) }
        flash[:error] = 'la campagne de traval est differente de la campagne de cette facture!'    
      end
    end
  end

  def index_multiple
    @factures = Facture.find_by_saison(:all)
    respond_to do |format|
      format.html
    end
  end

  def new
    @facture ||= Facture.new
    # @categories = Category.for_factures
    respond_to do |format|
      format.html
    end
  end

  def create
    errors = []
    # ce cas est-il utilise? semble obsolete.
    if params[:reportable] == '1'
      @facture = Reportable.new(params[:facture])
      @facture[:factype_id] = Factype.find_by_name('null').id
    # si la categorie choisie est un Investissement
    elsif Category.find(params[:facture][:category_id]).is_invest?
      @facture = Invest.new(params[:facture])
      # param factype inutil pour Invest, par defaut a 'total'
      @facture[:factype_id] = Factype.find_by_name('total').id
    else
      @facture = Debit.new(params[:facture])
    end
    @facture.saison_id = current_saison_id
    # 12/03/13 suppression car Factcat obsolete
    # @facture.factcat_id = Category.find(params[:facture][:category_id]).factcat_id
    
    # transforme les checkbox Typeculture en Factoparcelles
    @facture.update_typecultures(params[:typecultures]) unless @facture.category.is_invest?

    #2012/12/16 ajout de reload pour que l'appel a uniq_parcelles fonctionne !
    #2013/06 bug avec reload : deplace dans respond_to do |format|
    respond_to do |format|
      if @facture.save
        @facture.reload()
        @facture.uniq_parcelles unless @facture.category.is_invest?
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
    t = Time.now
    time = "#{t.hour}:#{t.min}:#{t.sec}"
    puts "Update star : #{time}"
    puts params.inspect
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
    puts "params : #{params.inspect}"
    @facture = Facture.find(params[:id])  
    param_type = @facture.class.to_s.downcase.to_sym
    respond_to do |format|
      if @facture.update_attributes(params[param_type])
        
        # 12/03/13 suppression car Factcat obsolete
          # extract factcat from category and save it
          # @facture.update_factcat
        
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

  def update_multiple
    @facture = Facture.find(params[:id])
    klass = @facture.class.to_s.downcase
    puts "klass #{klass}"
    if @facture.update_attribute(:category_id, params["#{klass}"][:category_id])
      @facture.save!
      flash.now[:error] = 'TEST'
    end

    # param_type = @facture.class.to_s.downcase.to_sym
    # respond_to do |format|
    #   if @facture.update_attributes(params[param_type])
    #     
    #     # 12/03/13 suppression car Factcat obsolete
    #       # extract factcat from category and save it
    #       # @facture.update_factcat
    #     
    #     # transforme les checkbox Typeculture en Factoparcelles
    #     @facture.update_typecultures(params[:typecultures])
    #     @facture.uniq_parcelles
    #     if @facture.class.equal?(Report)
    #       flash[:notice] = 'Modification du Report "' + @facture.name + '" OK.'
    #       format.html { redirect_to(facture_url(@facture.reportable)) }
    #     else
    #       flash[:notice] = 'Modification de la facture (' + @facture.class.to_s + ') "' + @facture.name + '" OK.'
    #       format.html { redirect_to(facture_url(@facture)) }
    #     end
    #   else
    #     format.html { render :action => "edit" }
    #     format.xml  { render :xml => @facture.errors, :status => :unprocessable_entity }
    #   end
    # end
  end

  def export2
    # send_file user.avatar.path, :type => user.avatar_content_type
    @factures = Facture.find_by_saison(:all)
    name = "factures_#{current_saison_id}"
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = "attachment; filename='#{name}.xls'"
    headers['Cache-Control'] = ''
    render(:layout=>false)
  end
  
  def export
    # book = Spreadsheet::Workbook.new
    # sheet1 = book.create_worksheet
    # sheet1.name = 'Factures'
    # sheet1.row(0).height = 18
    # 
    # @factures = Facture.find_by_saison(:all)
    # i=1
    # @factures.each do |f|
    #   sheet1.row(i).push [f.id, f.name, f.category.name]
    # end
    # 
    # # name = "factures_#{current_saison_id}"
    # # headers['Content-Type'] = "application/vnd.ms-excel"
    # # headers['Content-Disposition'] = "attachment; filename='#{name}.xls'"
    # # headers['Cache-Control'] = ''
    # book.write '/file_factures.xls'
    # send_data spreadsheet.string, :filename => "yourfile.xls", :type =>  "application/vnd.ms-excel"
    # send_file file#, :type => "application/vnd.ms-excel"
    year = Saison.find(current_saison_id).year
    filename = "factures_#{year}.xls"
    file = Facture.export_by_saison()
    send_data file.string, :filename => filename, :type =>  "application/vnd.ms-excel"    

    # render(:layout=>false)
  end
  
  def export_invest
    file = Invest.export()
    send_data file.string, :filename => "Investissements.xls", :type =>  "application/vnd.ms-excel"    
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
