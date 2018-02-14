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
      if User.all.find_by(name: user_params[:name]).active ##user name already exists
        flash.now[:notice] = "User already exists."
        render 'new'
      else
        flash.now[:notice] = "User exists, but is no longer active."
        render 'new'
      end
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
    current_user.active = false
    if current_user.save
      Task.owned(current_user).map do |i|
        i.update!(owner_id: unassigned.id) #Unassign all user's tasks
      end
    end
    redirect_to new_user_path
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :password)
  end

  def unassigned
    User.find_by(name: "unassigned")
  end
end
