require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @activated_student = users(:activated_student)
    @tfa_student = users(:tfa_student)
    @nonactivated_student = users(:nonactivated_student)
    @admin_staff = users(:admin_staff)
    @nonadmin_staff = users(:nonadmin_staff)
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

  test "Inactivated student login will be redirected" do
    get login_path
    post login_path, session: { email: @nonactivated_student.email, password: '111111'}
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'landing_pages/home'
    assert_not flash.empty?
  end

  test "Activated student login with valid information" do
    get login_path
    post login_path, session: { email: @activated_student.email, password: '111111' }
    assert_redirected_to dashboard_path
    follow_redirect!
    assert_template 'landing_pages/dashboard'
  end

  # test "TFA student login with valid information and being redirect to TFA page" do
  #   get login_path
  #   post login_path, session: { email: @tfa_student.email, password: '111111'}
  #   assert_redirected_to tfa_path
  #   follow_redirect!
  #   assert_template 'sessions/tfa'
  # end

  test "TFA student login with valid information and valid OTP" do
    get login_path
    post login_path, session: { email: @tfa_student.email, password: '111111'}
    assert_redirected_to tfa_path
    follow_redirect!
    assert_template 'sessions/tfa'
    post tfa_path, otp_code: @tfa_student.otp_code
    assert_redirected_to dashboard_path
    follow_redirect!
    assert_template 'landing_pages/dashboard'
  end

  test "TFA student login with valid information, but invalid OTP" do
    get login_path
    post login_path, session:{ email: @tfa_student.email, password: '111111'}
    assert_redirected_to tfa_path
    follow_redirect!
    assert_template 'sessions/tfa'
    post tfa_path, otp_code: '123456'
    assert_template 'sessions/tfa'
    assert_not flash.empty?
  end

  test "TFA student login with valid information, but expried OTP" do
    get login_path
    post login_path, session:{ email: @tfa_student.email, password: '111111'}
    assert_redirected_to tfa_path
    follow_redirect!
    assert_template 'sessions/tfa'
    otp = @tfa_student.otp_code
    Timecop.travel(Time.now + 2.minutes)
    post tfa_path, otp_code: otp
    assert_template 'sessions/tfa'
    assert_not flash.empty?
  end

  test "Normal staff login with valid information, but invalid location" do
    get login_path
    post login_path, session: {email: @nonadmin_staff.email, password: '111111'}
    assert_template 'sessions/new'
    assert_not flash.empty?
  end

  test "Normal staff login with valid information and valid location" do
    get login_path
    cookies[:location_coordinate] = "3.047882|101.692862"
    post login_path, session: {email: @nonadmin_staff.email, password: '111111'}
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
