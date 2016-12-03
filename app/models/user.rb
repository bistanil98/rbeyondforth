require "bcrypt"
require 'rest-client'
class User < ActiveRecord::Base

  has_many :linkedin_shares
  has_many :social_media
  has_many :blogs
  has_many :comments
  has_attached_file :image, styles:{large:"600X600>",medium:"300x300>",thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :email, uniqueness: {case_sensitive: false}
  has_secure_password
  include BCrypt
  before_create {generate_token(:auth_token)}


  def password
    @password ||= Password.new(password_digest)
  end
=begin
  def token_expired?
    expiry = Time.at(self.expiresat)
    return true if expiry < Time.now # expired token, so we should quickly return
    token_expires_at = expiry
    save if changed?
    false # token not expired. :D
  end
=end
  def self.fb_omniauth(auth)
    if User.find_by_email(auth.info.email).present?
      # if SocialMedium.exists?where(social_email:auth.info.email)
      puts "beyondforth account exists for this email"
      usr = SocialMedium.fb_omni(auth)

      where(id:usr.user_id).first do |u|

      end

    else

      if SocialMedium.find_by_social_email(auth.info.email).present?

        usr = SocialMedium.fb_omni(auth)

        where(id:usr.user_id).first do |u|

        end

      else

        where(email:auth.info.email).create do |u|

          u.password = "password"
          u.name = auth.info.name
          u.email = auth.info.email
          u.image = auth.info.image
          u.status_active = true
          if u.save!
            usr = SocialMedium.fb_omni(auth)
          end

        end
      end
    end

  end


  def self.google_omniauth(auth)
    if User.find_by_email(auth.info.email).present?
      # if SocialMedium.exists?where(social_email:auth.info.email)
      puts "beyondforth account exists for this email"
      usr = SocialMedium.google_omni(auth)

      where(id:usr.user_id).first do |u|

      end

    else

      if SocialMedium.find_by_social_email(auth.info.email).present?

        usr = SocialMedium.google_omni(auth)

        where(id:usr.user_id).first do |u|

        end

      else

        where(email:auth.info.email).create do |u|

          u.password = "password"
          u.name = auth.info.name
          u.email = auth.info.email
          u.image = auth.info.image
          u.status_active = true
          if u.save!
            usr = SocialMedium.google_omni(auth)
          end

        end
      end
    end
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    user if !user.nil? && user.authenticate(password)
  end

end
