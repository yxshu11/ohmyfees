require 'test_helper'

class StudentFeesControllerTest < ActionController::TestCase

  def setup
    @student = users(:activated_student)
    @staff = users(:admin_staff)
    @student_fee = student_fees(:student_fee)
  end

  test "student should get index" do
    log_in_as(@student)
    get :index
    assert_response :success
  end

  test "staff should get index" do
    log_in_as(@staff)
    get :index
    assert_response :success
  end

  # test "student should get show" do
  #   log_in_as(@student)
  #   get :show, id: @student_fee
  #   assert_response :success
  # end
  #
  # test "staff should get show" do
  #   log_in_as(@staff)
  #   get :show, id: @student_fee
  #   assert_response :success
  # end
end
