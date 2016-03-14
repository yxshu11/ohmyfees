class Payment < ActiveRecord::Base
  # Definition of the relationship between the student_fee and payment models
  belongs_to :student_fee
  # Check the student fee id is presented as the foreign key
  validates :student_fee_id, presence: true
  # Check the amount is presented and in number format
  validates :amount, presence: true, numericality: { greater_than: 0 }
  # Check the paid by and payment method is presented
  validates :paid_by, :payment_method, presence: true

  # Functions for the Active Merchant and PayPal Express Checkout gateway
  def purchase(amount)
    response = EXPRESS_GATEWAY.purchase((amount*100).round, express_purchase_options)
    response.success?
  end

  def express_token=(token)
    self[:express_token]=token
    if new_record? && !token.blank?
      details = EXPRESS_GATEWAY.details_for(token)
      self.express_payer_id = details.payer_id
      self.amount = details.params["amount"]
    end
  end

  private

    # Define the purchase option for paypal express checkout
    def express_purchase_options
      {
        :ip => self.ip,
        :currency => 'MYR',
        :token => self.express_token,
        :payer_id => self.express_payer_id
      }
    end

end
