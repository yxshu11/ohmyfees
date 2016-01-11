module SessionsHelper

  # Logs in the given users
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @currrent_user = user
      end
    end
  end

  def current_user?(user)
    user == current_user
  end

  # Returns the logged-in user type
  def current_user_type
    if !current_user.blank?
      @current_user_type = current_user.type
    end
  end

  # Remember the current signed in user
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forgets a persistant session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Returns true if the user is logged in, false otherwise
  def logged_in?
      !current_user.blank?
  end

  # Delete the session, cookies and Log the user out of the system
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
    @current_user_type = nil
    @selected_student = nil
  end

  # Friendly Forwarding
  # Redirects to stored location (or to the default one)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  # Stores the selected programme that the staff currently viewing
  def select_programme(programme)
    session[:programme_id] = programme.id
  end

  # Get the selected programme that the staff currently viewing
  def selected_programme
    @current_programme ||= Programme.find_by(id: session[:programme_id])
  end

  # Store the selected student that the staff currently viewing
  def select_student(student)
    session[:selected_student_id] = student.id
  end

  # Get the selected student that the staff currenly viweing
  def selected_student
    @selected_student ||= Student.find_by(id: session[:selected_studet_id])
  end

end
