class EventsController < ApplicationController
  before_action :load_available_items, :authorize!, :set_type

  def index
    @created = Event.created(current_user)
    @sorted_events = sorted_events
  end

  def show
    @item = Event.find(params[:id])
  end

  def new
    @item = Event.new
    @groups = Group.all
    @users = User.all
  end

  def create
    if params["check_box"]
      @item = Event.create!(event_params)
      @item.set_all_day
      flash[:notice] = "Event successfully created."
      redirect_to event_path(@item)
    else
      @item = Event.create!(event_params)
      flash[:notice] = "Event successfully created."
      redirect_to event_path(@item)
    end
  end

  def edit
    @item = Event.find(params[:id])
    @type = @item.type
    @groups = Group.all
    @users = User.all
    @available_items = @available_items.reject {|item| @item.id == item.id}
  end

  def update
    @item = Event.find(params[:id])
    @available_items = @available_items.reject {|item| @item.id == item.id}

    if params["check_box"].nil?
      @item.update!(event_params)
      flash[:notice] = "Event successfully updated."
      redirect_to event_path
    else
      @item.update!(event_params)
      @item.set_all_day
      flash[:notice] = "Event successfully updated."
      redirect_to event_path(@item)
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "Event successfully deleted."
    redirect_to events_path
  end

  private
  def load_available_items
    @available_items = Event.all
  end

  def event_params
    params.require(:event).permit(:creator_id, :group_id, :owner_id, :parent_id, :title, :description, :status, :notes, :starts_at, :ends_at)
  end

  def sorted_events
    current_user.created_events.sort{|x,y| x.starts_at <=> y.starts_at}
  end

  def set_type
    @type = "Event"
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
