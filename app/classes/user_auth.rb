class UserAuth
  include ActiveModel::Model

  attr_accessor :email, :password, :user

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, presence: true

  def login_successful?
    return false unless valid?\

    self.user = User.active.includes(:secure_user).find_by(email: email.upcase)
    return true if !user.nil? && user.active? && user.secure_user.authenticate(password) && !user.access_profile.nil?

    errors.add(:email, 'Invalid Credentials.')
    false
  end
end
