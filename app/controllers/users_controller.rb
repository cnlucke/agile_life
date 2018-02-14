class UsersController < ApplicationController
  skip_before_action :authorize!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to user_path
    else
      flash.now[:notice] = "User already exists."
      render 'new'
    end
  end

  def show
    @user = current_user
    @sorted_events = sorted_events
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

  def sorted_events
    current_user.created_events.sort{|x,y| x.starts_at <=> y.starts_at}
  end

end
