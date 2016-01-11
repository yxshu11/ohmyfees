class Intake < ActiveRecord::Base
  belongs_to :programme

  validates :intake_code, presence: true
  validates :starting_date, presence: true
  validates :local_student_fee, presence: true
  validates :international_student_fee, presence: true

end
