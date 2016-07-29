class SeoController < ApplicationController

  require  'uri'
  require 'page_rankr'
  require 'page_rankr/ranks/google'
  require  'seo_params'
  require 'rubygems'
  require 'rsolr'
  require 'w3c_validators'
  require 'koala'
  require "fb_graph"
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



  respond_to :html, :json, :pdf, :xlsx

  layout 'seo_layout', :only => [:index, :modal, :get_on_offpage, :get_seo_report, :get_page_speed, :post_page_speed, :post_page_keywords, :post_unique_words, :post_page_links, :post_meta_tags, :get_page_links, :get_unique_words, :get_meta_tags, :get_page_keywords, :suggestion,:seo_w3cvalidators, :get_seo_w3cvalidators, :get_post_page_rank, :post_page_rank, :change_password,:update_password,:edit]
  include W3CValidators



  def index
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
  end

  def get_seo_w3cvalidators
  end

  def seo_get_post_page_rank
  end

  def get_page_keywords
  end

  def seo_get_meta_tags
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
    @seo_list = Seo.find_by_id(1)
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
    send_data pdf.render, filename: 'test.pdf', type: 'application/pdf', :disposition => 'inline'
  end

  def download
    @seo_list = Seo.find_by_id(1)
    respond_to do |format|
      format.xlsx{ render xlsx: 'download',filename: "download.xlsx", type: 'application/xlsx'}
      end
  end

  def seo_w3cvalidators
    @page = MetaInspector.new(params[:seo][:site_uri])
    graph = Koala::Facebook::API.new('CAACEdEose0cBAFO7XmLiZCvh8mBUW1i3qwPqkUWIAQHLjQUbpyw2UXfjcg8F34ZB5iFcDmP66ZA8dDSvdzXzjRpZCWAes4Gc1Y55diuW02AyZBwQh75JB22QZBzZCOkz1xZAV97QptKZCj1zjrcyEvVHlJMRy9ZBoWW3OejOgZCAigkiDNv9VzZAxJft5ScSQdRVkdWoxwNiKL16h9naIZCxbbLca');
#    @likes = graph.get_object("Rockinghats")["likes"]
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
=begin
    @seo = Seo.new
    @seo[:site_uri]=params[:seo][:site_uri];
    @seo[:error_data]=@results.errors;
    @seo.save
=end

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
#{"kind"=>"pagespeedonline#result", "id"=>"https://www.google.co.in/?gfe_rd=cr&ei=TEhVVuz5J4fD9AW69LPQBQ&gws_rd=ssl", "responseCode"=>200, "title"=>"Google", "ruleGroups"=>{"SPEED"=>{"score"=>92}}, "pageStats"=>{"numberResources"=>12, "numberHosts"=>5, "totalRequestBytes"=>"3275", "numberStaticResources"=>8, "htmlResponseBytes"=>"189206", "imageResponseBytes"=>"45498", "javascriptResponseBytes"=>"773852", "otherResponseBytes"=>"1869", "numberJsResources"=>4}, "formattedResults"=>{"locale"=>"en_US", "ruleResults"=>{"AvoidLandingPageRedirects"=>{"localizedRuleName"=>"Avoid landing page redirects", "ruleImpact"=>7.0, "groups"=>["SPEED"], "summary"=>{"format"=>"Your page has {{NUM_REDIRECTS}} redirects. Redirects introduce additional delays before the page can be loaded.", "args"=>[{"type"=>"INT_LITERAL", "key"=>"NUM_REDIRECTS", "value"=>"2"}]}, "urlBlocks"=>[{"header"=>{"format"=>"{{BEGIN_LINK}}Avoid landing page redirects{{END_LINK}} for the following chain of redirected URLs.", "args"=>[{"type"=>"HYPERLINK", "key"=>"LINK", "value"=>"https://developers.google.com/speed/docs/insights/AvoidRedirects"}]}, "urls"=>[{"result"=>{"format"=>"{{FIRST_URL}}", "args"=>[{"type"=>"URL", "key"=>"FIRST_URL", "value"=>"http://www.google.com/"}]}}, {"result"=>{"format"=>"{{REDIRECTED_URL}}", "args"=>[{"type"=>"URL", "key"=>"REDIRECTED_URL", "value"=>"http://www.google.co.in/?gfe_rd=cr&ei=TEhVVuz5J4fD9AW69LPQBQ"}]}}, {"result"=>{"format"=>"{{REDIRECTED_URL}}", "args"=>[{"type"=>"URL", "key"=>"REDIRECTED_URL", "value"=>"https://www.google.co.in/?gfe_rd=cr&ei=TEhVVuz5J4fD9AW69LPQBQ&gws_rd=ssl"}]}}]}]}, "EnableGzipCompression"=>{"localizedRuleName"=>"Enable compression", "ruleImpact"=>0.0, "groups"=>["SPEED"], "summary"=>{"format"=>"You have compression enabled. Learn more about {{BEGIN_LINK}}enabling compression{{END_LINK}}.", "args"=>[{"type"=>"HYPERLINK", "key"=>"LINK", "value"=>"https://developers.google.com/speed/docs/insights/EnableCompression"}]}}, "LeverageBrowserCaching"=>{"localizedRuleName"=>"Leverage browser caching", "ruleImpact"=>0.0, "groups"=>["SPEED"], "summary"=>{"format"=>"You have enabled browser caching. Learn more about {{BEGIN_LINK}}browser caching recommendations{{END_LINK}}.", "args"=>[{"type"=>"HYPERLINK", "key"=>"LINK", "value"=>"https://developers.google.com/speed/docs/insights/LeverageBrowserCaching"}]}}, "MainResourceServerResponseTime"=>{"localizedRuleName"=>"Reduce server response time", "ruleImpact"=>0.0, "groups"=>["SPEED"], "summary"=>{"format"=>"Your server responded quickly. Learn more about {{BEGIN_LINK}}server response time optimization{{END_LINK}}.", "args"=>[{"type"=>"HYPERLINK", "key"=>"LINK", "value"=>"https://developers.google.com/speed/docs/insights/Server"}]}}, "MinifyCss"=>{"localizedRuleName"=>"Minify CSS", "ruleImpact"=>0.0, "groups"=>["SPEED"], "summary"=>{"format"=>"Your CSS is minified. Learn more about {{BEGIN_LINK}}minifying CSS{{END_LINK}}.", "args"=>[{"type"=>"HYPERLINK", "key"=>"LINK", "value"=>"https://developers.google.com/speed/docs/insights/MinifyResources"}]}}, "MinifyHTML"=>{"localizedRuleName"=>"Minify HTML", "ruleImpact"=>0.0534, "groups"=>["SPEED"], "summary"=>{"format"=>"Compacting HTML code, including any inline JavaScript and CSS contained in it, can save many bytes of data and speed up download and parse times."}, "urlBlocks"=>[{"header"=>{"format"=>"{{BEGIN_LINK}}Minify HTML{{END_LINK}} for the following resources to reduce their size by {{SIZE_IN_BYTES}} ({{PERCENTAGE}} reduction).", "args"=>[{"type"=>"HYPERLINK", "key"=>"LINK", "value"=>"https://developers.google.com/speed/docs/insights/MinifyResources"}, {"type"=>"BYTES", "key"=>"SIZE_IN_BYTES", "value"=>"534B"}, {"type"=>"PERCENTAGE", "key"=>"PERCENTAGE", "value"=>"1%"}]}, "urls"=>[{"result"=>{"format"=>"Minifying {{URL}} could save {{SIZE_IN_BYTES}} ({{PERCENTAGE}} reduction) after compression.", "args"=>[{"type"=>"URL", "key"=>"URL", "value"=>"https://www.google.co.in/?gfe_rd=cr&ei=TEhVVuz5J4fD9AW69LPQBQ&gws_rd=ssl"}, {"type"=>"BYTES", "key"=>"SIZE_IN_BYTES", "value"=>"534B"}, {"type"=>"PERCENTAGE", "key"=>"PERCENTAGE", "value"=>"1%"}]}}]}]}, "MinifyJavaScript"=>{"localizedRuleName"=>"Minify JavaScript", "ruleImpact"=>0.2537, "groups"=>["SPEED"], "summary"=>{"format"=>"Compacting JavaScript code can save many bytes of data and speed up downloading, parsing, and execution time."}, "urlBlocks"=>[{"header"=>{"format"=>"{{BEGIN_LINK}}Minify JavaScript{{END_LINK}} for the following resources to reduce their size by {{SIZE_IN_BYTES}} ({{PERCENTAGE}} reduction).", "args"=>[{"type"=>"HYPERLINK", "key"=>"LINK", "value"=>"https://developers.google.com/speed/docs/insights/MinifyResources"}, {"type"=>"BYTES", "key"=>"SIZE_IN_BYTES", "value"=>"1.3KiB"}, {"type"=>"PERCENTAGE", "key"=>"PERCENTAGE", "value"=>"1%"}]}, "urls"=>[{"result"=>{"format"=>"Minifying {{URL}} could save {{SIZE_IN_BYTES}} ({{PERCENTAGE}} reduction) after compression.", "args"=>[{"type"=>"URL", "key"=>"URL", "value"=>"https://www.google.co.in/xjs/_/js/k=xjs.qd.en.CNaf2ao7V_s.O/m=sx,c,sb,cdos,cr,elog,jsa,r,hsm,qsm,j,p,d,csi/am=ICkIACCI-M4HgbDCGBOkJhBhOQ/rt=j/d=1/t=zcms/rs=ACT90oGZFmgtTCS7bCQZKz52JBKPrYCpkw"}, {"type"=>"BYTES", "key"=>"SIZE_IN_BYTES", "value"=>"1.3KiB"}, {"type"=>"PERCENTAGE", "key"=>"PERCENTAGE", "value"=>"1%"}]}}]}]}, "MinimizeRenderBlockingResources"=>{"localizedRuleName"=>"Eliminate render-blocking JavaScript and CSS in above-the-fold content", "ruleImpact"=>0.0, "groups"=>["SPEED"], "summary"=>{"format"=>"You have no render-blocking resources. Learn more about {{BEGIN_LINK}}removing render-blocking resources{{END_LINK}}.", "args"=>[{"type"=>"HYPERLINK", "key"=>"LINK", "value"=>"https://developers.google.com/speed/docs/insights/BlockingJS"}]}}, "OptimizeImages"=>{"localizedRuleName"=>"Optimize images", "ruleImpact"=>0.1874, "groups"=>["SPEED"], "summary"=>{"format"=>"Properly formatting and compressing images can save many bytes of data."}, "urlBlocks"=>[{"header"=>{"format"=>"{{BEGIN_LINK}}Optimize the following images{{END_LINK}} to reduce their size by {{SIZE_IN_BYTES}} ({{PERCENTAGE}} reduction).", "args"=>[{"type"=>"HYPERLINK", "key"=>"LINK", "value"=>"https://developers.google.com/speed/docs/insights/OptimizeImages"}, {"type"=>"BYTES", "key"=>"SIZE_IN_BYTES", "value"=>"1.7KiB"}, {"type"=>"PERCENTAGE", "key"=>"PERCENTAGE", "value"=>"9%"}]}, "urls"=>[{"result"=>{"format"=>"Losslessly compressing {{URL}} could save {{SIZE_IN_BYTES}} ({{PERCENTAGE}} reduction).", "args"=>[{"type"=>"URL", "key"=>"URL", "value"=>"https://www.google.co.in/images/nav_logo242.png"}, {"type"=>"BYTES", "key"=>"SIZE_IN_BYTES", "value"=>"1.7KiB"}, {"type"=>"PERCENTAGE", "key"=>"PERCENTAGE", "value"=>"9%"}]}}]}]}, "PrioritizeVisibleContent"=>{"localizedRuleName"=>"Prioritize visible content", "ruleImpact"=>0.0, "groups"=>["SPEED"], "summary"=>{"format"=>"You have the above-the-fold content properly prioritized. Learn more about {{BEGIN_LINK}}prioritizing visible content{{END_LINK}}.", "args"=>[{"type"=>"HYPERLINK", "key"=>"LINK", "value"=>"https://developers.google.com/speed/docs/insights/PrioritizeVisibleContent"}]}}}}, "version"=>{"major"=>1, "minor"=>15}}
  #{"kind"=>"pagespeedonline#result", "id"=>"https://www.google.co.in/?gfe_rd=cr&ei=GklVVqXgNZSB4AKQmIGoCw&gws_rd=ssl", "responseCode"=>200, "title"=>"Google", "score"=>92, "pageStats"=>{"numberResources"=>12, "numberHosts"=>5, "totalRequestBytes"=>"2917", "numberStaticResources"=>8, "htmlResponseBytes"=>"188699", "imageResponseBytes"=>"45498", "javascriptResponseBytes"=>"772535", "otherResponseBytes"=>"1863", "numberJsResources"=>4}, "formattedResults"=>{"locale"=>"en_US", "ruleResults"=>{"AvoidLandingPageRedirects"=>{"localizedRuleName"=>"Avoid landing page redirects", "ruleImpact"=>7.0, "urlBlocks"=>[{"header"=>{"format"=>"Your page has $1 redirects. Redirects introduce additional delays before the page can be loaded.", "args"=>[{"type"=>"INT_LITERAL", "value"=>"2"}]}}, {"header"=>{"format"=>"Avoid landing page redirects for the following chain of redirected URLs.", "args"=>[{"type"=>"HYPERLINK", "value"=>"https://developers.google.com/speed/docs/insights/AvoidRedirects"}]}, "urls"=>[{"result"=>{"format"=>"$1", "args"=>[{"type"=>"URL", "value"=>"http://www.google.com/"}]}}, {"result"=>{"format"=>"$1", "args"=>[{"type"=>"URL", "value"=>"http://www.google.co.in/?gfe_rd=cr&ei=GklVVqXgNZSB4AKQmIGoCw"}]}}, {"result"=>{"format"=>"$1", "args"=>[{"type"=>"URL", "value"=>"https://www.google.co.in/?gfe_rd=cr&ei=GklVVqXgNZSB4AKQmIGoCw&gws_rd=ssl"}]}}]}]}, "EnableGzipCompression"=>{"localizedRuleName"=>"Enable compression", "ruleImpact"=>0.0, "urlBlocks"=>[{"header"=>{"format"=>"You have compression enabled. Learn more about enabling compression.", "args"=>[{"type"=>"HYPERLINK", "value"=>"https://developers.google.com/speed/docs/insights/EnableCompression"}]}}]}, "LeverageBrowserCaching"=>{"localizedRuleName"=>"Leverage browser caching", "ruleImpact"=>0.0, "urlBlocks"=>[{"header"=>{"format"=>"You have enabled browser caching. Learn more about browser caching recommendations.", "args"=>[{"type"=>"HYPERLINK", "value"=>"https://developers.google.com/speed/docs/insights/LeverageBrowserCaching"}]}}]}, "MainResourceServerResponseTime"=>{"localizedRuleName"=>"Reduce server response time", "ruleImpact"=>0.0, "urlBlocks"=>[{"header"=>{"format"=>"Your server responded quickly. Learn more about server response time optimization.", "args"=>[{"type"=>"HYPERLINK", "value"=>"https://developers.google.com/speed/docs/insights/Server"}]}}]}, "MinifyCss"=>{"localizedRuleName"=>"Minify CSS", "ruleImpact"=>0.0, "urlBlocks"=>[{"header"=>{"format"=>"Your CSS is minified. Learn more about minifying CSS.", "args"=>[{"type"=>"HYPERLINK", "value"=>"https://developers.google.com/speed/docs/insights/MinifyResources"}]}}]}, "MinifyHTML"=>{"localizedRuleName"=>"Minify HTML", "ruleImpact"=>0.0536, "urlBlocks"=>[{"header"=>{"format"=>"Compacting HTML code, including any inline JavaScript and CSS contained in it, can save many bytes of data and speed up download and parse times."}}, {"header"=>{"format"=>"Minify HTML for the following resources to reduce their size by $2 ($3 reduction).", "args"=>[{"type"=>"HYPERLINK", "value"=>"https://developers.google.com/speed/docs/insights/MinifyResources"}, {"type"=>"BYTES", "value"=>"536B"}, {"type"=>"PERCENTAGE", "value"=>"1%"}]}, "urls"=>[{"result"=>{"format"=>"Minifying $1 could save $2 ($3 reduction) after compression.", "args"=>[{"type"=>"URL", "value"=>"https://www.google.co.in/?gfe_rd=cr&ei=GklVVqXgNZSB4AKQmIGoCw&gws_rd=ssl"}, {"type"=>"BYTES", "value"=>"536B"}, {"type"=>"PERCENTAGE", "value"=>"1%"}]}}]}]}, "MinifyJavaScript"=>{"localizedRuleName"=>"Minify JavaScript", "ruleImpact"=>0.2526, "urlBlocks"=>[{"header"=>{"format"=>"Compacting JavaScript code can save many bytes of data and speed up downloading, parsing, and execution time."}}, {"header"=>{"format"=>"Minify JavaScript for the following resources to reduce their size by $2 ($3 reduction).", "args"=>[{"type"=>"HYPERLINK", "value"=>"https://developers.google.com/speed/docs/insights/MinifyResources"}, {"type"=>"BYTES", "value"=>"1.3KiB"}, {"type"=>"PERCENTAGE", "value"=>"1%"}]}, "urls"=>[{"result"=>{"format"=>"Minifying $1 could save $2 ($3 reduction) after compression.", "args"=>[{"type"=>"URL", "value"=>"https://www.google.co.in/xjs/_/js/k=xjs.qd.en.rm-KADU13PY.O/m=sx,c,sb,cdos,cr,elog,jsa,r,hsm,qsm,j,p,d,csi/am=IEkQAACCiO98EAgrjDEhNYEIywE/rt=j/d=1/t=zcms/rs=ACT90oEA0z8xkbeWhlSL9BmAPnu215_1wQ"}, {"type"=>"BYTES", "value"=>"1.3KiB"}, {"type"=>"PERCENTAGE", "value"=>"1%"}]}}]}]}, "MinimizeRenderBlockingResources"=>{"localizedRuleName"=>"Eliminate render-blocking JavaScript and CSS in above-the-fold content", "ruleImpact"=>0.0, "urlBlocks"=>[{"header"=>{"format"=>"You have no render-blocking resources. Learn more about removing render-blocking resources.", "args"=>[{"type"=>"HYPERLINK", "value"=>"https://developers.google.com/speed/docs/insights/BlockingJS"}]}}]}, "OptimizeImages"=>{"localizedRuleName"=>"Optimize images", "ruleImpact"=>0.1874, "urlBlocks"=>[{"header"=>{"format"=>"Properly formatting and compressing images can save many bytes of data."}}, {"header"=>{"format"=>"Optimize the following images to reduce their size by $2 ($3 reduction).", "args"=>[{"type"=>"HYPERLINK", "value"=>"https://developers.google.com/speed/docs/insights/OptimizeImages"}, {"type"=>"BYTES", "value"=>"1.7KiB"}, {"type"=>"PERCENTAGE", "value"=>"9%"}]}, "urls"=>[{"result"=>{"format"=>"Losslessly compressing $1 could save $2 ($3 reduction).", "args"=>[{"type"=>"URL", "value"=>"https://www.google.co.in/images/nav_logo242.png"}, {"type"=>"BYTES", "value"=>"1.7KiB"}, {"type"=>"PERCENTAGE", "value"=>"9%"}]}}]}]}, "PrioritizeVisibleContent"=>{"localizedRuleName"=>"Prioritize visible content", "ruleImpact"=>0.0, "urlBlocks"=>[{"header"=>{"format"=>"You have the above-the-fold content properly prioritized. Learn more about prioritizing visible content.", "args"=>[{"type"=>"HYPERLINK", "value"=>"https://developers.google.com/speed/docs/insights/PrioritizeVisibleContent"}]}}]}}}, "version"=>{"major"=>1, "minor"=>15}}
end

