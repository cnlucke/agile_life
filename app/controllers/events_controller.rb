class EventsController < ApplicationController
  def index
    @type = 'Event'
    @created = Item.created(current_user).select { |i| i.type == @type  }
    @owned = Item.owned(current_user).select { |i| i.type == @type  }
  end

  def show
    @item = Event.find_by(id: params[:id])
  end

  def new
    @item = Event.new(creator_id: current_user.id)
    @items = Event.all
    @groups = Group.all
    @users = User.all
  end

  def create
    if params["event"]["check_box"] == 0
      @event = Event.create(event_params)
      redirect_to event_path(@event)
    else
      @event = Event.create(event_params)
      all_day_start_date = @event.start_date
      redirect_to event_path(@event)
    end
  end

  def edit
    @item = Event.find_by(id: params[:id])
    @items = Event.all
    @groups = Group.all
    @users = User.all
  end

  def update
    @event = Event.find_by(id: params[:id])
    if params["check_box"].nil?
      @event.update(event_params)
      redirect_to event_path
    else
      @event.update(event_params)
      @event.starts_at = @event.starts_at.change({ hour: 0, min: 0, sec: 0 })
      @event.ends_at = @event.ends_at.change({ hour: 0, min: 0, sec: 0 })
      @event.save
      redirect_to event_path(@event)
    end
  end

  def destroy
    @event = Event.find_by(id: params[:id])
    @event.destroy
    redirect_to events_path
  end

  private
  def event_params
    params.require(:event).permit(:creator_id, :group_id, :owner_id, :parent_id, :title, :description, :status, :notes, :starts_at, :ends_at)
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
