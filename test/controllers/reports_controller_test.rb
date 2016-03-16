require 'test_helper'

class ReportsControllerTest < ActionController::TestCase

  def setup
    @admin_staff = users(:admin_staff)
    @student = users(:activated_student)
  end

  test "student should be redirected to dashboard" do
    log_in_as(@student)
    get :index
    assert_redirected_to root_path
    assert_not flash.empty?
  end

  test "should get index" do
    log_in_as(@admin_staff)
    get :index
    assert_response :success
  end

  test "should get monthly" do
    log_in_as(@admin_staff)
    get :monthly
    assert_response :success
  end

  test "should get annual" do
    log_in_as(@admin_staff)
    get :annual
    assert_response :success
  end
end
