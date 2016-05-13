class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(permitted_params)

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

  def permitted_params
    params.require(:event).permit(:name, :description, :url, :start_time, :email)
  end
end
