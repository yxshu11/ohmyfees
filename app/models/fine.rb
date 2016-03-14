class Fine < ActiveRecord::Base
  # Definition of the relationship between the student_fee and payment models.
  belongs_to :student_fee
  # Check the student fee id is presented as the foreign key
  validates :student_fee_id, presence: true

  # Check the name is presented
  validates :name, presence: true
  # Check the amount is presented and in number format
  validates :amount, presence: true, numericality: { greater_than: 0 }

end
