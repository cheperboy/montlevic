class VerifsController < ApplicationController

  def index
    @test = Verif.new
    @test.run_test
    respond_to do |format|
      format.html
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
  
end
