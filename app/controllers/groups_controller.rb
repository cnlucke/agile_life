class GroupsController < ApplicationController
  before_action :group_member?, only: [:edit, :destroy]
  before_action :authorize!

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(name: group_params[:name], creator_id: current_user.id, owner_id: current_user.id)
    edit_group_members(@group)
    @group.update(group_params)
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
    if params[:group_action] == 'join'
      @group.add_member(current_user)
      redirect_to groups_path
    elsif params[:group_action] == 'leave'
      @group.remove_member(current_user)
      redirect_to groups_path
    else
      edit_group_members(@group)
      @group.update(group_params)
      redirect_to @group
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = "Group Successfully Deleted"
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :creator_id, :owner_id)
  end

  def group_member?
    @group = Group.find(params[:id])
    if !@group.has_member?(current_user)
      flash[:notice] = "You must be a member of this group to edit or delete"
      redirect_to @group
    end
  end

  def edit_group_members(group)
    members = params[:group][:member_ids].reject {|id| id.empty?}
    members = members.map {|id| User.find(id)}
    group.members = members
  end

end
