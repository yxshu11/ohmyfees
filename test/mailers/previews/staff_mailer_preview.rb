# Preview all emails at http://localhost:3000/rails/mailers/staff_mailer
class StaffMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/staff_mailer/password_reset
  def password_reset
    student = Staff.first
    student.reset_token = Staff.new_token
    StaffMailer.password_reset(student)
  end

end
