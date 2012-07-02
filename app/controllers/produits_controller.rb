class ProduitsController < ApplicationController
  before_filter :edit_access,
                :only => [:update, :destroy]
                
  def modif
    @produits = Produit.find_all
    @produits.each do |produit|
      if produit.get_quantite < produit.get_quantite_used
        logger.info 'modif produit : ' + produit.id
        produit.update_attribute(:quantite, produit.get_quantite_used)
        produit.save!
      end
    end
  end
   
  def modif_star_adu
    @produits = Produit.find_all
    @produits.each do |produit|
      produit.star = 0
      produit.adu = 0
      produit.save!
    end
  end
     
  def index
    @produits_all =         Produit.find_by_saison(:all, :order => :category_id) #uniquement pour xml, pas html
    @produits_used =        Produit.find_used(:all, :order => :category_id)
    @produits_non_achetes = Produit.find_not_buy(:all, :order => :category_id)
    @produits_not_used =    Produit.find_not_used(:all, :order => :category_id)

    if params[:tri]
      @produits_used = Produit.find_used(:all, :order => "#{params[:tri].to_s} #{params[:sens]}") 
    end
    respond_to do |format|
      format.html
      format.xls { redirect_to(:action => :export) }
      format.xml {}
    end
  end
 
  # GET /produits/1
  # GET /produits/1.xml
  def show
    @produit = Produit.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @produit }
    end
  end

  # GET /produits/1/edit
  def edit
    @produit = Produit.find(params[:id])
  end

  def new
    @produit ||= Produit.new
    respond_to do |format|
      format.html
    end
  end

  def create
    errors = []
    @produit = Produit.new(params[:produit])
    @produit.saison_id = current_saison_id
    @produit.name.downcase!  
    
    if @produit.code.blank?
      @produit.code = @produit.name.gsub(/\s/, "_")
    else
      @produit.code.downcase! 
      @produit.code.gsub!(/\s/, "_")
    end
    
    respond_to do |format|
      if @produit.save
        @produit.protofactures.each do |protofacture|
          protofacture.saison_id = current_saison_id
          protofacture.save!
        end  
        flash[:notice] = 'Enregistrement produit OK.'
        format.html { redirect_to(produit_url(@produit)) }
      else
        add_errors_to_model(@produit.errors)
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @produit = Produit.find(params[:id])
    @produit.name.downcase!  
    @produit.code = @produit.name.gsub(/\s/, "_")
    respond_to do |format|
      if @produit.update_attributes(params[:produit])
        flash[:notice] = 'Modification du produit ok'
        format.html { redirect_to(produit_url(@produit)) }
      else
        add_errors_to_model(@produit.errors)
        format.html { render :action => "edit" }
        format.xml  { render :xml => @produit.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @produit = Produit.find(params[:id])
    
    #Ne pas supprimer un produit utilise par un pulve
    if (@produit.pulves.count != 0)
      flash[:error] = 'Produit associe a un pulve : Non Supprimee'
     else
        @produit.destroy
        flash[:notice] = 'Produit Supprime'
     end

    respond_to do |format|
      format.html { redirect_to(produits_url) }
      format.xml  { head :ok }
    end
  end
  
  def update_star
    logger.error "params : #{params.inspect}"
    star = 0
    if params[:element][:star].eql?("true")
      star = 1
    end
    params[:element][:star] = star
    @element = Produit.find(params[:id])
    respond_to do |format| 
      if @element.update_attributes(params[:element])
        format.html { redirect_to(@element) }
        format.js	{ head :ok } 
      else
        flash[:error] = 'probleme mise a jour Star ou Adu'
        format.html { render :action => "edit" } 
        format.js	{ head :unprocessable_entity }
      end 
    end
  end

  def update_adu
    logger.error "params : #{params.inspect}"
    adu = 0
    if params[:element][:adu].eql?("true")
      adu = 1
    end
    params[:element][:adu] = adu
    @element = Produit.find(params[:id])
    respond_to do |format| 
      if @element.update_attributes(params[:element])
        format.html { redirect_to(@element) }
        format.js	{ head :ok } 
      else
        flash[:error] = 'probleme mise a jour Star ou Adu'
        format.html { render :action => "edit" } 
        format.js	{ head :unprocessable_entity }
      end 
    end
  end

  def export
    file = Produit.export_by_saison()
    send_data file.string, :filename => "Produits.xls", :type =>  "application/vnd.ms-excel"    
  end
  
end
