
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '645777708916185', '87252084d91affd03e3ccce02e94fdac',
           :scope => 'email,user_about_me,user_birthday,manage_pages,user_events,publish_pages,publish_actions,user_posts,read_custom_friendlists,user_friends,public_profile,user_likes,user_photos,user_videos', :display => 'touch', :info_fields => 'name,email' , :image_size => 'square', :secure_image_url => 'false'

  #provider :twitter, 'ltBRXLY3wnyGr5XnG4EYAfoQ1', 'EVAmMP7b3IDck8814AoF5WDwud0BsMcgnIzmQ7tv49Y2WURFfH',:setup => true

#:scope => 'email,manage_pages,user_events,user_location,user_birthday'
  provider :twitter, "9KgIgsd0LoGJBpDTUxydENoMs", "6ohRmMBev9V5XNrQ6kDkk6p8cR6l9SlKd4NbVFIp7aNAG0biVb",
         {
             :secure_image_url => 'true',
             :image_size => 'original',
             :authorize_params => {
                 :force_login => 'true',
                 :lang => 'en'
             }
         }

  provider :linkedin, "758kyo0uadfbc3", "Hvp02e31GSzjAZk8", :scope => 'r_basicprofile r_emailaddress rw_company_admin w_share',
         :fields => ["id", "email-address", "first-name", "last-name", "headline", "industry", "picture-url",
                     "public-profile-url", "location", "connections"]

  provider :google_oauth2, "939462896934-j167tods36ru0n94iu0jgodh7gmpqe9k.apps.googleusercontent.com", "Q_aanuG49OGc5JWf3sdTcGyv",
             {
                 :scope => "email, profile, plus.me, http://gdata.youtube.com",
                 :prompt => "select_account",
                 :image_aspect_ratio => "square",
                 :image_size => 50
             }

  provider :github, "af9b61b23d61bff7bc9a", "7b14bd63115fd35ea957d928671ff67524465957", scope: "user,repo,gist"

  provider :pinterest, "4860332454765938014", "c8d089fb2cf7c7607d1af2f00006e19749453fa35d08a87c3fc970b7f65b007f", scope: "read_public,read_relationships,write_relationships"

end
