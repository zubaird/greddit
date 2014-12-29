class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # def current_user
  #   session[:user_id] = @current_user.id
  #   User.find(session[:user_id])
  # end

  def current_user
    @current_user ||= User.find_by_id(session[:user])
  end

  helper_method :current_user

end
