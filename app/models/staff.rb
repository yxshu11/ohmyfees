class Staff < User
  # The entered staff number must be matching the following regex.
  # VALID_SN_REGEX = /\A \z/i
  # Student number must be presented and the length not more than 8 and it is unique
  validates :staff_number, presence: true, length: { maximum: 15 },
            #format: { with: VALID_TP_REGEX },
            uniqueness: { case_sensitive: false}
  # The Entered Staff email must be match the following regex.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@apu+\.edu+\.my+\z/i
  # Email of the student must be presented and the length not more than 25 char and it is unique
  validates :email, presence: true, length: { maximum: 50 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness:  {case_sensitive: false}

  def create_reset_digest
    self.reset_token = Staff.new_token
    update_attribute(:reset_digest, Staff.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    StaffMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
end
