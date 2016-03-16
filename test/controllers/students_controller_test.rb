require 'test_helper'

class StudentsControllerTest < ActionController::TestCase

  def setup
    @activated_student = users(:activated_student)
    @another_user = users(:nonactivated_student)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get show" do
    log_in_as(@activated_student)
    get :show, id: @activated_student
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@activated_student)
    get :edit, id: @activated_student
    assert_response :success
  end

  test "should be redirected when try to view other user" do
    log_in_as(@activated_student)
    get :show, id: @another_user
    assert_redirected_to root_path
    assert_not flash.empty?
  end

  test "student should be redirected when try to edit other student profile" do
    log_in_as(@activated_student)
    get :edit, id: @another_user
    assert_redirected_to root_path
    assert_not flash.empty?
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@activated_student)
    assert_not @activated_student.admin?
    patch :update, id: @activated_student, student: { password: Student.digest('111111'),
                                                      password_confirmation: Student.digest('111111'),
                                                      admin: true }
    assert_not @activated_student.reload.admin?
  end
end
