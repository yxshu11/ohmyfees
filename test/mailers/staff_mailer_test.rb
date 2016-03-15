require 'test_helper'

class StaffMailerTest < ActionMailer::TestCase

  test "password_reset" do
    staff = users(:admin_staff)
    staff.reset_token = Staff.new_token
    mail = StaffMailer.password_reset(staff)
    assert_equal "Password Reset | OHMYFEES",   mail.subject
    assert_equal [staff.email], mail.to
    assert_equal ["no-reply@ohmyfees.my"],    mail.from
    assert_match staff.reset_token,           mail.body.encoded
    assert_match CGI::escape(staff.email),    mail.body.encoded
  end

end
