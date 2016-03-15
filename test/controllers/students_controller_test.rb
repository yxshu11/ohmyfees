require 'test_helper'

class StudentsControllerTest < ActionController::TestCase

  def setup
    @activated_student = users(:activated_student)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do

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
