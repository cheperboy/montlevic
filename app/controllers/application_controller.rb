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
  
  def add_errors_to_model(model_errors)
    flash.now[:error] = 'Données Invalide :<br>'
    model_errors.each do |name, message|
      flash.now[:error] += '- ' + message.to_s + '<br>'
    end
  end

  def login_required 
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

  # def update_current_saison_id
  #   logger.error "IN application_controller.rb : PARAMETERS : #{params}"
  #   logger.error "params[:select_saison_id] : #{params[:select_saison_id]}"
  #   logger.error "params[:new_saison_id] : #{params[:new_saison_id]}"
  #   render :update do |page|
  #     # page.reload
  #   end
  #   setting = Setting.find(:first).saison_id
  #   setting.update_attribute(:saison_id, params[:select_saison_id])
  #   # setting.saison_id = params[:select_saison_id]
  #   setting.save!
  #   @current_saison_id = params[:select_saison_id]
  # end

  def current_saison_id=(saison)
    @current_saison_id = Setting.find(:first).saison_id
  end
  
  def current_saison_id
    @current_saison_id ||= Setting.find(:first).saison_id
  end

  def hide_menu 
    # <% form_remote_tag :url => {:action => 'hide_menu'} do %> 
    #   <%= text_field 'todo', 'name' %> 
    #   <%= submit_tag 'TEST!!!' %>
    # <% end %>    
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

end
