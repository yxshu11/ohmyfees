require 'test_helper'

class StudentFeeTest < ActiveSupport::TestCase

  def setup
    @student = users(:student)
    @student_fee = StudentFee.new(name: "Student Fee 1",
                                  amount: 100,
                                  due_date: DateTime.now,
                                  description: "This is a description.",
                                  user_id: @student.id,
                                  paid: false)
  end

  test "student fee should be valid" do
    assert @student_fee.valid?
  end

  test "name should be presented" do
    @student_fee.name = " "
    assert_not @student_fee.valid?
  end

  test "amount should be presented" do
    @student_fee.amount = " "
    assert_not @student_fee.valid?
  end

  test "amount should be in numeric format" do
    @student_fee.amount = "abc"
    assert_not @student_fee.valid?
  end

  test "amount should be greater than 0" do
    @student_fee.amount = 0
    assert_not @student_fee.valid?
  end

  test "due date must be presented" do
    @student_fee.due_date = " "
    assert_not @student_fee.valid?
  end

  test "student id (user_id) must be presented as foreign key" do
    @student_fee.user_id = nil
    assert_not @student_fee.valid?
  end
end
