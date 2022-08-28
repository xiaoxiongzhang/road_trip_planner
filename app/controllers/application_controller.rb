class ApplicationController < ActionController::Base
  include UserSession

  private
  def auth_user
    unless logged_in?
      flash[:notice] = "please login first"
      redirect_to new_session_path
    end
  end
end
