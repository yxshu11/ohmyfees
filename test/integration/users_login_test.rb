require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @activated_student = users(:activated_student)
    @tfa_student = users(:tfa_student)
    @nonactivated_student = users(:nonactivated_student)
    @admin_staff = users(:admin_staff)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "activate student login with valid information" do
    get login_path
    post login_path, session: { email: @activated_student.email, password: '111111' }
    assert_redirected_to dashboard_path
    follow_redirect!
    assert_template 'landing_pages/dashboard'
  end

  test "admin staff login with valid information" do
    get login_path
    post login_path, session: { email: @admin_staff.email, password: '111111' }
    assert_redirected_to dashboard_path
    follow_redirect!
    assert_template 'landing_pages/dashboard'
  end

  test "login with remembering" do
    log_in_as(@admin_staff, remember_me: '1')
    assert_equal assigns(:user).remember_token, cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@admin_staff, remember_me: '0')
    assert_nil cookies['remember_token']
  end

end
