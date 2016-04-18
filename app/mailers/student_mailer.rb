class StudentMailer < ApplicationMailer

  def account_activation(student)
    @student = student

    mail to: @student.email, subject: "Account Activation | OHMYFEES"
  end

  def password_reset(student)
    @student = student

    mail to: @student.email, subject: "Password Reset | OHMYFEES"
  end

  def due_payment(student, fee_details, payment_number)
    @student = student
    @fee_details = fee_details
    @payment_number = payment_number

    mail to: @student.email, subject: "Due Payment | OHMYFEES"
  end

  def outstanding_payment(student, fee_details, payment_number)
    @student = student
    @fee_details = fee_details
    @payment_number = payment_number

    mail to: @student.email, subject: "Outstanding Payment | OHMYFEES"
  end

end
