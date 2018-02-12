class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate
    # Some complicated code to check for user
    @current_user = User.find(session[:user_id])
  end

  def signed_in?
    !!@current_user
  end

  def current_user
    @current_user || authenticate_user
  end

  def require_valid_user
    redirect_to new_session_path if !!current_user
  end
end
