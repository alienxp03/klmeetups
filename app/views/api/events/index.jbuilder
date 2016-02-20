json.ignore_nil!
json.array! @events do |event|
  json.partial! 'api/partial/event', event: event
end
