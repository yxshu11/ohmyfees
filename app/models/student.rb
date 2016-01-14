class Student < User
  # Define the relationship between Student and Student Fees
  has_many :student_fees, foreign_key: 'user_id'

  attr_accessor :remember_token, :activation_token
  before_create :create_activation_digest

  after_create :assign_fee

  # The REGEX for the email validation. Must be using APU email only
  VALID_EMAIL_REGEX = /\ATP+[\d]{6}+@mail+\.apu+\.edu+\.my+\z/i

  # Email of the student must be presented and the length not more than 25 char and it is unique
  validates :email, presence: true, length: { maximum: 25 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness:  {case_sensitive: false}

  # The student intake code must be present with the maximum length of 15 chars
  validates :intake, presence: true, length: { maximum: 15 }

  # The check whether the student is international student or not
  validates :international, :inclusion => {:in => [true, false]}

  # The REGEX for the Student TP Number.
  VALID_TP_REGEX = /\ATP+[\d]{6}\z/i

  # Student number must be presented and the length not more than 8 and it is unique
  validates :student_number, presence: true, length: { maximum: 8 },
            format: { with: VALID_TP_REGEX },
            uniqueness: { case_sensitive: false}

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_mail
    StudentMailer.account_activation(self).deliver_now
  end

  private

    # Create the activation digest for the student who register with the portal to activate their account.
    def create_activation_digest
      self.activation_token = Student.new_token
      self.activation_digest = Student.digest(activation_token)
    end

    # Assign the fees to the student based on their intake code.
    def assign_fee
      # Assign Fees to the student profile (Dummy For Now)
      m_intake = Intake.find_by(intake_code: self.intake)
      programme = Programme.find_by(id: m_intake.programme_id)
      year = programme.year
      semester = programme.semester

      semester_duration = year*52/semester

      due_date = DateTime.now + 1.week

      international = self.international

      if international == false
        course_fee = m_intake.local_student_fee
      else
        course_fee = m_intake.international_student_fee
      end

      amount = course_fee/semester

      # Create Course Fees
      counter = 0
      semester.times do
        counter += 1
        self.student_fees.create!(name: "Course Fees",
                                  amount: amount,
                                  due_date: due_date,
                                  description: "Course Fees for Semester #{counter}")
        due_date = due_date + semester_duration.weeks
      end

      # Create Utility Fees

      nonrepetitive_due_date = Date.today() + 1.week

      UtilityFee.all.each do |uf|
        if(uf.repetitive_payment == true)
          repetitive_due_date = Date.today() + 1.week
          year.times do |n|
            self.student_fees.create!(name: "#{uf.name} for year #{(n+1)}",
                                      amount: uf.amount,
                                      due_date: repetitive_due_date,
                                      description: uf.description)
            repetitive_due_date = repetitive_due_date + 1.year
          end

        else
          self.student_fees.create!(name: uf.name,
                                    amount: uf.amount,
                                    due_date: nonrepetitive_due_date,
                                    description: uf.description)
        end
      end
    end
end
