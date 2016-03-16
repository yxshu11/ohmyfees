require 'test_helper'

class StatisticsControllerTest < ActionController::TestCase

  def setup
    @staff = users(:admin_staff)
    @student = users(:activated_student)
  end

  test "non login access should be redirected" do
    get :index
    assert_redirected_to login_path
    assert_not flash.empty?
  end
  
  test "should get index" do
    log_in_as(@staff)
    get :index
    assert_response :success
  end

  test "student should be redirected to root path (access denied)" do
    log_in_as(@student)
    get :index
    assert_redirected_to root_path
    assert_not flash.empty?
  end

  test "should get student" do
    log_in_as(@staff)
    get :student
    assert_response :success
  end

  test "should get payment" do
    log_in_as(@staff)
    get :payment
    assert_response :success
  end
end
