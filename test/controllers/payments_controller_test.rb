require 'test_helper'

class PaymentsControllerTest < ActionController::TestCase

  def setup
    @student = users(:activated_student)
    @paid_student_fee = student_fees(:paid_student_fee)
  end

  test "should get new" do
    log_in_as(@student, remember_me: '1')
    get :new, id: @paid_student_fee
    assert_redirected_to dashboard_path
    # assert_response :success
  end

  test "should get show" do
    log_in_as(@student, remember_me: '1')
    get :show, id: @paid_student_fee
    assert_redirected_to dashboard_path
    #assert_response :success
  end

  test "should get index" do
    log_in_as(@student, remember_me: '1')
    get :index
    assert_response :success
  end
end
