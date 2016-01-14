# Preview all emails at http://localhost:3000/rails/mailers/student_mailer
class StudentMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/student_mailer/account_activation
  def account_activation
    student = Student.first
    student.activation_token = Student.new_token
    StudentMailer.account_activation(student)
  end

  # Preview this email at http://localhost:3000/rails/mailers/student_mailer/password_reset
  def password_reset
    student = Student.first
    student.reset_token = Student.new_token
    StudentMailer.password_reset(student)
  end

end
