class GroupsController < ApplicationController

  def new
  end

  def create
  end

  def index
    @groups = Group.all
  end

  def show
    @group = Group.all
  end

  def edit
  end

  def update
    @group = Group.find(params[:id])
    if params[:groupaction] == 'join'
      @group.add_member(current_user)
      redirect_to groups_path
    elsif params[:groupaction] == 'leave'
      @group.remove_member(current_user)
      redirect_to groups_path
    end

  end

  def destroy
  end

  private

  def group_params
    params.require(:group).permit(:name, :creator_id, :owner_id)
  end


end
