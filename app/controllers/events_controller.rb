class EventsController < ApplicationController
  def index
    @events = Event.latest
  end

  def add
  end
end
