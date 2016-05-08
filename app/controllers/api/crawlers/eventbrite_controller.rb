module Api::Crawlers
  class EventbriteController < Api::ApplicationController
    BASE_URL = "https://www.eventbriteapi.com/v3/"

    def self.create_or_update_events
      search_events.each do |result|
        event = Event.find_or_initialize_by(external_id: result['id'])
        last_updated = result['changed'].to_datetime

        next if event.last_updated == last_updated
        updated = event.update(event_hash(event, result))
      end
    end

    private

    def self.search_events
      url = BASE_URL +
        "events/search?"\
        "token=#{ENV['EVENTBRITE_TOKEN']}"\
        "&venue.country=#{ENV['COUNTRY']}"\
        "&categories=102"\
        "&format=json"
      make_request(URI.escape(url))['events']
    end

    def self.search_group(id)
      url = BASE_URL +
      "organizers/6903698963?"\
      "token=#{ENV['EVENTBRITE_TOKEN']}"\
      "&format=json"
      make_request(url)
    end

    def self.search_venue(id)
      url = BASE_URL +
      "venues/#{id}?"\
      "token=#{ENV['EVENTBRITE_TOKEN']}"\
      "&format=json"
      make_request(url)
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
      venue = search_venue(json['venue_id'])
      address = venue.try(:[], 'address')

      group = find_or_create_group(search_group(json['organizer_id']))

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
          street: address.try(:[], 'address_1'),
          city: address.try(:[], 'city'),
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