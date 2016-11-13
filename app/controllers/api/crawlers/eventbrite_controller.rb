module Api::Crawlers
  class EventbriteController < Api::ApplicationController
    BASE_URL = "https://www.eventbriteapi.com/v3/"

    def self.create_or_update_events
      search_events.each do |result|
        event = Event.find_or_initialize_by(external_id: result['id'])
        last_updated = result['changed'].to_datetime

        next unless result['venue']['address']['country'] == 'MY'
        next if event.last_updated == last_updated

        event.update(event_hash(event, result))
      end
    end

    private

    def self.search_events
      url = BASE_URL +
        "events/search?"\
        "token=#{ENV['EVENTBRITE_TOKEN']}"\
        "&location.address=#{ENV['COUNTRY']}"\
        "&categories=102"\
        "&expand=venue,organizer"\
        "&price=free"\
        "&format=json"
      response = make_request(URI.escape(url))['events']
      response.present? ? response : []
    end

    def self.find_or_create_group(json)
      group = Group.find_or_initialize_by(external_id: json['id'])
      group_status = group.status || 'authorized'
      group.update(
        status: group_status,
        name: json['name'],
        url: json['url']
      )
      group.save
      group
    end

    def self.event_hash(event, json)
      venue = json['venue']
      group = find_or_create_group(json['organizer'])
      status = event.status || 'authorized'

      {
        url: json['url'],
        name: json['name']['text'],
        status: status,
        entry_type: 'automated',
        description: json['description']['text'],
        start_time: json['start']['utc'].to_datetime,
        last_updated: json['changed'].to_datetime,
        group: group,
        location_attributes: {
          name: venue.try(:[],'name'),
          street: venue.try(:[], 'address').try(:[], 'address_1'),
          city: venue.try(:[], 'address').try(:[], 'city'),
          state: venue.try(:[],'region'),
          country: ENV['COUNTRY'],
          latitude: venue['latitude'],
          longitude: venue['longitude']
        }
      }
    end

    def self.make_request(url)
      JSON.parse(HTTParty.get(url).body)
    end
  end
end