module Api
  class EventsController < ApiApplicationController
    def index
      fields = 'id,name,description,start_time,end_time,attending_count,
      interested_count,place,updated_time'

      if !Event.updated?
        events = []
        Api::FacebookGroups::GROUPS.each do |group|
          event = {
            group: group,
            events: fb_api
            .get_object("/#{group[:id]}/events?fields=#{fields}
              &since=#{Time.current}&until=#{1.year.from_now.to_i}")
          }
          events.push(event)
        end
        update_events(events)
      end
      @events = Event.latest
    end

    private

    def update_events(json_events)
      json_events.each do |events|
        json_group = events[:group]

        events[:events].each do |json|
          event = Event.find_or_create_by(external_id: json['id'])
          next if event.last_updated == json['updated_time'].to_datetime

          if json['place']
            location_attributes = {
              id: event.location.try(:id),
              name: json['place']['name'],
              street: json['place'].try(:[],'location').try(:[],'street'),
              zip: json['place'].try(:[],'location').try(:[],'zip'),
              city: json['place'].try(:[],'location').try(:[],'city'),
              state: json['place'].try(:[],'location').try(:[],'state'),
              country: json['place'].try(:[],'location').try(:[],'country'),
              latitude: json['place'].try(:[],'location').try(:[],'latitude'),
              longitude: json['place'].try(:[],'location').try(:[],'longitude')
            }
          end

          group = Group.find_or_create_by(external_id: json_group[:id])
          group.update(name: json_group[:name])

          event.update(
            external_id: json['id'],
            name: json['name'],
            description: json['description'],
            start_time: json['start_time'].try(:to_datetime),
            end_time: json['end_time'].try(:to_datetime),
            attending_count: json['attending_count'],
            interested_count: json['interested_count'],
            group: group
          )
          event.update(
            location_attributes: location_attributes
          ) if location_attributes
        end
      end
      BaseApi.first.update(last_updated: Time.now)
    end
  end
end
