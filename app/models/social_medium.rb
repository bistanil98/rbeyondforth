class SocialMedium < ActiveRecord::Base

  belongs_to :user
  has_attached_file :profile_image, styles:{large:"600X600>",medium:"300x300>",thumb: "100x100>" }
  validates_attachment_content_type :profile_image, content_type: /\Aimage\/.*\z/

  def self.fb_omni(*args)
    auth1=args[0]
    auth2=args[1]
    oauth = Koala::Facebook::OAuth.new("645777708916185","87252084d91affd03e3ccce02e94fdac")
    new_access_info = oauth.exchange_access_token_info auth1.credentials.token

    new_access_token = new_access_info["access_token"]
    new_access_expires_at = 60.days.from_now
    case args.size
      when 1
        if where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).present?
          u=SocialMedium.find_by_id(where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).first)

          if u.update(token: new_access_token, expire_at: new_access_expires_at)
          puts "token updated successfully"
          else
            puts "token not updated to database"
          end

          where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).first do |u|
          end

        else
          if User.find_by_email(auth1.info.email).present?
            u=User.find_by_email(auth1.info.email).id
            puts "user_id with same email: #{u}"
            puts "creating new social_media with same email as rbeyond account"
          elsif SocialMedium.find_by_social_email(auth1.info.email).present?
            u=SocialMedium.find_by_id(where(social_email:auth1.info.email).first).id
            puts "creating new social_media with same email as other social_media putting user_id to the social_media"
          end

          where(provider:auth1.provider, uid:auth1.uid).create do |s_user|
            puts "now crearting social_media with user_id: #{u}"
            s_user.provider = auth1.provider
            s_user.user_id = u
            s_user.uid = auth1.uid
            s_user.profile_name = auth1.info.name
            s_user.profile_image = auth1.info.image
            s_user.token = new_access_token
            s_user.social_email = auth1.info.email
            s_user.expire_at = new_access_expires_at
            s_user.save!
          end
        end
      when 2

          if SocialMedium.exists?where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email,user_id:auth2)
            u=SocialMedium.find_by_id(where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).first)

            if u.update(token: new_access_token, expire_at: new_access_expires_at)
            puts "token updated successfully"
            else
              puts "token not updated to database"
            end

            where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).first do |u|
            end

          else
            where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).create do |s_user|
              s_user.provider = auth1.provider
              s_user.user_id = auth2
              s_user.uid = auth1.uid
              s_user.profile_name = auth1.info.name
              s_user.profile_image = auth1.info.image
              s_user.token = new_access_token
              s_user.social_email = auth1.info.email
              s_user.expire_at = new_access_expires_at
              s_user.save!
            end
          end
    end
  end#fb_omni ends here



  def self.twtr_omni(*args)
    auth1=args[0]
    auth2=args[1]
    if SocialMedium.exists?where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email,user_id:auth2)
      u=SocialMedium.find_by_id(where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).first)
      puts "twitter expire time: #{auth1.credentials.expires_at}"

      if u.update(token: auth1.credentials.token, expire_at: 60.days.from_now)
      puts "token updated successfully"
      else
        puts "token not updated to database"
      end

      where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).first do |u|
      end

    else
      where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).create do |s_user|
        s_user.provider = auth1.provider
        s_user.user_id = auth2
        s_user.uid = auth1.uid
        s_user.profile_name = auth1.info.name
        s_user.profile_image = auth1.info.image
        s_user.token = auth1.credentials.token
        s_user.social_email = auth1.info.email
        puts "twitter expire time: #{auth1.credentials.expires_at}"
        s_user.expire_at = 60.days.from_now
        s_user.save!
      end
    end
  end#twtr_omni ends here



  def self.google_omni(*args)

    auth1=args[0]
    auth2=args[1]
    case args.size
      when 1
        if where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).present?
          u=SocialMedium.find_by_id(where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).first)

          if u.update(token: auth1.credentials.token, expire_at: 2.hours.from_now)
          puts "token updated successfully"
          else
            puts "token not updated to database"
          end

          where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).first do |u|
          end

        else
          if User.find_by_email(auth1.info.email).present?
            u=User.find_by_email(auth1.info.email).id
            puts "user_id with same email: #{u}"
            puts "creating new social_media with same email as rbeyond account"
          elsif SocialMedium.find_by_social_email(auth1.info.email).present?
            u=SocialMedium.find_by_id(where(social_email:auth1.info.email).first).id
            puts "creating new social_media with same email as other social_media putting user_id to the social_media"
          end

          where(provider:auth1.provider, uid:auth1.uid).create do |s_user|
            puts "now crearting social_media with user_id: #{u}"
            s_user.provider = auth1.provider
            s_user.user_id = u
            s_user.uid = auth1.uid
            s_user.profile_name = auth1.info.name
            s_user.profile_image = auth1.info.image
            s_user.token = auth1.credentials.token
            s_user.social_email = auth1.info.email
            s_user.expire_at = 2.hours.from_now
            s_user.save!
          end
        end
      when 2

        if SocialMedium.exists?where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email,user_id:auth2)
          u=SocialMedium.find_by_id(where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).first)

          if u.update(token: auth1.credentials.token, expire_at: 2.hours.from_now)
          puts "token updated successfully"
          else
            puts "token not updated to database"
          end

          where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).first do |u|
          end

        else
          where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).create do |s_user|
            s_user.provider = auth1.provider
            s_user.user_id = auth2
            s_user.uid = auth1.uid
            s_user.profile_name = auth1.info.name
            s_user.profile_image = auth1.info.image
            s_user.token = auth1.credentials.token
            s_user.social_email = auth1.info.email
            s_user.expire_at = 2.hours.from_now
            s_user.save!
          end
        end
    end

  end#google_omni ends here

  def self.linkedin_omni(*args)
    auth1=args[0]
    auth2=args[1]
    if SocialMedium.exists?where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email,user_id:auth2)
      u=SocialMedium.find_by_id(where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).first)

      if u.update(token: auth1.credentials.token, expire_at: (DateTime.strptime("#{auth1.credentials.expires_at}","%s")))
      puts "token updated successfully"
      else
        puts "token not updated to database"
      end

      where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).first do |u|
      end

    else
      where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).create do |s_user|
        s_user.provider = auth1.provider
        s_user.user_id = auth2
        s_user.uid = auth1.uid
        s_user.profile_name = auth1.info.name
        s_user.profile_image = auth1.info.image
        s_user.token = auth1.credentials.token
        s_user.social_email = auth1.info.email
        s_user.expire_at = (DateTime.strptime("#{auth1.credentials.expires_at}","%s"))
        s_user.save!
      end
    end
  end#linkedin_omni ends here

  def self.github_omni(*args)
    auth1=args[0]
    auth2=args[1]
    if SocialMedium.exists?where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email,user_id:auth2)
      u=SocialMedium.find_by_id(where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).first)

      if u.update(token: auth1.credentials.token, expire_at: (DateTime.strptime("#{auth1.credentials.expires_at}","%s")))
      puts "token updated successfully"
      else
        puts "token not updated to database"
      end

      where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).first do |u|
      end

    else
      where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).create do |s_user|
        s_user.provider = auth1.provider
        s_user.user_id = auth2
        s_user.uid = auth1.uid
        s_user.profile_name = auth1.info.name
        s_user.profile_image = auth1.info.image
        s_user.token = auth1.credentials.token
        s_user.social_email = auth1.info.email
        s_user.expire_at = (DateTime.strptime("#{auth1.credentials.expires_at}","%s"))
        s_user.save!
      end
    end
  end#github_omni ends here

  def self.pinterest_omni(*args)
    auth1=args[0]
    auth2=args[1]
    if SocialMedium.exists?where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email,user_id:auth2)
      u=SocialMedium.find_by_id(where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).first)

      if u.update(token: auth1.credentials.token, expire_at: (DateTime.strptime("#{auth1.credentials.expires_at}","%s")))
      puts "token updated successfully"
      else
        puts "token not updated to database"
      end

      where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).first do |u|
      end

    else
      where(provider:auth1.provider, uid:auth1.uid, social_email:auth1.info.email).create do |s_user|
        s_user.provider = auth1.provider
        s_user.user_id = auth2
        s_user.uid = auth1.uid
        s_user.profile_name = auth1.info.name
        s_user.profile_image = auth1.info.image
        s_user.token = auth1.credentials.token
        s_user.social_email = auth1.info.email
        s_user.expire_at = (DateTime.strptime("#{auth1.credentials.expires_at}","%s"))
        s_user.save!
      end
    end
  end#pinterest_omni ends here






end
