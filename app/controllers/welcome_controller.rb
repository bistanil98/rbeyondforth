class WelcomeController < ApplicationController

  def index
    @seo = Seo.new
    @result=Seo.most_recent
    respond_to do |format|
      format.html
      format.json do
        render :layout => false
      end #{render json: @result}
    end
    add_breadcrumb "index", welcome_index_path
  end

  def home

  end

end #end of class
