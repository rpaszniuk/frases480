class SecureUser < ActiveRecord::Base
  self.primary_key = 'user_id'
  belongs_to :user

  before_create :generate_secure_hash
  before_save :change_password

  def authenticate(written_password)
    Digest::SHA256.hexdigest(written_password + self.password_salt) == self.password
  end

  def get_secure_hash
    self.generate_secure_hash(true) if self.secure_hash.blank? || self.secure_hash_expires_at.blank? || self.secure_hash_expired?
    self.secure_hash
  end

  def generate_secure_hash(do_save = false)
    self.secure_hash = Digest::SHA1.hexdigest(self.digest_key + Time.now.to_i.to_s + self.user.email)
    self.secure_hash_expires_at = Time.now + 25.hours
    self.save if do_save
  end

  def secure_hash_expired?
    self.secure_hash_expires_at < Time.now
  end

  def expire_secure_hash
    self.secure_hash_expires_at = Time.now - 1.hour
    self.save
  end

  def change_password
    self.password_salt = Digest::SHA1.hexdigest(self.user.email + self.digest_key + Time.now.to_s) if self.password_salt.blank?
    self.password = Digest::SHA256.hexdigest(self.password + self.password_salt) if self.password_changed?
  end

  def digest_key
    'h0lA,E7Tec0d3Name!!!'
  end

  def self.get_random_password(social_id, email)
    Digest::SHA1.hexdigest(email + Time.now.to_i.to_s + social_id.to_s + 'frases#weird@string')
  end
end
