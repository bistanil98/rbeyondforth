class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:category_name).where("category_name like ?", "%#{params[:term]}%")
    render json: @categories.map(&:category_name)
  end
end
