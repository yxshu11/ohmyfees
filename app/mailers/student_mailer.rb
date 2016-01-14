class StudentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_mailer.account_activation.subject
  #
  def account_activation(student)
    @student = student

    mail to: @student.email, subject: "Account Activation | OHMYFEES"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_mailer.password_reset.subject
  #
  def password_reset(student)
    @student = student

    mail to: @student.email, subject: "Password Reset | OHMYFEES"
  end
end
