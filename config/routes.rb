Rails.application.routes.draw {

  get 'users/index'

  get 'users/login'

  get 'users/fb_login'

  get 'users/twttr_login'

  get 'users/linkedin_login'

  get 'users/google_login'

  get 'users/git_login'

  get 'users/pinterest_login'

  get 'users/logout'

  post 'sessions/create'

  get 'sessions/destroy'

  get 'users/profile'

  get 'users/register'

  get 'users/change_password'

  post 'users/update_password'

  get 'users/forgot_password'

  get 'users/edit'

  get 'users/edit/id'

  post 'users/create'

  post 'users/upload_image'

  get 'users/delete'

  post 'users/update'

  get 'users/show'

  post 'users/forgot_password_send_email'

  get 'market/index'

  get 'market/google_analytics'

  get 'market/facebook_pixel'

  get 'market/market_basic_dashboard'

  get 'market/market_interactive_charts'

  get 'market/market_multiple_views'

  get 'market/market_grade'

  get 'market/market_grade_report'

  get 'market/certification'

  get 'market/webinars'

  get'market/event'

  get'market/competitors'

  get 'welcome/index'

  get 'welcome/home'

  get 'seo/index'

  post 'password_reset/create'

  post 'password_reset/new'

  post 'social_media/post_on_my_wall'

  post 'social_media/post_on_my_page_wall'

  resources :password_resets

  get 'auth/facebook/callback', to: 'sessions#create_fb'

  get 'auth/twitter/callback', to: 'sessions#create_twttr'

  get 'auth/linkedin/callback', to: 'sessions#create_linkedin'

  get 'auth/google_oauth2/callback', to: 'sessions#create_google'

  get 'auth/pinterest/callback', to: 'sessions#create_pinterest'

  get 'auth/github/callback', to: 'sessions#create_github'

  get 'logout', to: 'sessions#destroy'

  get 'social_media/index'

  get 'social_media/fb_page_display'

  get 'social_media/fb_data'

  get 'social_media/fb_like'

  get 'social_media/fb_unlike'

  get 'social_media/twitter_index'

  get 'social_media/google_index'

  get 'social_media/linkedin_index'

  get 'social_media/post_on_linkedin_wall'
  # get 'social_media/linkedin_oauth_url'

  # get 'social_media/oauth_account'

  get 'social_media/github_index'

  get 'social_media/pinterest_index'

  post 'social_media/post_on_twitter_wall'

  get 'social_media/twitter_notification'

  get 'social_media/refresh_twtr_home'

  post 'seo/seo_w3cvalidators'
  #adding a test page to check the url form submittion blockage in get_seo_w3cvalidators.
  get 'seo/seo_testpage'

  get 'seo/get_page_rank'

  post 'seo/post_page_rank'

  get 'seo/get_seo_w3cvalidators'

  get 'seo/get_post_page_rank'

  post 'seo/modal'

  get 'seo/suggestion'

  get "seo/download_pdf"

  get 'seo/download'

  get 'seo/get_page_keywords'

  get 'seo/get_unique_words'

  post 'seo/post_unique_words'

  get 'seo/get_meta_tags'

  get 'seo/get_page_links'

  post 'seo/post_meta_tags'

  post 'seo/post_page_links'

  post 'seo/post_page_keywords'

  get 'seo/get_page_speed'

  post 'seo/post_page_speed'

  get 'seo/get_on_offpage'

  get 'seo/get_seo_report'

  get "/" => "users#login", :as => "root"

  "map.webmaster_verification"

  devise_for :admins

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

}
