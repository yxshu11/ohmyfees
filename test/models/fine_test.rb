require 'test_helper'

class FineTest < ActiveSupport::TestCase

  def setup
    @student_fee = student_fees(:student_fee)
    @fine = Fine.new(name: "Fine for testing",
                     amount: 20,
                     student_fee_id: @student_fee.id)
  end

  test "fine should be valid" do
    assert @fine.valid?
  end

  test "name should be presented" do
    @fine.name = " "
    assert_not @fine.valid?
  end

  test "amount should be presented" do
    @fine.amount = " "
    assert_not @fine.valid?
  end

  test "amount should be in number format" do
    @fine.amount = "abc"
    assert_not @fine.valid?
  end

  test "amount should be greater than 0" do
    @fine.amount = 0
    assert_not @fine.valid?
  end

  test "student fee id should be presented as the foreign key" do
    @fine.student_fee_id = nil
    assert_not @fine.valid?
  end
end
