class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(name: group_params[:name], creator_id: current_user.id, owner_id: current_user.id)
    if @group.save
      redirect_to @group
    else
      flash[:notice] = "Group name already taken. Please choose a new group name."
      render 'new'
    end
  end

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if params[:groupaction] == 'join'
      @group.add_member(current_user)
      redirect_to groups_path
    elsif params[:groupaction] == 'leave'
      @group.remove_member(current_user)
      redirect_to groups_path
    else
      @group.update(group_params)
      redirect_to @group
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :creator_id, :owner_id)
  end

end
