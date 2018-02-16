class SessionsController < ApplicationController
  skip_before_action :authorize!
  layout 'public'

  def new
  end

  def create
    @user = User.find_by(name: params[:name])
    # If they exist and correct password
    if @user && @user.authenticate(params[:password])
      sign_in @user
      redirect_to user_path
    else
      flash.now[:notice] = "Invalid User/Password Combination"
      render 'new'
    end
  end

  def destroy
    session.clear
    flash[:notice] = "You've successfully logged out."
    redirect_to new_session_path
  end

end
