class Programme < ActiveRecord::Base
  has_many :intakes, dependent: :destroy

  validates :name, presence: true
  validates :programme_type, presence: true
  validates :year, presence: true
  validates :semester, presence: true
  validates :description, presence: true

end
