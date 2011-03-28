class FacdivsController < ApplicationController
  
  before_filter :find_facture

  def find_facture 
    @facture_id = params[:facture_id] 
      return(redirect_to(factures_url)) unless @facture_id 
    @facture = Facture.find(@facture_id)
  end
  
  def show
    @facdiv = Facdiv.find(params[:id])
  end

  def new
    @diverses = Diverse.find_by_saison(:all)
    @facdiv = Facdiv.new
  end

  def create
    params[:facdiv][:facture_id] = @facture.id
    params[:facdiv][:saison_id] = @facture.saison_id
    @facdiv = Facdiv.new(params[:facdiv])
    if @facdiv.save
      @facture.update_cout
      @facture.save!
      flash[:notice] = 'Enregistrement OK.'
      redirect_to(@facture)
    else
      @diverses = Diverse.find_by_saison(:all)
      render :action => "new"
    end
  end

  def edit
    @diverses = Diverse.find_by_saison(:all)
    @facdiv = @facture.facdivs.find(params[:id])
  end

  def update
    @facdiv = Facdiv.find(params[:id])
    if @facdiv.update_attributes(params[:facdiv])
      @facture.update_cout
      @facture.save!
      flash[:notice] = 'Modif OK'
      redirect_to facture_url(@facture)
    else
      @diverses = Diverse.find_by_saison(:all)
      render :action => "edit"
    end
  end

  def destroy
    @facdiv = @facture.facdivs.find(params[:id])
    @facdiv.destroy
    @facture.update_cout
    @facture.save!
    redirect_to(@facture) 
  end
#  def destroy
#    @facdiv = @facture.facdivs.find(params[:id])
#    @facture.facdivs.delete(@facdiv)
#    @facture.update_cout
#    @facture.save!
#    redirect_to(@facture) 
#  end
  
end
