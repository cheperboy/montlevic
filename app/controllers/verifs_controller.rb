class VerifsController < ApplicationController

  def index
    @test = Verif.new
    @test.run_test
    respond_to do |format|
      format.html
    end
  end

  # GET /verifs/1
  # GET /verifs/1.xml
  def show
    @verif = Verif.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @verif }
    end
  end

  # GET /verifs/new
  # GET /verifs/new.xml
  def new
    @verif = Verif.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @verif }
    end
  end

  # GET /verifs/1/edit
  def edit
    @verif = Verif.find(params[:id])
  end

  # POST /verifs
  # POST /verifs.xml
  def create
    @verif = Verif.new(params[:verif])

    respond_to do |format|
      if @verif.save
        flash[:notice] = 'Verif was successfully created.'
        format.html { redirect_to(@verif) }
        format.xml  { render :xml => @verif, :status => :created, :location => @verif }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @verif.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /verifs/1
  # PUT /verifs/1.xml
  def update
    @verif = Verif.find(params[:id])

    respond_to do |format|
      if @verif.update_attributes(params[:verif])
        flash[:notice] = 'Verif was successfully updated.'
        format.html { redirect_to(@verif) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @verif.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /verifs/1
  # DELETE /verifs/1.xml
  def destroy
    @verif = Verif.find(params[:id])
    @verif.destroy

    respond_to do |format|
      format.html { redirect_to(verifs_url) }
      format.xml  { head :ok }
    end
  end
end
