class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to user_path
    else
      render 'new'
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_path
  end

  def destroy
    current_user.destroy
    flash[:notice] = "You've successfully logged out."
    redirect_to new_user_path
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :password)
  end

end
