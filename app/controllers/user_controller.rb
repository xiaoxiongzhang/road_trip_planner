class UserController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_attrs)
    if @user.save
      flash[:notice] = "register succeed，go to login!"
      redirect_to root_path
    else
      render action: :new
    end
  end

  private
  def user_attrs
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
