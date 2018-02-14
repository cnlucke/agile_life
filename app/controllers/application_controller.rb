class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :authorize!, except: :index

  def index

  end

  def user_signed_in?
    !!current_user
  end

  def sign_in(user)
    session[:user_id] = user.id if user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id], active: true)
  end

  def authorize!
    if !user_signed_in?
      flash[:notice] = "Please sign in:"
      redirect_to new_session_path
    end
  end
end
