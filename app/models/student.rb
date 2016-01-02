class Student < User
  # The REGEX for the email validation. Must be using APU email only
  VALID_EMAIL_REGEX = /\ATP+[\d]{6}+@mail+\.apu+\.edu+\.my+\z/i
  # Email of the student must be presented and the length not more than 25 char and it is unique
  validates :email, presence: true, length: { maximum: 25 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness:  {case_sensitive: false}
  # The student instake code must be present with the maximum length of 15 chars
  validates :intake, presence: true, length: { maximum: 15 }
  # The REGEX for the Student TP Number.
  VALID_TP_REGEX = /\ATP+[\d]{6}\z/i
  # Student number must be presented and the length not more than 8 and it is unique
  validates :student_number, presence: true, length: { maximum: 8 },
            format: { with: VALID_TP_REGEX },
            uniqueness: { case_sensitive: false}
end
