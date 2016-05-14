class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(new_event_params)

    if @event.save
    else
      flash[:danger] = 'Please complete the form with valid data'
      render :new, event: @event
    end
  end

  def index
    @events = Event.authorized
  end

  private

  def new_event_params
    permitted_params.merge(
      entry_type: 'manual',
      status: 'authorized'
    )
  end

  def permitted_params
    params.require(:event)
      .permit(:name, :description, :url, :start_time,:email,
        location_attributes: [])
  end
end
