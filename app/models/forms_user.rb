class FormsUser < User

  attr_accessor :current_password

  validates_presence_of   :email, if: :email_required?
  validates :email, uniqueness: {case_sensitive: false}
  validates_format_of     :email, with: Devise.email_regexp, allow_blank: true, if: :email_changed?

  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, within: Devise.password_length, allow_blank: true

  validates_format_of :url, :with => URI::regexp(%w(http https))


  def password_required?
    return false if email.blank?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def email_required?
    true
  end
end

