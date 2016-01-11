class Programme < ActiveRecord::Base
  has_many :intakes, dependent: :destroy
  
  validates :programme_type, presence: true
  validates :name, presence: true
  validates :description, presence: true

end
