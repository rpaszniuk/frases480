class UserAuth
  include ActiveModel::Model

  attr_accessor :email, :password, :user, :signing_in

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, presence: true, if: -> { self.signing_in }

  def initialize(options = {})
    @email = options[:email]
    @password = options[:password]
    @signing_in = options[:signing_in] || true
  end

  def do_sign_in
    if self.valid?
      self.user = User.includes(:secure_user).active.find_by(email: self.email)
      if self.user.nil?
        self.errors.add(:base, 'Credenciales no válidas.')
      else
        if self.user.secure_user.authenticate(self.password)
          return true
        else
          self.errors.add(:base, 'Credenciales no válidas.')
        end
      end
    end
    false
  end

  def login_successful?
    return false unless valid?

    self.user = User.active.includes(:secure_user).find_by(email: email.upcase)
    return true if !user.nil? && user.active? && user.secure_user.authenticate(password) && !user.access_profile.nil?

    errors.add(:email, 'Credenciales no válidas.')
    false
  end

  def do_recover_password?
    if self.valid?
      self.user = User.includes(:secure_user).active.find_by(email: self.email)
      if self.user.nil?
        self.errors.add(:email, 'El usuario no existe o está inactivo.')
      else
        # return true
        self.errors.add(:email, 'Error al recuperar contraseña. Intente nuevamente.')
      end
    end
    false
  end
end
