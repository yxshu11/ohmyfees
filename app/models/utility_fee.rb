class UtilityFee < ActiveRecord::Base

  # Name of the Utility Fees must be presented
  validates :name, presence: true
  # Amounth of that Utility Fees must be presented
  validates :amount, presence: true
end
