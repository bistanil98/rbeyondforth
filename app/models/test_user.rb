require "bcrypt"
class User < ActiveRecord::Base
  has_secure_password
  include BCrypt
  before_create { generate_token(:auth_token) }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :identities

  def github
    identities where( :provider => "github").first
  end

  def github_client
    @github_client ||= Github.client(access_token: github.accesstoken )
  end

  def pinterest
    identities where( :provider => "pinterest").first
  end

  def pinterest_client
    @pinterest_client ||= Pinterest.client(access_token: pinterest.accesstoken)
  end

  def twitter
    identities.where( :provider => "twitter" ).first
  end

  def twitter_client
    @twitter_client ||= Twitter.client(access_token: twitter.accesstoken )
  end

  def facebook
    identities.where( :provider => "facebook" ).first
  end

  def facebook_client
    @facebook_client ||= Facebook.client(access_token: facebook.accesstoken )
  end

  def instagram
    identities.where( :provider => "instagram" ).first
  end

  def instagram_client
    @instagram_client ||= Instagram.client(access_token: instagram.accesstoken )
  end

  def linkedin
    identities.where( :provider => "linkedin").first
  end

  def linkedin_client
    @linkedin_client ||= LinkedIn.client(access_token: linkedin.accesstoken )
  end

  def google_oauth2
    identities.where( :provider => "google_oauth2" ).first
  end

  def google_oauth2_client
    if !@google_oauth2_client
      @google_oauth2_client = Google::APIClient.new(:application_name => 'HappySeed App', :application_version => "1.0.0" )
      @google_oauth2_client.authorization.update_token!({:access_token => google_oauth2.accesstoken, :refresh_token => google_oauth2.refreshtoken})
    end
    @google_oauth2_client
  end

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  def self.omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.image = auth.info.image
      user.token = auth.credentials.token
      user.email = auth.info.email

=begin
      user.granted_scopes = auth.credentials.granted_scopes.
      user.scope = auth.credentials.scopes.
=end
      user.expire_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
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