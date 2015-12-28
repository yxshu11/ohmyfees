class Student < ActiveRecord::Base

  before_save { self.email = email.downcase }

  validates :name,  presence: true, length: { maximum: 80 }
  validates :email, presence: true, length: { maximum: 25 }, uniqueness:  {case_sensitive: false}
  validates :student_number, presence: true, length: { maximum: 8 }, uniqueness: { case_sensitive: false}

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
