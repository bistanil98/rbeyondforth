=begin
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['868060673300983'], ENV['35e2a8611f2c19f3a5e26e132c7fea21']
end
=end

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, 868060673300983, '35e2a8611f2c19f3a5e26e132c7fea21',
           :scope => 'email,user_birthday,manage_pages,user_events', :display => 'popup', :info_fields => 'name,email'

  #provider :twitter, 'ltBRXLY3wnyGr5XnG4EYAfoQ1', 'EVAmMP7b3IDck8814AoF5WDwud0BsMcgnIzmQ7tv49Y2WURFfH',:setup => true

#:scope => 'email,manage_pages,user_events,user_location,user_birthday'
  provider :twitter, "ltBRXLY3wnyGr5XnG4EYAfoQ1", "EVAmMP7b3IDck8814AoF5WDwud0BsMcgnIzmQ7tv49Y2WURFfH",
         {
             :secure_image_url => 'true',
             :image_size => 'original',
             :authorize_params => {
                 :force_login => 'true',
                 :lang => 'en'
             }
         }

  provider :linkedin, "75u7kw8w6ibns5", "yaIzNBfVX60rw0Wx", :scope => 'r_fullprofile r_emailaddress r_network',
         :fields => ["id", "email-address", "first-name", "last-name", "headline", "industry", "picture-url",
                     "public-profile-url", "location", "connections"]

  provider :google_oauth2, ENV["1002663303461-etsitapfis57fc1i2a6i12qul98brlgq.apps.googleusercontent.com"],
             ENV["ON9v4ijbmcjCuyru9MWrvJ4l"],
             {
                 :name => "google",
                 :scope => "email, profile, plus.me, http://gdata.youtube.com",
                 :prompt => "select_account",
                 :image_aspect_ratio => "square",
                 :image_size => 50
             }

  provider :github, ENV['d04948143e7122d1a1a9'], ENV['850092ac862c730583c9e4432da5fba7a2290c8c'], scope: "user,repo,gist"



end
