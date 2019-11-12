class User < ActiveRecord::Base
  belongs_to :access_profile
  has_one :secure_user, dependent: :destroy
  has_one :secure_user
  has_many :phrases

  attr_accessor :password
  accepts_nested_attributes_for :secure_user, allow_destroy: true

  has_one_attached :avatar

  before_create :generate_auth_token_and_password

  enum status: [:active, :blocked, :deleted]

  validates :first_name, :last_name, presence: true
  validates :email, format: { with: /\A([^@\s,]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :email, uniqueness: true, if: -> { email_changed? }
  validates :password, presence: true

  def password=(value)
    if self.secure_user.nil?
      self.secure_user = SecureUser.new(password: value)
    else
      self.secure_user.password = value
    end
  end

  def password
    self.secure_user = SecureUser.new if self.secure_user.nil?
    self.secure_user.password
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def self.statuses_map
    statuses.map { |v, _k| [I18n.t("models.user.status.#{v}"), v] }
  end

  def mark_as_deleted?
    self.status = :deleted
    save(validate: false)
  end

  protected

  def generate_auth_token_and_password
    self.auth_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(auth_token: random_token)
    end
  end
end
