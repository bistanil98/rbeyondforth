class SocialMediaController < ApplicationController
  require 'koala'
  require 'rubygems'
  require 'linkedin-oauth2'
  add_breadcrumb "profile", :users_profile_path


  def index

    if session[:user_id]

      user = SocialMedium.find_by_provider_and_user_id("facebook", session[:user_id])
      puts user.token

      if (user.token).nil?
        redirect_to users_fb_login_path
      else
        @graph = Koala::Facebook::API.new(user.token)

        @fb_pages=@graph.get_object("me/accounts/page")
        @myid = @graph.get_object("me")
        @results = params[:page] ? @graph.get_page(params[:page]) :  @graph.get_connection("me","feed",{fields: ['story','message','picture','full_picture','story_tags','likes.summary(true)','comments.summary(true)','link','created_time','from'],limit: 4})

        @id=user.token
        @action_path = 'post_on_my_wall'

      end
    else
      redirect_to users_login_path
    end
    add_breadcrumb "facebook home", social_media_index_path
  end #end of index function

  def fb_page_display
    user = SocialMedium.find_by_provider_and_user_id("facebook",session[:user_id])
    @page_graph = Koala::Facebook::API.new(params[:id])
    @graph = Koala::Facebook::API.new(user.token)
    @myid=@graph.get_object("me")
    #@page_graph.get_object('me') # I'm a page
    #@fb_pages_feeds=@page_graph.get_connection('me', 'feed') # the page's wall

    @results = params[:page] ? @page_graph.get_page(params[:page]) : @page_graph.get_connections("me","feed",{fields: ['story','message','picture','full_picture','story_tags','likes.summary(true)','comments.summary(true)','link','created_time','from'],limit: 4})
=begin
   respond_to do |format|
     format.json { head :ok }
   end
=end
    #render "social_media/fb_data", status: :ok,:message => "success"


    render :partial => "social_media/fb_page_data",status: :ok,:message => "success"

    #@page_graph.put_wall_post('post on page wall') # post as page, requires new publish_pages permission

    #@page_graph.put_connections(page_id, 'feed', :message => message, :picture => picture_url, :link => link_url)
    #@page_graph.get_connections(page_id, 'insights/page_impressions_frequency_distribution', period: 'week')
  end

  def fb_like
    user = SocialMedium.find_by_provider_and_user_id("facebook",session[:user_id])
    @post_id = Koala::Facebook::API.new(user.token)
    postid=params[:pid]
    @post_id.put_like(postid)
    respond_to do |format|
      format.html {redirect_to social_media_index_path }
      format.js
    end
  end

  def fb_unlike
    user = SocialMedium.find_by_provider_and_user_id("facebook",session[:user_id])
    @post_id = Koala::Facebook::API.new(user.token)
    postid=params[:pid]
    @post_id.delete_like(postid)
    respond_to do |format|
      format.html {redirect_to social_media_index_path}
      format.js
    end
  end

  def fb_data
    respond_to do |format|
      format.js
    end
  end

  def post_on_my_wall
    #puts params['social_media']['message']
    @page_graph = Koala::Facebook::API.new(params[:id])
    @page_graph.get_connections("me", "feed")
    @page_graph.put_wall_post(params['social_media']['message'])
    redirect_to social_media_index_path
  end

  def post_on_my_page_wall

    @page_graph = Koala::Facebook::API.new(params[:id])
    @page_graph.get_connections("me", "feed")
    @page_graph.put_wall_post(params['social_media']['message'])
    redirect_to social_media_index_path

  end

  # def new
  #   client = Facebook.auth(callback_facebook_url).client
  #   redirect_to client.authorization_uri(
  #                   :scope => Facebook.config[:scope]
  #               )
  # end

  def twitter_index
    if user_is_logged_in?
      if SocialMedium.find_by_provider_and_user_id("twitter",session[:user_id])
        @client = Twitter::REST::Client.new do |config|
          config.consumer_key = "9KgIgsd0LoGJBpDTUxydENoMs"
          config.consumer_secret = "6ohRmMBev9V5XNrQ6kDkk6p8cR6l9SlKd4NbVFIp7aNAG0biVb"
          config.access_token = "781715888861024256-aTtNbHLZDzSf314WNkTt2HRhUapWjeI"
          config.access_token_secret = "gkBVX5ohujRjTPNEcHsk2BQtU31HpUJe22XbsoiQR6H3j"
        end
          @twitts=@client.home_timeline(count: 7)
        add_breadcrumb "twitter home", social_media_twitter_index_path
      else
        redirect_to users_twttr_login_path
      end
    else
      redirect_to users_login_path
    end
  end

  def refresh_twtr_home
    respond_to do |format|
      format.js
    end
  end

  def twitter_notification
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = "9KgIgsd0LoGJBpDTUxydENoMs"
      config.consumer_secret = "6ohRmMBev9V5XNrQ6kDkk6p8cR6l9SlKd4NbVFIp7aNAG0biVb"
      config.access_token = "781715888861024256-aTtNbHLZDzSf314WNkTt2HRhUapWjeI"
      config.access_token_secret = "gkBVX5ohujRjTPNEcHsk2BQtU31HpUJe22XbsoiQR6H3j"
    end
    @twitts=@client.mentions_timeline
    add_breadcrumb "notification", social_media_twitter_notification_path
  end

  def post_on_twitter_wall
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = "9KgIgsd0LoGJBpDTUxydENoMs"
      config.consumer_secret = "6ohRmMBev9V5XNrQ6kDkk6p8cR6l9SlKd4NbVFIp7aNAG0biVb"
      config.access_token = "781715888861024256-aTtNbHLZDzSf314WNkTt2HRhUapWjeI"
      config.access_token_secret = "gkBVX5ohujRjTPNEcHsk2BQtU31HpUJe22XbsoiQR6H3j"
    end
    @client.update(params['social_media']['message'])
    redirect_to social_media_twitter_index_path

  end

  def linkedin_index
    user = User.find_by_id(session[:user_id])
    if (user.expire_at<Time.now)
      redirect_to sessions_create_linkedin_path
    else
      @client = LinkedIn::API.new(user.token)
      @profile = @client.profile(fields: ['id', 'email-address', 'first-name', 'last-name', 'headline', 'location', 'industry', 'picture-url', 'public-profile-url'])
    end
    add_breadcrumb "likedin home", social_media_linkedin_index_path
  end


  def post_on_linkedin_wall
    user = User.find_by_id(session[:user_id])
    puts user.token

    @client = LinkedIn::API.new(user.token)
    @client.add_share(content: "#{params['social_media']['content']}")
    redirect_to social_media_linkedin_index_path
    #@results = @client.shares
  end
end #end of class
