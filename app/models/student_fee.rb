class StudentFee < ActiveRecord::Base
  # Define the relationship between the StudentFees and Student.
  belongs_to :student, foreign_key: 'user_id'

end
