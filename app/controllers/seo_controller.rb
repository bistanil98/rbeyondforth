class SeoController < ApplicationController

  require  'uri'
  require 'page_rankr'
  require 'page_rankr/ranks/google'
  require  'seo_params'
  require 'rubygems'
  require 'rsolr'
  require 'w3c_validators'
  require 'koala'
  require "prawn"
  require "prawn/table"
  require "axlsx"
  require "axlsx_rails"
  require "metainspector"
  #require "sinatra"
  require "nokogiri"
  #require "sinatra/contrib"
  require "pagespeed"

  require 'wordlist/builders/website'


  layout 'seo_layout', :only => [:index, :modal, :get_on_offpage, :get_seo_report, :get_page_speed, :post_page_speed, :post_page_keywords, :post_unique_words, :post_page_links, :post_meta_tags, :get_page_links, :get_unique_words, :get_meta_tags, :get_page_keywords, :suggestion, :seo_w3cvalidators, :get_seo_w3cvalidators, :get_post_page_rank, :post_page_rank, :change_password,:update_password,:edit]
  include W3CValidators
  add_breadcrumb "seo index", :seo_index_path



  def index
    @result=Seo.most_recent
    respond_to do |format|
      format.html
      format.json do
        render :layout => false
      end #{render json: @result}
    end
  end

  def suggestion
  render :layout => false

  end

  def post_page_rank
    @page = MetaInspector.new(params[:seo][:site_uri])
    @seo_google_page_rank=SeoParams.pr(params[:seo][:site_uri])
    @seo_google_page_index=SeoParams.gp(params[:seo][:site_uri])
    # @seo_yahoo_page_index=SeoParams.yahoo(params[:seo][:site_uri])
    @seo_bing_page_index=SeoParams.bing(params[:seo][:site_uri])
    @seo_dmoz_page_index=SeoParams.dmoz(params[:seo][:site_uri])
    @seo_google_plus_ones_count=SeoParams.plus_ones(params[:seo][:site_uri])
    # @seo_facebook_likes=SeoParams::likes(params[:seo][:site_uri])
    # @seo_tweets=SeoParams.tweets(params[:seo][:site_uri])

    @seo_google_position=SeoParams.gposition(params[:seo][:site_uri],"Dehradun")
    @seo_alexa_pagerank=SeoParams.ar(params[:seo][:site_uri])
  end

  def get_page_rank
    add_breadcrumb "seo page rank", seo_get_page_rank_path
  end

  def get_seo_w3cvalidators
    @result=Seo.most_recent
    add_breadcrumb "seo w3cvalidators", seo_get_seo_w3cvalidators_path
  end

  def seo_get_post_page_rank
  end

  def get_page_keywords
    add_breadcrumb "seo page keywords", seo_get_page_keywords_path
  end

  def seo_get_meta_tags
    add_breadcrumb "seo meta tags", seo_get_meta_tags_path
  end

=begin
  def download_pdf
    @product = User.all

    pdf = Prawn::Document.new
    table_data = Array.new
    table_data << ["User name", "User email"]
    @product.each do |p|
      table_data << [p.name, p.email]
    end
    pdf.table(table_data, :width => 500, :cell_style => { :inline_format => true })
    send_data pdf.render, filename: 'test.pdf', type: 'application/pdf', :disposition => 'inline'
  end
=end
  def download_pdf
    var_id=params[:var]
    @seo_list = Seo.find(var_id)
    puts @seo_list.site_uri
    pdf = Prawn::Document.new
    table_data = Array.new
    table_data << ["WebSite:", @seo_list.site_uri]
    table_data << ["W3C Validation", "Errors"]
    @data_array = (@seo_list.error_data).split("ERROR;")
    @i=0
    @data_array.each do |dr|
      table_data << [@i,(dr.html_safe).delete('\\')]
      @i=@i+1
    end
    pdf.table(table_data, :width => 500, :cell_style => { :inline_format => true })
    send_data pdf.render, filename:'test.pdf', type:'application/pdf', :disposition => 'inline'
  end

  def download
    var_id=params[:var]
    @seo_list = Seo.find(var_id)
    respond_to do |format|
      format.xlsx{ render xlsx:'download',filename:"download.xlsx", type:'application/xlsx'}
      end
  end
  def seo_testpage
=begin
      @validator = MarkupValidator.new

       override the DOCTYPE
      @validator.set_doctype!(:html32)

      if params[:seo][:site_uri] != ""
        uri_val = params[:seo][:site_uri]

        @results = @validator.validate_uri(uri_val)

        @seo = Seo.new(seo_params)

        @error_data=@results.errors

        table_data = Array.new
        @error_data.each do |p|
          table_data << p.to_s
        end
        @seo.error_data=table_data
        if @seo.save
          flash[:success] = "Error data Save Successfully"
        else
          flash[:error] = "Error to save data in seo model"
        end

        if @results.errors.length == 1
          flash[:notice] = 'Uri is not valid'
          render welcome_index_path
        end
      else
        flash[:notice] = 'Uri is Empty please put correct web site URL'
        render welcome_index_path
      end
=end
  end

  def seo_w3cvalidators
    #@page = MetaInspector.new(params[:seo][:site_uri])
    #graph = Koala::Facebook::API.new('CAACEdEose0cBAFO7XmLiZCvh8mBUW1i3qwPqkUWIAQHLjQUbpyw2UXfjcg8F34ZB5iFcDmP66ZA8dDSvdzXzjRpZCWAes4Gc1Y55diuW02AyZBwQh75JB22QZBzZCOkz1xZAV97QptKZCj1zjrcyEvVHlJMRy9ZBoWW3OejOgZCAigkiDNv9VzZAxJft5ScSQdRVkdWoxwNiKL16h9naIZCxbbLca');
    #@likes = graph.get_object("Rockinghats")["likes"]
=begin
      PageRankr.proxy_service = PageRankr::ProxyServices::Random.new([
                                                                         'http://user:password@192.168.1.1:50501',
                                                                         'http://user:password@192.168.1.2:50501'
                                                                     ])

      @sit_page_rank=PageRankr.backlinks('www.soarlogic.com', :google) #=> {:google=>161000, :bing=>208000000}
=end

=begin
      @soar_site= PageRankr.backlinks('www.soarlogic.com', :google)
      @soar_site_alex= PageRankr.backlinks('www.soarlogic.com', :alexa)

      @soar_site_index= PageRankr.indexes('www.soarlogic.com', :google)
      @soar_site_rank= PageRankr.ranks('www.google.com', :google)

      @soar_site_rank_moz= PageRankr.ranks('www.soarlogic.com', :moz_rank)
      @soar_site_rank_Social= PageRankr.socials('www.google.com', :linked_in)

      tracker = PageRankr::Ranks::Google.new("soarlogic.com")
      tracker.run #=> 2
=end


    #@seo =SeoParams.tweets("soarlogic.com")
   # params[:seo][:site_uri]='www.soarlogic.com'


=begin
    #@seo =SeoParams.likes("soarlogic.com")
    #@seo =SeoParams::Facebook.new("soarlogic.com").likes
    # Direct connection
    solr = RSolr.connect :url => 'http://solrserver.com'

    # Connecting over a proxy server
    solr = RSolr.connect :url => 'http://solrserver.com', :proxy=>'http://user:pass@proxy.example.com:8080'

    # send a request to /select
    #response = solr.get 'select', :params => {:q => '*:*'}

    # send a request to /catalog
    response = solr.get 'catalog', :params => {:q => '*:*'}

    puts response;
    solr = RSolr.connect(:read_timeout => 120, :open_timeout => 120)
=end
    @validator = MarkupValidator.new

# override the DOCTYPE
    @validator.set_doctype!(:html32)

# turn on debugging messages
    #@validator.set_debug!(true)

    #file = File.dirname('/Applications/xampp/htdocs/rbeyondforth/app/views/market')+'/market_grade.html.erb'
    #@seo = Seo.new(seo_params)


    if params[:seo][:site_uri] != ""
      uri_val = params[:seo][:site_uri]
      #File.read(file)


      @results = @validator.validate_uri(uri_val)

      @seo = Seo.new(seo_params)

      @error_data=@results.errors
      count=0 #variable to count no. of errors
      table_data = Array.new
         @error_data.each do |p|
          table_data << p.to_s
           count=count+1
        end
      @seo.error_data=table_data
      @seo.errnum=count
        if @seo.save
          flash[:success] = "Error data Save Successfully"

          @variable=@seo.id
        else
          flash[:error] = "Error to save data in seo model"
        end

        if @results.errors.length == 1
          flash[:notice] = 'Uri is not valid'
          render welcome_index_path
        end
    else
      flash[:notice] = 'Uri is Empty please put correct web site URL'
      render welcome_index_path
    end
=begin
    @seo = Seo.new
    @seo[:site_uri]=params[:seo][:site_uri];
    @seo[:error_data]=@results.errors;
    @seo.save
=end
    add_breadcrumb "seo w3cvalidators", seo_seo_w3cvalidators_path
  end
#end of index

  def google_page_index
  end

  def google_page_rank
  end

  def google_page_rank_keywords
  end

  def yahoo_page_index
  end

  def bing_page_index
  end

  def facebook_post
  end

  def facebook_likes
  end

  def facebook_comments
  end

  def facebook_shares
  end

  def twitter_twitts
  end

  def twitter_follower
  end

  def twitter_following
  end

  def post_meta_tags
    @page = MetaInspector.new(params[:seo][:site_uri])
  end

  def seo_get_page_links
    add_breadcrumb "seo page links", seo_get_page_links_path
  end

  def post_page_links
    @page = MetaInspector.new(params[:seo][:site_uri])
    @page_links_internal=@page.links.internal
    @page_links_external=@page.links.external
  end

  def post_page_keywords
    @page = MetaInspector.new(params[:seo][:site_uri])
  end

  def post_unique_words
    @list = Wordlist::FlatFile.new('list.txt')
    @list.each_unique do |word|
      puts word
    end
  end

  def get_page_speed
    add_breadcrumb "seo page speed", seo_get_page_speed_path
  end

  def post_page_speed
    # request = PageSpeed::Request::new("www.google.com", 'AIzaSyCigRkTRFrj827jyzrsG1XAHIYgizQ3f9E', 'desktop')
    # @results=PageSpeed::Parser.parse(request.pagespeed)
    # puts @results
  end

  def forgot_password_send_email
    user = User.find_by_email('bist.anil12@soarlogic.com')
    user.send_password_reset if user
    redirect_to seo_seo_w3cvalidators_path, :notice => "Email sent with password reset instructions."
  end

  def validate
    begin
      uri = URI.parse(url)
      if uri.class != URI::HTTP
        errors.add(:url, 'Only HTTP protocol addresses can be used')
      end
    rescue URI::InvalidURIError
      errors.add(:url, 'The format of the url is not valid.')
    end
  end

  def compose_mail
    @recipient = recipient
  end

  def valid?(uri)
    !!URI.parse(uri)
  rescue URI::InvalidURIError
    false
  end


  private
  def seo_params
    params.require(:seo).permit(:site_uri,:error_data)
  end

end

