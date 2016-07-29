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

  end

  def update
    #puts params[:user][:current_password]
    user = User.find_by_email(current_user.email)
    if !user.nil? && user.authenticate(params[:user][:password])
      user.update_attributes(users_params)
      flash[:success] = "Password Update Successfully"
      redirect_to users_profile_path
    elsif user.nil?
      flash[:error] = "Current password dose not match"
      render 'users/change_password'
    else
      flash[:error] = "Password dose not match"
      render 'users/change_password'
    end
  end
  def create
    user = User.find_by_email(params[:user][:email])
    # puts(params[:user][:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      session[:user_name] = user.name
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
  end
  def create_fb
    user = User.omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    session[:user_name] = user.name
    session[:user_image] = user.image
    #request.env['omniauth.strategy'].options[:scope] = 'email,manage_pages,user_events,user_location,user_birthday'
    #render :text => "Setup complete.", :status => 404
    redirect_to social_media_index_path
  end
  def create_tw
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    session[:user_name] = user.name
    #render :text => "Setup complete.", :status => 404
    redirect_to social_media_index_path
  end
  def create_google
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    cookies.delete(:auth_token)
    redirect_to users_login_path
  end

  private

  def users_params
    params.require(:user).permit(:email, :password)
  end
end
