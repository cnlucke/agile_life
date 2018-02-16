class TasksController < ApplicationController
  before_action :load_available_items, :authorize!, :set_type

  def index
    @tasks = Task.all
    @created = Task.created(current_user).select { |t| t.owner_id != current_user.id }
    @owned = Task.owned(current_user)
    @unassigned = Task.unassigned
  end

  def show
    @item = Task.find(params[:id])
  end

  def new
    @item = Task.new
    @type = @item.type
    @groups = Group.all
    @users = User.all
  end

  def create
    @item = Task.create!(task_params)
    flash[:notice] = "Task successfully created."
    redirect_to task_path(@item)
  end

  def edit
    @item = Task.find(params[:id])
    @groups = Group.all
    @users = User.all
    @available_items = @available_items.reject {|item| @item.id == item.id}
  end

  def update
    @item = Task.find(params[:id])
    @item.update!(task_params)
    flash[:notice] = "Task successfully updated."
    redirect_to task_path
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = "Task successfully deleted."
    redirect_to tasks_path
  end

  private

  def load_available_items
    @available_items = Task.all
  end

  def task_params
    params.require(:task).permit(:creator_id, :group_id, :owner_id, :parent_id, :title, :description, :status, :notes, :starts_at, :ends_at)
  end

  def set_type
    @type = "Task"
  end

  #  type        :string
  #  creator_id  :integer
  #  group_id    :integer
  #  owner_id    :integer
  #  parent_id   :integer
  #  title       :string
  #  description :string
  #  status      :string
  #  notes       :text
  #  starts_at   :datetime
  #  ends_at     :datetime
end
