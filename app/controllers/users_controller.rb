class UsersController < ApplicationController
  before_action :require_valid_user
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      redirect_to signup_path
    end
  end

  def show
  end

  def edit
  end

  def update
    current_user.update(user_params)
    redirect_to current_user
  end

  def destroy
    current_user.destroy
    redirect_to signup_path
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :password)
  end

end
