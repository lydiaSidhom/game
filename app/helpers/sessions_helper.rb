module SessionsHelper
	# Logs in the given user: place the user’s id securely in the temporary session
	#In contrast to the persistent cookie created by the cookies method, 
	#the temporary cookie created by the session method 
	#expires immediately when the browser is closed.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
