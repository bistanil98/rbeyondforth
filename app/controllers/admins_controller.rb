class AdminsController < ApplicationController

  layout 'admin', :only => [:index, :charts, :reports, :forms, :elements, :grid, :blank, :profile, :change_password, :create_menu, :create_submenu ]

  def index
  end

  def login
    @user = User.new
  end

  def change_password
  end

  def user_list
  end

  def user_detail
  end

  def new
  end

  def create_menu
  end

  def update
  end

  def delete
  end

  def dashboard
  end

  def charts
  end

  def reports
  end

  def profile
  end

  def logout
    redirect_to sessions_destroy_path
  end

  def create_menu
  end

  def create_submenu
  end

  end
