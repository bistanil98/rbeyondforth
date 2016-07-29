class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  add_breadcrumb :index # 'root_path' will be used as url

 # before_filter :require_login , :except => [:index, '/user/auth/*',:tw_login,:tw_create,:forgot_password,:forgot_password_send_email,:login, :register,:create,:update,:create_fb,:fb_login,'/auth/facebook','social_media/index',:new,:edit]

  def current_user
    #@current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) || User.find(session[:user_id]) if cookies[:auth_token] or session[:user_id]
  end

  helper_method :current_user

  def authorize
    flash[:error] = "You must be logged in to access this section"
    redirect_to users_login_path unless current_user
  end


  private

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to users_login_path    # halts request cycle
    end
  end

end
