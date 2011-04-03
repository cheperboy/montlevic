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
    @labtofacture = Labtofacture.find(:labour)  
    respond_to do |format|
      format.html
    end
  end
  
end
