class VerifsController < ApplicationController

  def index
    #partie Verif de bug
    @verif = Verif.new
    @verif.run_test
    # 
    # #partie verif des saisies a faire (coherence Facture/Pulves par exemple)
    # @saisie = Saisie.new
    # @saisie.run_test
    # 
    respond_to do |format|
      format.html
    end
  end
  
  def list_factoparcelles
    @factoparcelles = Factoparcelle.find(:all)  
    respond_to do |format|
      format.html
    end
  end
  
  def delete_factoparcelle
    factoparcelle = Factoparcelle.find(params[:id])  
    if session[:admin]
      if factoparcelle.facture.nil? || factoparcelle.parcelle.nil?
        factoparcelle.destroy
        flash[:notice] = 'Putoparcelle will be deleted'   
      else
        flash[:error] = 'no need to delete this factoparcelle'
      end
    else
      flash[:error] = 'not deleted, Admin only!'
    end        
    respond_to do |format|
      format.html { redirect_to :action => "list_factoparcelles" }
    end
  end
  
  def list_labtofactures
    @labtofactures = Labtofacture.find(:all)  
    respond_to do |format|
      format.html
    end
  end
  
  def delete_labtofacture
    labtofacture = Labtofacture.find(params[:id])  
    if session[:admin]
      if labtofacture.labour.nil? || labtofacture.facture.nil?
        labtofacture.destroy
        flash[:notice] = 'Labtofacture will be deleted'   
      else
        flash[:error] = 'no need to delete this labtofacture'
      end
    else
      flash[:error] = 'not deleted, Admin only!'
    end 
    respond_to do |format|
      format.html { redirect_to :action => "list_labtofactures" }
    end
  end
  
  def list_labtoparcelles
    @labtoparcelles = Labtoparcelle.find(:all)  
    respond_to do |format|
      format.html
    end
  end
  
  def delete_labtoparcelle
    labtoparcelle = Labtoparcelle.find(params[:id])  
    if session[:admin]
      if labtoparcelle.labour.nil? || labtoparcelle.parcelle.nil?
        labtoparcelle.destroy
        flash[:notice] = 'Labtoparcelle will be deleted'   
      else
        flash[:error] = 'no need to delete this labtoparcelle'
      end
    else
      flash[:error] = 'not deleted, Admin only!'
    end 
    respond_to do |format|
      format.html { redirect_to :action => "list_labtoparcelles" }
    end
  end
  
  def list_protofactures
    @protofactures = Protofacture.find(:all)  
    respond_to do |format|
      format.html
    end
  end
  def delete_protofacture
    protofacture = Protofacture.find(params[:id])  
    if session[:admin]
      if protofacture.produit.nil? || protofacture.facture.nil?
        protofacture.destroy
        flash[:notice] = 'Protofacture will be deleted'   
      else
        flash[:error] = 'no need to delete this protofacture'
      end
    else
      flash[:error] = 'not deleted, Admin only!'
    end        
    respond_to do |format|
      format.html { redirect_to :action => "list_protofactures" }
    end
  end
  
  def list_putofactures
    @putofactures = Putofacture.find(:all)  
    respond_to do |format|
      format.html
    end
  end
  
  def delete_putofacture
    putofacture = Putofacture.find(params[:id])  
    if session[:admin]
      if putofacture.pulve.nil? || putofacture.facture.nil?
        putofacture.destroy
        flash[:notice] = 'Putofacture will be deleted'   
      else
        flash[:error] = 'no need to delete this putofacture'
      end
    else
      flash[:error] = 'not deleted, Admin only!'
    end        
    respond_to do |format|
      format.html { redirect_to :action => "list_putofactures" }
    end
  end
  
  def list_putoproduits
    @putoproduits = Putoproduit.find(:all)  
    respond_to do |format|
      format.html
    end
  end
  
  def delete_putoproduit
    putoproduit = Putoproduit.find(params[:id])  
    if session[:admin]
      if putoproduit.pulve.nil? || putoproduit.produit.nil? || putoproduit.saison.nil?
        putoproduit.destroy
        flash[:notice] = 'Putoproduit will be deleted'   
      else
        flash[:error] = 'no need to delete this putoproduit'
      end
    else
      flash[:error] = 'not deleted, Admin only!'
    end        
    respond_to do |format|
      format.html { redirect_to :action => "list_putoproduits" }
    end
  end
  
  def list_putoparcelles
    @putoparcelles = Putoparcelle.find(:all)  
    respond_to do |format|
      format.html
    end
  end
  
  def delete_putoparcelle
    putoparcelle = Putoparcelle.find(params[:id])  
    if session[:admin]
      if putoparcelle.pulve.nil? || putoparcelle.parcelle.nil?
        putoparcelle.destroy
        flash[:notice] = 'Putoparcelle will be deleted'   
      else
        flash[:error] = 'no need to delete this putoparcelle'
      end
    else
      flash[:error] = 'not deleted, Admin only!'
    end        
    respond_to do |format|
      format.html { redirect_to :action => "list_putoparcelles" }
    end
  end
  
end
