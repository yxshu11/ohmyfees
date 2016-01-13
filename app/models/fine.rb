class Fine < ActiveRecord::Base
  # Definition of the relationship between the student_fee and payment models.
  belongs_to :student_fee
  
end
