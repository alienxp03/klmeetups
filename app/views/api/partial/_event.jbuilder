json.set! :id,    event.external_id
json.name         event.name
json.description  event.description
json.start_time   event.start_time
json.end_time     event.end_time
json.attending    event.attending_count
json.interested   event.interested_count

json.partial! 'api/partial/group', group: event.group

if event.location
  json.set! :location do  
    json.partial! 'api/partial/location', location: event.location
  end
end
