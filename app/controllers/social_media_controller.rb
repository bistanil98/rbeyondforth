class SocialMediaController < ApplicationController
  require 'koala'
  require "fb_graph"
  respond_to :html, :json

=begin
    @graph = Koala::Facebook::API.new(user.token)
    #puts @user.put_like(user.uid);
    #@client=@graph.put_wall_post("test app")
    @account = @graph.get_object("me")
    puts @account
=end
=begin
    @t=@graph.get_object("soarlogic")
    @tt=@graph.get_object("me/accounts")
    puts "user.token"
    puts user.token
    puts "facebook_page >>>>>"
    @token=@graph.get_page_access_token("soarlogic")
    puts@token
=end

=begin
    @likes = @user.get_object("soarlogic")["likes"]

    puts "likes"
    puts @likes


    @friends=@user.get_connections("me", "accounts")

    print @friends

    @friends.each do |hash|
      puts 'name'
      puts hash['id']
      self.friends.find(:name => hash['name'], :uid => hash['id']).first_or_create

    end
    #page_access_token = @user.get_connections('me', 'accounts').first[user.token] #this gets the users first page.
=end

    # puts page_access_token
    #@page = Koala::Facebook::API.new(page_access_token)

=begin
    owner = FbGraph::User.me(user.token)
    pages = owner.accounts
    page = pages.detect do |page|
      #page.identifier == FB_PAGE_ID
      puts page
    end
=end
=begin
    puts "client";
    puts @client
=end

    #@user.put_connections(user.uid, "feed", :message => "I am writing on my wall!")

    #@page.put_connections(user.uid, "feed", :message => "Page writting to user's wall!")
=begin
    graph = Koala::Facebook::API.new('CAACEdEose0cBAFO7XmLiZCvh8mBUW1i3qwPqkUWIAQHLjQUbpyw2UXfjcg8F34ZB5iFcDmP66ZA8dDSvdzXzjRpZCWAes4Gc1Y55diuW02AyZBwQh75JB22QZBzZCOkz1xZAV97QptKZCj1zjrcyEvVHlJMRy9ZBoWW3OejOgZCAigkiDNv9VzZAxJft5ScSQdRVkdWoxwNiKL16h9naIZCxbbLca');
    @likes = graph.get_object("Rockinghats")["likes"]
=end
  def index

    user = User.find_by_id(session[:user_id])
    puts user.token

    if (user.token).nil?

      redirect_to users_fb_login_path
    else
      @graph = Koala::Facebook::API.new(user.token)

      @fb_pages=@graph.get_object("me/accounts/page")
      @results = params[:page] ? @graph.get_page(params[:page]) : @graph.get_connections("me", "feed")
      @id=user.token
      @action_path = 'post_on_my_wall'

    end

  end #end of index function

 def fb_page_display
   @page_graph = Koala::Facebook::API.new(params[:id])
   #@page_graph.get_object('me') # I'm a page
   #@fb_pages_feeds=@page_graph.get_connection('me', 'feed') # the page's wall

   @results = params[:page] ? @page_graph.get_page(params[:page]) : @page_graph.get_connections("me", "feed")
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

    def new
    client = Facebook.auth(callback_facebook_url).client
    redirect_to client.authorization_uri(
                    :scope => Facebook.config[:scope]
                )
  end

  def twitter_index
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = "ltBRXLY3wnyGr5XnG4EYAfoQ1"
      config.consumer_secret = "EVAmMP7b3IDck8814AoF5WDwud0BsMcgnIzmQ7tv49Y2WURFfH"
      config.oauth_token = "81803888-pXqmQ9m4BvY47GWWGxB7udxYtU22SAeo2XsnGL8sZ"
      config.oauth_token_secret = "RGGn9Imu7piZ7ssFePL80rJI1y9UnIVIUtkY3d7yrED2J"
    end
      @twitts=@client.user_timeline
  end

  def twitter_notification
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = "ltBRXLY3wnyGr5XnG4EYAfoQ1"
      config.consumer_secret = "EVAmMP7b3IDck8814AoF5WDwud0BsMcgnIzmQ7tv49Y2WURFfH"
      config.oauth_token = "81803888-pXqmQ9m4BvY47GWWGxB7udxYtU22SAeo2XsnGL8sZ"
      config.oauth_token_secret = "RGGn9Imu7piZ7ssFePL80rJI1y9UnIVIUtkY3d7yrED2J"
    end
    @twitts=@client.mentions_timeline
  end

  def post_on_twitter_wall
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = "ltBRXLY3wnyGr5XnG4EYAfoQ1"
      config.consumer_secret = "EVAmMP7b3IDck8814AoF5WDwud0BsMcgnIzmQ7tv49Y2WURFfH"
      config.oauth_token = "81803888-pXqmQ9m4BvY47GWWGxB7udxYtU22SAeo2XsnGL8sZ"
      config.oauth_token_secret = "RGGn9Imu7piZ7ssFePL80rJI1y9UnIVIUtkY3d7yrED2J"
    end
    @client.update(params['social_media']['message'])
    redirect_to social_media_twitter_index_path

  end

end #end of class
