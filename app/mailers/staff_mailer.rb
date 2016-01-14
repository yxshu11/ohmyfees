class StaffMailer < ApplicationMailer

  def password_reset(staff)
    @staff = staff

    mail to: @staff.email, subject: "Password Reset | OHMYFEES"
  end
end
