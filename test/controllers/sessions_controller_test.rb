require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  def setup
    @user = users(:activated_student)
    @tfa_student = users(:tfa_student)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get tfa" do
    tfa_user @tfa_student
    get :tfa
    assert_response :success
  end

  test "logged in user should be redirected" do
    log_in_as(@user)
    get :new
    assert_redirected_to dashboard_path
    assert_not flash.empty?
  end

end
