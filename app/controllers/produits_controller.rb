class ProduitsController < ApplicationController

  def modif
    @produits = Produit.find_by_sql("select * from 'produits'")
    @produits.each do |produit|
      produit[:type] = 'Debit'
      logger.info 'modif produit : ' + produit.id
      produit.save!
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
    @produits = Produit.find_by_saison(:all, :order => 'category_id DESC')
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

    # #Ne pas supprimer un produit Reportable avec des reports
    # if (@produit.class == Reportable && (@produit.charges? || @produit.reports.count != 0))
    #   flash[:error] = 'Produit Reportable avec reports ou associations : Non Supprimee'
    # 
    # #Ne pas supprimer une produit Diverse comportant des fiches
    # elsif @produit.class == Diverse && @produit.facdivs.count != 0
    #   flash[:error] = 'Produit Diverse avec facdivs : Non Supprimee'
    # 
    # #Ne pas supprimer une produit Report comportant des associations
    # elsif (@produit.class == Report && @produit.charges?)
    #   flash[:error] = 'Produit Report avec associations : Non Supprimee'
    # 
    # #Ne pas supprimer une produit Debit comportant des associations
    #  elsif @produit.class == Debit && @produit.charges?
    #     flash[:error] = 'Produit avec association (Vente, Labour ou Pulve) : Non Supprimee'
    # 
    #  else
        @produit.destroy
        flash[:notice] = 'Produit Supprime'
      # end

    respond_to do |format|
      format.html { redirect_to(produits_url) }
      format.xml  { head :ok }
    end
  end
end
