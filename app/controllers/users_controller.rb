class UsersController < ApplicationController
  # GET /users
  # GET /users.xml

  def index
    logger.error "INDEX"
    @users = User.all(:order => :name)
    logger.error "params:#{params.inspect}"
    if request.put? 
      if params[:act].eql?("new")
        logger.error "ACTION INDEX-NEW"
        logger.error "params:#{params.inspect.to_s}"
        @user = User.new(params[:user])
        if @user.save
          flash[:notice] = "creation de #{@user.name} ok !"
          @act = 'show'
          render	:partial=>'user_body', :layout=>false
        else
          add_errors_to_model(@user.errors)
          # @user = User.new(params[:user])
          @act = 'edit'
          render	:partial=>'user_body', :layout=>false
        end
      elsif params[:act].eql?("update")
        logger.error "ACTION INDEX-UPDATE"
        @user = User.find(params[:id])
        if @user.update_attributes(params[:user])
          flash[:notice] = "mise a jour de #{@user.name} ok !"
          @act = 'show'
        else
          flash[:error] = "PROBLEME #{@user.name}"
          add_errors_to_model(@user.errors)
          @act = 'edit'
        end

        # if @user.update_attributes(params[:user])
        #   flash[:notice] = "mise a jour de #{@user.name} ok !"
        #   @act = 'show'
        # end
      else
        logger.error "ACTION NOT DEFINED"
      end
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @users }
      end
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    logger.error "show"
    @user = User.find(params[:id])
    render	:partial=>'user_body', :layout=>false
  end
  
  def show_user
    logger.error "show_user"
    @user = User.find(params[:id])
    @act = 'show'
    render	:partial=>'user_body', :layout=>false
  end
  
  def new_user
    logger.error "new_user"
    @user = User.new
    @act = 'new'
    render	:partial=>'user_body', :layout=>false
  end
  
  def edit_user
    logger.error "edit_user"
    @user = User.find(params[:id])
    @act = 'edit'
    render	:partial=>'user_body', :layout=>false
  end
    
  # GET /users/new
  # GET /users/new.xml
  # def new
  #   @users = User.all(:order => :name)
  #   @user = User.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @user }
  #   end
  # end

  # GET /users/1/edit
  # def edit
  #   @users = User.all(:order => :name)
  #   @user = User.find(params[:id])
  # end

  # POST /users
  # POST /users.xml
  def create
    logger.error "create"
    @users = User.all(:order => :name)
    @user = User.new(params[:user])
  
    respond_to do |format|
      if @user.save
        flash[:notice] = "Ajout de #{@user.name} ok !"
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
  # def update
  #   @users = User.all(:order => :name)
  #   @user = User.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @user.update_attributes(params[:user])
  #       flash[:notice] = "mise a jour de #{@user.name} ok !"
  #       @act = 'show'
  #       format.html { redirect_to(users_url) }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @users = User.all(:order => :name)
    
    @user = User.find(params[:id])
    if @user.has_associations?
      flash[:error] = "pas de suppresion. <br>#{@user.name} est associe a des Travaux"
    else
      flash[:notice] = "suppression de #{@user.name} ok !"
      @user.destroy
    end
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
