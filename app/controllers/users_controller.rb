class UsersController < ApplicationController

  require 'koala'
  require "fb_graph"
  layout 'user_layout', :only => [:profile, :change_password,:update_password,:edit]
  def index
    #@graph = Koala::Facebook::GraphAPI.new
    #@client=@graph.get_object("soarlogic")
    #puts @client
  end


  def login
    @user = User.new
  end

  def fb_login
    puts 'in fb login path'
   redirect_to '/auth/facebook'
  end

  def tw_login
    puts 'in tw login path'
    redirect_to '/auth/twitter'
  end

  def linkedin_login
    puts 'in linkedin login path'
    redirect_to '/auth/linkedin'
  end

  def google_login
    puts 'in google login path'
    redirect_to '/auth/google'
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
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to users_login_path
    else
      flash[:error] = "put data"
      render 'register'
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
  end

  def change_password
    @user = User.find_by_id(session[:user_id])
  end

  def forgot_password
    @user = User.new
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
