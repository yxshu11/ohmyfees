class User < ActiveRecord::Base
  # Convert the email addresses into small capital letter before saving into database.
  before_save { self.email = email.downcase }
  # Name of the User must be presented and the length not more than 100 chars
  validates :name,  presence: true, length: { maximum: 100 }
  # User account has secure password
  has_secure_password
  # Password must be presented and the minumum length is 6
  validates :password, presence: true, length: { minimum: 6 }
end
