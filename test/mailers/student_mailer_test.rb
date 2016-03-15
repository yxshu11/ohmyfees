require 'test_helper'

class StudentMailerTest < ActionMailer::TestCase

  test "account_activation" do
    student = users(:nonactivated_student)
    student.activation_token = Student.new_token
    mail = StudentMailer.account_activation(student)
    assert_equal "Account Activation | OHMYFEES", mail.subject
    assert_equal [student.email], mail.to
    assert_equal ["no-reply@ohmyfees.my"],      mail.from
    assert_match student.name,                  mail.body.encoded
    assert_match student.activation_token,      mail.body.encoded
    assert_match CGI::escape(student.email),    mail.body.encoded
  end

  test "password_reset" do
    student = users(:activated_student)
    student.reset_token = Student.new_token
    mail = StudentMailer.password_reset(student)
    assert_equal "Password Reset | OHMYFEES",   mail.subject
    assert_equal [student.email], mail.to
    assert_equal ["no-reply@ohmyfees.my"],      mail.from
    assert_match student.reset_token,           mail.body.encoded
    assert_match CGI::escape(student.email),    mail.body.encoded
  end
end
