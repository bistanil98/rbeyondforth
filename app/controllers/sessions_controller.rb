class SessionsController < ApplicationController
  #session[:fb_permissions]='email,manage_pages,user_events,user_location,user_birthday'
  def create_old
    user = User.find_by_email(params[:user][:email])
   # puts(params[:user][:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:user][:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      session[:user_name] = user.name
      redirect_to users_index_path
    else
      # If user's login doesn't work, send them back to the login form.
      redirect_to users_login_path
    end

  end #create_old ends here

  def update
    #puts params[:user][:current_password]
    user = User.find_by_email(current_user.email)
    if !user.nil? && user.authenticate(params[:user][:password])
      user.update_attributes(users_params)
      flash[:success] = "Password Update Successfully"
      redirect_to users_profile_path
    elsif user.nil?
      flash[:error] = "Current password does not match"
      render 'users/change_password'
    else
      flash[:error] = "Password does not match"
      render 'users/change_password'
    end
  end #update ends here

  def create
    user = User.find_by_email(params[:user][:email])
    s_user = SocialMedium.find_by_social_email(params[:user][:email])
    # puts(params[:user][:email])
    # If the user exists AND the password entered is correct.
    if (user or s_user) && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      session[:user_name] = user.name
      # session[:user_image] = user.image
      # puts "#{session[:user_image]}"
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to users_index_path, :notice => "Logged in!"
    else
      flash[:error] = "Invalid email or password"
      redirect_to users_login_path
    end
  end ##create ends here

  def create_fb

    unless user_is_logged_in?
      user = User.fb_omniauth(env['omniauth.auth'])
      puts "user.logging.to.fb.using.oauth."
      session[:user_id] = user.id
      session[:user_name] = user.name
      session[:user_image] = user.image
      redirect_to social_media_index_path
    else
      if SocialMedium.find_by_provider_and_user_id("facebook", session[:user_id]).present?
        fb_user = SocialMedium.fb_omni(env['omniauth.auth'])
        redirect_to social_media_index_path
      else
        fb_user = SocialMedium.fb_omni(env['omniauth.auth'], session[:user_id])
        redirect_to social_media_index_path
      end
    end
  end #create_fb ends here

  def create_twttr
    if user_is_logged_in?
      user = SocialMedium.twtr_omni(env['omniauth.auth'], session[:user_id])
      redirect_to social_media_twitter_index_path
    end
  end #create_twttr ends here

  def create_google
    unless user_is_logged_in?
      user = User.google_omniauth(env['omniauth.auth'])
      puts "user.logging.to.fb.using.oauth."
      session[:user_id] = user.id
      session[:user_name] = user.name
      session[:user_image] = user.image
      redirect_to social_media_google_index_path
    else
      if SocialMedium.find_by_provider_and_user_id("google_oauth2", session[:user_id]).present?
        redirect_to social_google_media_index_path
      else
        g_user = SocialMedium.google_omni(env['omniauth.auth'], session[:user_id])
        redirect_to social_media_google_index_path
      end
    end
  end #create_google ends here

  def create_linkedin
    if user_is_logged_in?
      user = SocialMedium.linkedin_omni(env['omniauth.auth'], session[:user_id])
      redirect_to social_media_linkedin_index_path
    end
  end #create_linkedin ends here

  def create_pinterest
    if user_is_logged_in?
      user = SocialMedium.pinterest_omni(env['omniauth.auth'], session[:user_id])
      redirect_to social_media_pinterest_index_path
    end
  end #create_pinterest ends here
  def create_github
    if user_is_logged_in?
      user = SocialMedium.github_omni(env['omniauth.auth'], session[:user_id])
      redirect_to social_media_github_index_path
    end
  end #create_github ends here

  def destroy
    # u = SocialMedium.find_by_user_id(session[:user_id])
    # if u.update(token:nil)
    #   puts "token has been removed"
    # end
    #clear_facebook_session_information
    session[:user_id] = nil
    session[:user_name] = nil
    session[:user_image] = nil
    #cookies.delete(:auth_token)
    #cookies.delete(:_rbeyondforth_session)
    redirect_to users_login_path
  end #destroy ends here

  private

  def users_params
    params.require(:user).permit(:email, :password)
  end

end
