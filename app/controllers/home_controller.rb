class HomeController < ApplicationController
  def index
    @events = Event.authorized
  end
end