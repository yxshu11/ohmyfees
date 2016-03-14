class StudentFee < ActiveRecord::Base
  # Define the relationship between the StudentFees and Student.
  belongs_to :student, foreign_key: 'user_id'
  # Check the student id is presented as foriegn key.
  validates :user_id, presence: true

  # Define the relationship between the student fee and payment
  #(One student fees has many payment)
  has_one :payment
  # Define the relationship  between the student fee and fines
  #(One student fee has many fines)
  has_many :fines

  # Check the name and due date must be presented.
  validates :name, presence: true
  # Check the date must be presented
  validates :due_date, presence: true
  # Check the amount must be presented and it must be in number format.
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
