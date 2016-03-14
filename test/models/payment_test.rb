require 'test_helper'

class PaymentTest < ActiveSupport::TestCase

  def setup
    @student_fee = student_fees(:student_fee)
    @payment = Payment.new(amount: 100,
                           paid_by: "Student",
                           payment_method: "Online",
                           student_fee_id: @student_fee.id)
  end

  test "payment should be valid" do
    assert @payment.valid?
  end

  test "amount should be presented" do
    @payment.amount = " "
    assert_not @payment.valid?
  end

  test "amount should be greater than 0" do
    @payment.amount = 0
    assert_not @payment.valid?
  end

  test "paid by should be presented" do
    @payment.paid_by = " "
    assert_not @payment.valid?
  end

  test "payment method should be presented" do
    @payment.payment_method = " "
    assert_not @payment.valid?
  end

  test "student fee id should be presented as the foreign key" do
    @payment.student_fee_id = nil
    assert_not @payment.valid?
  end
end
