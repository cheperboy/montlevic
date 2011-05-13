class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index

    # 
    # toto = []
    # toto << 'jhon'
    # toto << 'mat'
    # logger.error(toto.to_s)
    # 
    # @subsubdata = {}
    # @subsubdata['subsub1'] = 'string'
    # @subsubdata[:subsub2] = :_sym_
    # @subsubdata[:inte] = 1000.33
    # 
    # @subdata = {}
    # @subdata[:tab] = toto
    # @subdata[:sub2] = @subsubdata
    # 
    # @data={}
    # @data[:valeur1] = 'premiere'
    # @data[:valeur2] = 'seconde'
    # @data[3] = toto
    # @data['the sub'] = @subdata
   
    users = User.find(:all) do
      if params[:_search] == "true"
        name    =~ "%#{params[:name]}%" if params[:name].present?
      end
      paginate :page => params[:page], :per_page => params[:rows]      
      order_by "#{params[:sidx]} #{params[:sord]}"
    end

    respond_to do |format|
      format.html
      format.json { render :json => users.to_jqgrid_json([:id,:name], 
                                                         params[:page], params[:rows], users.total_entries) }
    end
  end
  def index_old
    @users = User.all(:order => :name)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @users = User.all
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @users = User.all
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @users = User.all
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @users = User.all
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(users_url) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @users = User.all
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
