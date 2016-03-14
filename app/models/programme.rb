class Programme < ActiveRecord::Base
  # Define the relationship between programme and intake
  has_many :intakes, dependent: :destroy

  # Validate the name must be presented with a maximum length of 100 chars
  validates :name, presence: true, length: { maximum: 100 }
  # Validate the programme type must be presented
  validates :programme_type, presence: true
  # Validate the year must be presented with integer format
  validates :year, presence: true, numericality: { only_integer: true }
  # Validate the semester must be presented with the interger format
  validates :semester, presence: true, numericality: { only_integer: true }
end
