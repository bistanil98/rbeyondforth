require "bcrypt"
class User < ActiveRecord::Base

  has_attached_file :image, styles: { large: "600X600>", medium: "300x300>",thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  has_secure_password
  include BCrypt
  before_create { generate_token(:auth_token) }

  # has_attached_file :image, styles: { large: "600X600>", medium: "300x300>",thumb: "100x100>" }
  # validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def password
    @password ||= Password.new(password_digest)
  end

  def self.omniauth(auth)
    puts auth
    puts auth.info.email
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.password = 'bojanglesicedtea'
      user.password_confirmation = 'bojanglesicedtea'
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      #user.image = auth.info.image
      user.token = auth.credentials.token
      user.email = auth.info.email

=begin
      user.granted_scopes = auth.credentials.granted_scopes.
      user.scope = auth.credentials.scopes.

      user.expire_at = Time.at(auth.credentials.expires_at)
=end
      user.save!
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
