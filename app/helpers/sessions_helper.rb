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
  end
end
