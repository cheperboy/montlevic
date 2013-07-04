# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'spreadsheet'
include GetSession

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_saison_id

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '942733c28af903e7eb303ba250f52f1b'
  before_filter :login_required
  before_filter :set_session_info
  
  def add_errors_to_model(model_errors)
    flash.now[:error] = 'Données Invalide :<br>'
    model_errors.each do |name, message|
      flash.now[:error] += name + ' - ' + message.to_s + '<br>'
    end
  end

  def login_required
    # GetSession.current_user = session[:user]
    unless session[:user_id]
      flash[:notice] = "Identification"
      redirect_to new_session_path
    end
  end
  
  def edit_access
    unless session[:edit_access]
      flash[:error] = "vous n'avez pas acces en ecriture"
      redirect_to :back
    end
  end

  def admin_access
    unless session[:admin]
      flash[:notice] = "Identification en tant qu'admin"
      redirect_to new_session_path
    end
  end

  # 04/07/2013 commente cqr jamais utilise (?)
  # def current_saison_id=(saison)
  #   @current_saison_id = Setting.find(:first).saison_id
  # end
  
  def current_saison_id
    @current_saison_id ||= session[:current_saison_id]
  end

  def hide_menu 
      render :update do |page| 
        # page.insert_html  :bottom,  'todo_list' , "<li>#{todo.name}</li>" 
        # page.replace_html 'bloc_left' ,  "bloc_left_hidden"
        # page.visual_effect :highlight, 'bloc_left'
        page.visual_effect  :toggle_blind, 'bloc_left'
        # page.remove 'bloc_left'
        # page.hide 'bloc_left'
      # end 
    end
  end

  protected
  
  # Sets the current saison into a named Thread location so that it can be accessed
  # by models and observers
  def set_session_info
    puts "set_session_info"
    Thread.current[:current_saison_id] = session[:current_saison_id]
    Thread.current[:user_id]= session[:user_id]
  end
  
   
end
