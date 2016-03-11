class Programme < ActiveRecord::Base
  has_many :intakes, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :programme_type, presence: true
  validates :year, presence: true
  validates :semester, presence: true
  
end
