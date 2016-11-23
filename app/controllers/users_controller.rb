class UsersController < ApplicationController

  require 'koala'
  layout 'user_layout', :only => [:profile, :change_password,:update_password,:edit]

  before_action :require_login, :except => [:login, :fb_login, :google_login, :register, :logout, :new, :create]


  def index
    add_breadcrumb "users index", users_index_path
  end


  def login
    if user_is_logged_in?
      redirect_to users_profile_path
    else
      @user = User.new
    end
    add_breadcrumb "login", users_login_path
  end

  def fb_login
    puts 'in fb login path'
   redirect_to '/auth/facebook'
  end

  def twttr_login
    puts 'in tw login path'
    redirect_to '/auth/twitter'
  end

  def linkedin_login
    puts 'in linkedin login path'
    redirect_to '/auth/linkedin'
  end

  def google_login
    puts 'in google login path'
    redirect_to '/auth/google_oauth2'
  end

  def git_login
    puts 'in github login path'
    redirect_to '/auth/github'
  end

  def pinterest_login
    puts 'in pinterest login path'
    redirect_to '/auth/pinterest'
  end

  def logout
    redirect_to sessions_destroy_path
  end

  def new
    if user_is_logged_in?
      redirect_to users_index_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to users_login_path
    else
      if User.find_by_email(@user.email) or SocialMedium.find_by_social_email(@user.email)
        flash[:notice] = "#{@user.email} is already registered with us. You must login to continue with this email or try creating account with another email that is not already registered with us."
        render 'register'
        puts "registering with existing email account"
      else
        flash[:error] = "Sorry, something went wrong. Please try again!"
        render 'register'
      end
    end
  end

  def upload_image
    @user = User.find(params[:id])
    if @user.update_attributes(user_params_image)
      flash[:success] = "Your image has updated successfully"
      redirect_to users_profile_path
    else
      flash[:error] = "put image"
      render 'users/profile'
    end
  end

  def profile
    @user = User.find_by_id(session[:user_id])
    add_breadcrumb "profile", users_profile_path
  end

  def change_password
    @user = User.find_by_id(session[:user_id])
    add_breadcrumb "change password", users_change_password_path
  end

  def forgot_password
    @user = User.new
    add_breadcrumb "forgot password", users_forgot_password_path
  end

  def forgot_password_send_email
    user = User.find_by_email('bist.anil12@soarlogic.com')
    user.send_password_reset if user
    redirect_to users_login_path, :notice => "Email sent with password reset instructions."
  end

  def edit
    @user = User.find(params[:id])
  end

  def delete
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(users_params)
      flash[:success] = "Update Successfully"
      redirect_to users_profile_path
    else
      render 'edit'
    end
  end

  def update_password
    @user = User.find(params[:id])
  if !params[:user][:current_password].empty? && (@user.password == params[:user][:current_password])
      if (! params[:user][:password].empty? && ! params[:user][:password_confirmation].empty? ) && params[:user][:password] == params[:user][:password_confirmation]
        @user.update(users_params)
        flash[:success] = "Update Successfully"
        redirect_to users_change_password_path
      else
        flash[:error] = "password and comfirm password dose not match"
        render 'users/change_password'
      end
    else
      flash[:error] = "Current password dose not match"
      render 'users/change_password'
    end
  end

  def show
  end

  def register

    if user_is_logged_in?
      redirect_to users_index_path
    end
    add_breadcrumb "register", users_register_path
  end

  private

  def users_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,:password_digest,
                                 :uid,:provider,:token,:expire_at)
  end

  def user_params_image
    params.require(:user).permit(:image)
  end
end
