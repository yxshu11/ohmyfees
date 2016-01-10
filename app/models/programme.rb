class Programme < ActiveRecord::Base

  validates :programme_type, presence: true
  validates :name, presence: true
  validates :description, presence: true

end
