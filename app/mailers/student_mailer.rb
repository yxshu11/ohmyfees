class StudentMailer < ApplicationMailer

  def account_activation(student)
    @student = student

    mail to: @student.email, subject: "Account Activation | OHMYFEES"
  end

  def password_reset(student)
    @student = student

    mail to: @student.email, subject: "Password Reset | OHMYFEES"
  end
end
