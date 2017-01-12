class BlogsController < ApplicationController
  layout 'blog'
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # GET /blogs
  # GET /blogs.json
  def users_blog_index
    @blogs = current_user.blogs.page(params[:page]).per(5).most_recent # gets the current users blog posts in descending order and paginating the results to 5 per page
  end

  def index
    @blogs = Blog.page(params[:page]).per(5).most_recent #paginating the results to 5 per page
    # gets the most_recent post or gets all the post in descending order from database.
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    #for counting the no. of post to show the popular posts in the index page.
    @comments = @blog.comments.page(params[:page]).per(7).most_recent
    @blog_visit =  @blog.blog_visit_count
    @blog_visit+=1 #increments the no. of blog visit each time the blog is visited.
    @blog.update(:blog_visit_count => @blog_visit)

  end

  # GET /blogs/new
  def new
    @blog = current_user.blogs.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = current_user.blogs.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to users_blog_index_path, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to users_blog_index_path, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to users_blog_index_path, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:blog_title, :blog_description, :blog_category_name, :tag_tokens)
    end
end
