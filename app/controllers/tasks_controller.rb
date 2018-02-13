class TasksController < ApplicationController
  def index
    @type = 'Task'
    @created = Item.created(current_user).select { |i| i.type == @type  }
    @owned = Item.owned(current_user).select { |i| i.type == @type  }
  end

  def show
    @item = Task.find_by(id: params[:id])
  end

  def new
    @item = Task.new(creator_id: current_user.id)
    @items = Task.all
    @groups = Group.all
    @users = User.all
  end

  def create
    @task = Task.create(task_params)
    redirect_to task_path(@task)
  end

  def edit
    @item = Task.find_by(id: params[:id])
    @items = Task.all
    @groups = Group.all
    @users = User.all
  end

  def update
    @task = Task.find_by(id: params[:id])
    @task.update(task_params)
    redirect_to task_path
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private
  def task_params
    params.require(:task).permit(:creator_id, :group_id, :owner_id, :parent_id, :title, :description, :status, :notes, :starts_at, :ends_at)
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
