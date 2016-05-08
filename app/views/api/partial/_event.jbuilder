json.set! :id,    event.external_id
json.url          event.url
json.name         event.name
json.description  event.description
json.start_time   event.start_time
json.end_time     event.end_time

json.set! :group do
  json.partial! 'api/partial/group', group: event.group
end

if event.location
  json.set! :location do
    json.partial! 'api/partial/location', location: event.location
  end
end
