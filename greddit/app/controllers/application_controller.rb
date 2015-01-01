class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
    @current_user ||= User.find_by_id(session[:user])
  end

  def logged_in?
    current_user
  end

  def authenticate_user
    if !current_user
      redirect_to signin_path, notice: "Please sign-in first"
    end
  end

  helper_method :current_user, :logged_in?

end
