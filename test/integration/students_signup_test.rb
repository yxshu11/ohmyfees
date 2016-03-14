require 'test_helper'

class StudentsSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    get student_registration_path
    assert_no_difference 'Student.count' do
      post students_path, student: { name:  "",
                                     email: "user@invalid",
                                     password:              "foo",
                                     password_confirmation: "bar" }
    end
    assert_template 'students/new'
  end

  test "valid signup information with account activation" do
    get student_registration_path
    assert_difference 'Student.count', 1 do
      post students_path, student: { name: "FirstName SecondName",
                                     email: "TP099999@mail.apu.edu.my",
                                     student_number: "TP099999",
                                     contact_number: "0123456789",
                                     intake: "UC3F1608SE",
                                     international: false,
                                     tfa: false,
                                     password: "111111",
                                     password_confirmation: "111111" }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    student = assigns(:student)
    assert_not student.activated?
  end
end
