class SessionsController < ApplicationController
  skip_before_filter :login_required
  
  def new
  end

  def create 
    user = Myuser.authenticate(params[:login], params[:password]) 
    if user
      session[:user_id] = user.id
      session[:admin] = user.admin?
      session[:user_login] = user.login
      session[:saison_id] = Setting.find(:first).saison.id
      session[:saison_name] = Setting.find(:first).saison.name
      flash[:notice] = "Bonjour #{user.login}!"
      redirect_to parcelles_path
    else
      flash[:error] = "Invalid email/password combination!"
      redirect_to new_session_path
      #render :controller => :sessions, :action => :new
    end
  end
  
  def destroy
    reset_session 
    flash[:notice] = "You've been logged out." 
    redirect_to new_session_path
  end  

end
