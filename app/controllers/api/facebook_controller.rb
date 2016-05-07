# Api::FacebookController

module Api
  class FacebookController < Api::ApplicationController
    def self.update_events
      fields = 'id,name,description,start_time,end_time,attending_count,
      interested_count,place,updated_time'

      events = []

      Group.facebook.authorized.each do |group|
        event = {
          group: group,
          events: @@fb_api
          .get_object("/#{group.external_id}/events?fields=#{fields}"\
            "&since=#{Time.current}&until=#{1.year.from_now.to_i}")
        }
        events.push(event)
      end
      fetch_latest(events)
    end

    private

    def self.fetch_latest(json_events)
      json_events.each do |events|
        group = events[:group]
        events[:events].each do |json|
          next if ['malaysia', 'my'].exclude?(json['place']
            .try(:[],'location').try(:[],'country').try(:downcase))

          event = Event.find_or_initialize_by(external_id: json['id'])
          
          next if event.last_updated == json['updated_time'].to_datetime

          event.update(event_hash(json, group))
        end
      end
    end

    def self.event_hash(json, group)
      location_attributes = {
        name: json['place']['name'],
        street: json['place'].try(:[],'location').try(:[],'street'),
        zip: json['place'].try(:[],'location').try(:[],'zip'),
        city: json['place'].try(:[],'location').try(:[],'city'),
        state: json['place'].try(:[],'location').try(:[],'state'),
        country: json['place'].try(:[],'location').try(:[],'country'),
        latitude: json['place'].try(:[],'location').try(:[],'latitude'),
        longitude: json['place'].try(:[],'location').try(:[],'longitude')
      } if json['place']

      event = {
        external_id: json['id'],
        url: "https://www.facebook.com/events/#{json['id']}/",
        name: json['name'],
        description: json['description'],
        start_time: json['start_time'].try(:to_datetime),
        end_time: json['end_time'].try(:to_datetime),
        group_attributes: {
          external_id: group.external_id,
          name: group.name,
          url: "https://www.facebook.com/groups/#{group.external_id}/"
        }
      }
      event['location_attributes'] = location_attributes if location_attributes
      event
    end
  end
end
