class PasswordResetsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to welcome_index_path, :notice => "Email sent with password reset instructions."
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(users_params)
      redirect_to users_login_path, :notice => "Password has been reset!"
    else
      render :edit
    end
  end
  def users_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,:password_digest,
                                 :uid,:provider,:token,:expire_at,:image)
  end
end
