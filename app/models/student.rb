class Student < ActiveRecord::Base

  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness:  {case_sensitive: false}
  validates :student_number, presence: true, length: { maximum: 8 }, uniqueness: { case_sensitive: false}
  
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
