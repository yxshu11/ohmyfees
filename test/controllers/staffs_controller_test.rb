require 'test_helper'

class StaffsControllerTest < ActionController::TestCase

  def setup
    @admin_staff = users(:admin_staff)
    @nonadmin_staff = users(:nonadmin_staff)
  end

  test "should get new" do
    log_in_as(@admin_staff)
    get :new
    assert_response :success
  end

  test "non admin staff should be redirected for adding new staff" do
    log_in_as(@nonadmin_staff)
    get :new
    assert_redirected_to root_path
    assert_not flash.empty?
  end

  test "should get show" do
    log_in_as(@admin_staff)
    get :show, id: @admin_staff
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@admin_staff)
    get :edit, id: @admin_staff
    assert_response :success
  end

  test "should be redirected when nonadmin staff try to view other user" do
    log_in_as(@nonadmin_staff)
    get :show, id: @admin_staff
    assert_redirected_to root_path
    assert_not flash.empty?
  end

  test "student should be redirected when try to edit other student profile" do
    log_in_as(@nonadmin_staff)
    get :edit, id: @admin_staff
    assert_redirected_to root_path
    assert_not flash.empty?
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@nonadmin_staff)
    assert_not @nonadmin_staff.admin?
    patch :update, id: @nonadmin_staff, staff: { password: Staff.digest('111111'),
                                                 password_confirmation: Staff.digest('111111'),
                                                 admin: true }
    assert_not @nonadmin_staff.reload.admin?
  end
end
