# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_saison_id

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '942733c28af903e7eb303ba250f52f1b'
  before_filter :login_required
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  def login_required 
    unless session[:user_id]
      flash[:notice] = "Please log in"
      redirect_to new_session_path
    end
  end
  
  def logged_in?
    return session[:user_id].nil?
  end
    
  def current_saison_id=(saison)
    @current_saison_id = Setting.find(:first).saison_id
  end
  
  def current_saison_id
    @current_saison_id ||= Setting.find(:first).saison_id
  end

end
