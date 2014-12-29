class UsersController < ApplicationController

def show
  @user = current_user
end

def create
  @user = User.create(user_params)

  if @user.save == true
    redirect_to user_path(@user)
    session[:user] = @user.id
    flash[:notice] = "You have successfully been signed up"
  else
    render :new
  end
end

private

  def user_params
    params.require(:user).permit(
    :username,
    :email,
    :password,
    :password_confirmation,
    )
  end

end
