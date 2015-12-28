module SessionsHelper

  # Logs in the given users
  def log_in(student)
    session[:student_id] = student.id
  end

  def current_user
    Student.find_by(id: session[:student_id])
  end

  
end
