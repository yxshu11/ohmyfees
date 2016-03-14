class Intake < ActiveRecord::Base
  # Initial the relation between intake and programme
  belongs_to :programme
  # Check the programme id is presented as the foreign key of the intake table from programme table
  validates :programme_id, presence: true

  # Check the intake code (name of the intake) must be presented
  validates :intake_code, presence: true
  # Check the starting date must be presented
  validates :starting_date, presence: true
  # Check the local student fee must be presented and in number format
  validates :local_student_fee, presence: true, numericality: { greater_than: 0 }
  # Check the international student fee must be presented and in number format
  validates :international_student_fee, presence: true, numericality: { greater_than: 0 }

end
