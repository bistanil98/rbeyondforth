class MarketController < ApplicationController

  layout 'market_layout', :except => [:index]

  before_action :require_login
  def market_grade
    add_breadcrumb "market grade", market_market_grade_path
  end

  def market_grade_report
    add_breadcrumb "market grade report", market_market_grade_report_path
  end

  def certification
    add_breadcrumb "certification", market_certification_path
  end

  def webinars
    add_breadcrumb "webnairs", market_webinars_path
  end

  def market_basic_dashboard
    add_breadcrumb "maket basic dashboard", market_market_basic_dashboard_path
  end

  def market_interactive_charts
    add_breadcrumb "market interactive charts", market_market_interactive_charts_path
  end

  def market_multiple_views
    add_breadcrumb "market interactive views", market_market_multiple_views_path
  end

  def competitors
    add_breadcrumb "competitors", market_competitors_path
  end

  def event
    add_breadcrumb "event", market_event_path
  end

  def redirect

  end

  def callback

    response = client.fetch_access_token!

    session[:access_token] = response['access_token']

    redirect_to url_for(:action => :analytics)
  end

  def analytics

    service = Google::Apis::AnalyticsV3::AnalyticsService.new

    service.authorization = client

    @account_summaries = service.list_account_summaries
  end
end
