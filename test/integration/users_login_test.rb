require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @student = users(:student)
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

  test "student login with valid information" do
    get login_path
    post login_path, session: { email: @student.email, password: '111111' }
    assert_redirected_to dashboard_path
    follow_redirect!
    # assert_template 'landing_pages/dashboard'
    # assert_select "a[href=?]", logout_path
  end

  test "admin staff login with valid information" do
    get login_path
    post login_path, session: { email: @admin_staff.email, password: '111111' }
    assert_redirected_to dashboard_path
    follow_redirect!
    assert_template 'landing_pages/dashboard'

  end

end
