require 'test_helper'

class UtilityFeeTest < ActiveSupport::TestCase

  def setup
    @utility_fee = UtilityFee.new(name: "Utility Fee A",
                                  amount: 100,
                                  repetitive_payment: false,
                                  description: "This is a description")
  end

  test "utility fee should be valid" do
    assert @utility_fee.valid?
  end

  test "name should be presented" do
    @utility_fee.name = " "
    assert_not @utility_fee.valid?
  end

  test "amount should be presented" do
    @utility_fee.amount = " "
    assert_not @utility_fee.valid?
  end

  test "amount should be in number format" do
    @utility_fee.amount = "abc"
    assert_not @utility_fee.valid?
  end

  test "amount should be greater than 0" do
    @utility_fee.amount = 0
    assert_not @utility_fee.valid?
  end
end
