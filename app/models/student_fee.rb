class StudentFee < ActiveRecord::Base
  # Define the relationship between the StudentFees and Student.
  belongs_to :student, foreign_key: 'user_id'
  has_one :payment
  has_many :fines

  # Arrange the model data according to he due date in ascending order.
  default_scope -> { order(due_date: :asc) }

end
