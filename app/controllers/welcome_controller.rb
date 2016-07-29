class WelcomeController < ApplicationController

  def index
    @seo = Seo.new
    add_breadcrumb "index", welcome_index_path
  end

  def home

  end

end #end of class
