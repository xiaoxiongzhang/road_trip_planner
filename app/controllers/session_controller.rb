class SessionController < ApplicationController
  def new

  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      login_user @user

      render json: {
        status: 'ok',
        msg: {
          redirect_url: root_path
        }
      }
    else
      render json: {
        status: 'error',
        msg: "email or password error"
      }
    end
  end

  def destroy
    logout_user

    flash[:notice] = "logout"
    redirect_to root_path
  end
end
