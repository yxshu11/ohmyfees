class Student < ActiveRecord::Base
  # Convert the email addresses into small capital letter before saving into database.
  before_save { self.email = email.downcase }

  # Name of the student must be presented and the length not more than 80 chars
  validates :name,  presence: true, length: { maximum: 80 }
  # The REGEX for the email validation. Must be using APU email only
  VALID_EMAIL_REGEX = /\ATP+[\d]{6}+@mail+\.apu+\.edu+\.my+\z/i
  # Email of the student must be presented and the length not more than 25 char and it is unique
  validates :email, presence: true, length: { maximum: 25 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness:  {case_sensitive: false}
  # Student number must be presented and the length not more than 8 and it is unique
  validates :student_number, presence: true, length: { maximum: 8 }, uniqueness: { case_sensitive: false}
  # Student account has secure password
  has_secure_password
  # Password must be presented and the minumum length is 6
  validates :password, presence: true, length: { minimum: 6 }
end
