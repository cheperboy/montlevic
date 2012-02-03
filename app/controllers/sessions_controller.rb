class SessionsController < ApplicationController
  skip_before_filter :login_required
  
  def new
  end

  def create 
    user = Myuser.authenticate(params[:login], params[:password]) 
    if user
      session[:user_id] = user.id
      session[:edit_access] = false
      session[:admin] = user.admin?
      session[:user_login] = user.login
      current_saison_id = Setting.find(:first).saison.id
      session[:current_saison_id] = Setting.find(:first).saison.id
      flash[:notice] = "Bonjour #{user.login}!"
      redirect_to parcelles_path
    else
      flash[:error] = "login/mot de passe invalide !"
      redirect_to new_session_path
      #render :controller => :sessions, :action => :new
    end
  end
  
  def read_only
    session[:edit_access] = false
    redirect_to :back
  end  

  def edit_access
    session[:edit_access] = true
    redirect_to :back
  end  

  def destroy
    reset_session 
    flash[:notice] = "Vous n'etes plus identifie" 
    redirect_to new_session_path
  end  

end
