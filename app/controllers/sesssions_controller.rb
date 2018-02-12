class SessionsController < ApplicationController
  def create
    user = User.find_by(name: params[:name])
    # If they exist and correct password
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
    else
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end
end
