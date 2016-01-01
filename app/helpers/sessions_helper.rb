module SessionsHelper

  # Logs in the given users
  def log_in(user, type)
    session[:type] = type
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any)
  def current_user
    if sessions[:type] == "Student"
      @current_user ||= Student.find_by(id: session[:user_id])
    elsif session[:type] == "Staff"
      @current_user ||= Staff.find_by(id: session[:user_id])
    end
  end

  # Returns true if the user is logged in, false otherwise
  def logged_in?
      !current_user.nil?
  end
  

end
