class UtilityFee < ActiveRecord::Base

  # Name of the Utility Fees must be presented
  validates :name, presence: true
  # Amount of that Utility Fees must be presented
  validates :amount, presence: true, numericality: { greater_than: 0 }
  # Repetitive payment of that Utility Fees must be presented and either be true of false
  validates :repetitive_payment, :inclusion => {:in => [true, false]}
end
