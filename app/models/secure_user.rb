class SecureUser < ActiveRecord::Base
  self.primary_key = 'user_id'
  belongs_to :user

  before_create :generate_hash
  before_save :change_password

  def authenticate(written_password)
    Digest::SHA256.hexdigest(written_password + self.password_salt) == self.password
  end
  
  def generate_hash
    self.secure_hash = Digest::SHA1.hexdigest(self.digest_key + Time.now.to_i.to_s + self.user.email)
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
