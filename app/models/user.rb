class User < ActiveRecord::Base
  # Accessible Attributes
  attr_accessor :remember_token, :activation_token, :reset_token
  # Convert the email addresses into small capital letter before saving into database.
  before_save :downcase_email


  # Name of the User must be presented and the length not more than 100 chars
  validates :name,  presence: true, length: { maximum: 100 }
  # Phone of the user must be presented and the length not more than 11 chars
  validates :contact_number, presence: true, length: { maximum: 11 }
  # User account has secure password
  has_secure_password
  # Password must be presented and the minumum length is 6
  validates :password, presence: true, length: { minimum: 6 }


  # Returns the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remember a user in the database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Return true if the given token matches the digest
  def authenticated? (attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a User
  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    if self.type == "Staff"
      StaffMailer.password_reset(self).deliver_now
    elsif self.type == "Student"
      StudentMailer.password_reset(self).deliver_now
    end
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

    def downcase_email
      self.email = email.downcase
    end
end
