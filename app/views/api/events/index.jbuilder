json.ignore_nil!

json.set! :meta do
  json.total_events   @events.count
end

json.set! :events do
  json.array! @events do |event|
    json.partial! 'api/partial/event', event: event
  end
end
