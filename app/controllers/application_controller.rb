class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def authenticate_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end

  def signed_in?
    !!@current_user
  end

  def current_user
    @current_user || authenticate_user
  end

  def require_valid_user

    if current_user.nil?
      flash[:notice] = "You must be logged in"
      redirect_to login_path
    end
  end
end
