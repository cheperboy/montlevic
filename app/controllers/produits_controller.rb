class ProduitsController < ApplicationController

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
   
  def toggle_star
    @produit = Produit.find(params[:id])
    if @produit.star != 1
       @produit.star = 1
    else
      @produit.star = 0
    end
    if @produit.save
      render(:layout => false)
    end
  end
  
  def toggle_adu
    @produit = Produit.find(params[:id])
    if @produit.adu != 1
       @produit.adu = 1
    else
      @produit.adu = 0
    end
    if @produit.save
      render(:layout => false)
    end
  end

  def index
    @produits = Produit.find_by_saison(:all, :order => "#{params[:tri].to_s} #{params[:sens]}") 
    # @produits.each do |produit|
    #   if produit.stock_vs_used?
    #     produit.protofactures.first.quantite = produit.get_used_quantite
    #     produit.save
    #   end
    # end
    respond_to do |format|
      format.html
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
    respond_to do |format|
      if @produit.save
        @produit.protofactures.each do |protofacture|
          protofacture.saison_id = current_saison_id
          protofacture.save!
        end  
        flash[:notice] = 'Enregistrement produit OK.'
        format.html { redirect_to(produits_url) }
      else
        add_errors_to_model(@produit.errors)
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @produit = Produit.find(params[:id])
    respond_to do |format|
      if @produit.update_attributes(params[:produit])
        flash[:notice] = 'Modification du produit ok'
        format.html { redirect_to(produits_url) }
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
end
