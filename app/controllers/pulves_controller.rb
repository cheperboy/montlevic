class PulvesController < ApplicationController
  # GET /pulves
  # GET /pulves.xml
  def index
    @pulves = Pulve.find_by_saison(:all)
    # pulves = Pulve.find(:all, :conditions => ["saison_id = ?", Setting.find(:first).saison_id]) #do
    #   if params[:_search] == "true"
    #     name    =~ "%#{params[:name]}%" if params[:name].present?
    #     star    =~ "%#{params[:star]}%" if params[:star].present?
    #     dosage    =~ "%#{params[:name]}%" if params[:dosage].present?
    #   end
    #   paginate :page => params[:page], :per_page => params[:rows]      
    #   order_by "#{params[:sidx]} #{params[:sord]}"
    # end

    respond_to do |format|
      format.html
      # format.json { render :json => pulves.to_jqgrid_json([:id,:star, :name, 'category.name', 'user.name', :dosage, :date, 'link'], 
      #                                                    params[:page], 
      #                                                    params[:rows], 
      #                                                    pulves.total_entries) }
    end
  end
 #, :category_id, :user_id, :dosage, :date 
  def index_old
    @pulves = Pulve.find_by_saison(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pulves }
    end
  end

  # GET /pulves/1
  # GET /pulves/1.xml
  def show
    @pulve = Pulve.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pulve }
    end
  end

  # GET /pulves/new
  # GET /pulves/new.xml
  def new
    @pulve = Pulve.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pulve }
    end
  end

  # GET /pulves/1/edit
  def edit
    @pulve = Pulve.find(params[:id])
  end

  # POST /pulves
  # POST /pulves.xml
  def create
    @pulve = Pulve.new(params[:pulve])
    @pulve.saison_id = current_saison_id

    respond_to do |format|
      if @pulve.save
        flash[:notice] = 'Pulve was successfully created.'
        format.html { redirect_to(@pulve) }
        format.xml  { render :xml => @pulve, :status => :created, :location => @pulve }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pulve.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pulves/1
  # PUT /pulves/1.xml
  def update
    @pulve = Pulve.find(params[:id])

    respond_to do |format|
      if @pulve.update_attributes(params[:pulve])
        flash[:notice] = 'Pulve was successfully updated.'
        format.html { redirect_to(@pulve) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pulve.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pulves/1
  # DELETE /pulves/1.xml
  def destroy
    @pulve = Pulve.find(params[:id])
    @pulve.destroy

    respond_to do |format|
      format.html { redirect_to(pulves_url) }
      format.xml  { head :ok }
    end
  end
  def toggle_star
    @obj = Pulve.find(params[:id])
    if @obj.star != 1
       @obj.star = 1
    else
      @obj.star = 0
    end
    if @obj.save
      render(:layout => false)
    end
  end  
  
  def toggle_adu
    @obj = Pulve.find(params[:id])
    if @obj.adu != 1
       @obj.adu = 1
    else
      @obj.adu = 0
    end
    if @obj.save
      render(:layout => false)
    end
  end  
end
