class LaboursController < ApplicationController
  # GET /labours
  # GET /labours.xml
  def index
    @labours = Labour.find_by_saison(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @labours }
    end
  end

  # GET /labours/1
  # GET /labours/1.xml
  def show
    @labour = Labour.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @labour }
    end
  end

  # GET /labours/new
  # GET /labours/new.xml
  def new
    @labour = Labour.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @labour }
    end
  end

  # GET /labours/1/edit
  def edit
    @labour = Labour.find(params[:id])
  end

  # POST /labours
  # POST /labours.xml
  def create
    @labour = Labour.new(params[:labour])
    @labour.saison_id = current_saison_id

    respond_to do |format|
      if @labour.save
        flash[:notice] = 'Labour was successfully created.'
        format.html { redirect_to(@labour) }
        format.xml  { render :xml => @labour, :status => :created, :location => @labour }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @labour.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /labours/1
  # PUT /labours/1.xml
  def update
    @labour = Labour.find(params[:id])

    respond_to do |format|
      if @labour.update_attributes(params[:labour])
        flash[:notice] = 'Labour was successfully updated.'
        format.html { redirect_to(@labour) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @labour.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /labours/1
  # DELETE /labours/1.xml
  def destroy
    @labour = Labour.find(params[:id])
    @labour.destroy

    respond_to do |format|
      format.html { redirect_to(labours_url) }
      format.xml  { head :ok }
    end
  end
end
