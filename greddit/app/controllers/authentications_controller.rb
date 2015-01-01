class AuthenticationsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by(email: params[:email])
    log_in @user
  end

  def destroy
    session.destroy
    redirect_to root_path, notice: "You have been signed out"
  end

  private

  def log_in(user)
    if user && user.authenticate(params[:password])
      session[:user] = user.id
      redirect_to root_path, notice: "Welcome #{current_user.username}, you are succesfully logged in"
    else
      @error_resources = user
      render :new
    end
  end

end
