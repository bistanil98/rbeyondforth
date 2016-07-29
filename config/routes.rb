Rails.application.routes.draw {

  get 'users/index'

  get 'users/login'

  get 'users/fb_login'

  get 'users/tw_login'

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

  get 'market/market_grade'

  get 'market/market_grade_report'

  get 'market/certification'

  get 'market/webinars'

  get'market/event'

  get'market/competitors'

  get 'welcome/index'

  get 'welcome/home'

  post 'admins/index'

  get 'admins/profile'

  get 'admins/login'

  get 'admins/logout'

  get 'admins/change_password'

  get 'admins/create_menu'

  get 'admins/create_submenu'

  get 'seo/index'

  post 'password_reset/create'

  post 'password_reset/new'

  post 'social_media/post_on_my_wall'

  post 'social_media/post_on_my_page_wall'

  resources :password_resets



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # 'welcome#index'
  #match ':controller(/:action)'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  get 'auth/:provider/callback', to: 'sessions#create_fb'

  get 'logout', to: 'sessions#destroy'

  get 'social_media/index'

  get 'social_media/twitter_index'

  get 'social_media/fb_page_display'

  get 'social_media/twitter_index'

  post 'social_media/post_on_twitter_wall'

  get 'social_media/twitter_notification'

  post 'seo/seo_w3cvalidators'

  get 'seo/get_page_rank'

  post 'seo/post_page_rank'

  get 'seo/get_seo_w3cvalidators'

  get 'seo/get_post_page_rank'

  get 'admins/charts'

  get 'admins/dashboard'

  get 'admins/reports'

  get 'admins/forms'

  get 'admins/elements'

  get 'admins/grid'

  get 'admins/blank'

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

}
