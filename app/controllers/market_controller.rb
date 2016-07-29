class MarketController < ApplicationController

  before_action
  def market_grade
    add_breadcrumb "market grade", market_market_grade_path
  end

  def market_grade_report
  end

  def certification

  end

  def webinars

  end

  def competitors

  end

  def event

  end

  def redirect
    client = Signet::OAuth2::Client.new({
                                            client_id: ENV.fetch('1002663303461-etsitapfis57fc1i2a6i12qul98brlgq.apps.googleusercontent.com'),
                                            client_secret: ENV.fetch('4ijbmcjCuyru9MWrvJ4l'),
                                            authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
                                            scope: Google::Apis::AnalyticsV3::AUTH_ANALYTICS_READONLY,
                                            redirect_uri: url_for(:action => :callback)
                                        })

    redirect_to client.authorization_uri.to_s
  end

  def callback
    client = Signet::OAuth2::Client.new({
                                            client_id: ENV.fetch('1002663303461-etsitapfis57fc1i2a6i12qul98brlgq.apps.googleusercontent.com'),
                                            client_secret: ENV.fetch('4ijbmcjCuyru9MWrvJ4l'),
                                            token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
                                            redirect_uri: url_for(:action => :callback),
                                            code: params[:code]
                                        })

    response = client.fetch_access_token!

    session[:access_token] = response['access_token']

    redirect_to url_for(:action => :analytics)
  end

  def analytics
    client = Signet::OAuth2::Client.new(access_token: session[:access_token])

    service = Google::Apis::AnalyticsV3::AnalyticsService.new

    service.authorization = client

    @account_summaries = service.list_account_summaries
  end
end
