class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #add_breadcrumb "login", :root_path # 'root_path' will be used as url

 # before_filter :require_login , :except => [:index, '/user/auth/*',:twttr_login,:tw_create,:forgot_password,:forgot_password_send_email,:login, :register,:create,:update,:create_fb,:fb_login,'/auth/facebook','social_media/index',:new,:edit]

  def current_user
    #@current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) || User.find(session[:user_id]) if cookies[:auth_token] or session[:user_id]
    return @current_user
    puts "current user: #{@current_user}"
  end

  helper_method :current_user

  def authorize
    flash[:error] = "You must be logged in to access this section"
    redirect_to users_login_path unless current_user
  end


  private

  def require_login
    unless user_is_logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to users_login_path    # halts request cycle
    end
  end

  def connected_fb?
    !!SocialMedium.find_by_provider_and_user_id("facebook",session[:user_id]).present?
  end
  helper_method :connected_fb?

  def connected_twtr?
    !!SocialMedium.find_by_provider_and_user_id("twitter",session[:user_id]).present?
  end
  helper_method :connected_twtr?

  def connected_google?
    !!SocialMedium.find_by_provider_and_user_id("google_oauth2",session[:user_id]).present?
  end
  helper_method :connected_google?

  def connected_linkedin?
    !!SocialMedium.find_by_provider_and_user_id("linkedin",session[:user_id]).present?
  end
  helper_method :connected_linkedin?

  def connected_pin?
    !!SocialMedium.find_by_provider_and_user_id("pinterest",session[:user_id]).present?
  end
  helper_method :connected_pin?

  def connected_git?
    !!SocialMedium.find_by_provider_and_user_id("github",session[:user_id]).present?
  end
  helper_method :connected_git?

  def fb_comments(options)
    user = SocialMedium.find_by_provider_and_user_id("facebook",session[:user_id])
    @post_id = Koala::Facebook::API.new(user.token)
    comm_usr_id=options[:cuid]
    puts comm_usr_id
    @post_id.get_picture(comm_usr_id)
  end

  helper_method :fb_comments

  def user_is_logged_in?
    !!session[:user_id]
  end

  helper_method :user_is_logged_in?

end
