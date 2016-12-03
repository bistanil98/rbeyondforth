class TagsController < ApplicationController
  def index
    @tags = Tag.order(:tag_name)
    respond_to do |format|
      format.json {render json: @tags.where("tag_name like ?", "%#{params[:q]}%") }
      # replace above from this to add new tags by user
      # format.json {render json: @tags.tokens(params[:q]) }
    end
  end
end
