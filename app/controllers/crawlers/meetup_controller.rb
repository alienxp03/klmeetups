module Crawlers
  class MeetupController < ApplicationController
    BASE_URL = "https://api.meetup.com/2/open_events?"\
      "&sign=true"\
      "&key=#{ENV['MEETUP_API_KEY']}"\
      "&country=#{ENV['COUNTRY']}"\
      "&city=#{ENV['CITY']}"\
      "&time=#{Time.now.to_i * 1000},#{3.months.from_now.to_i * 1000}"\
      "&category=34"

    def self.search_events
      make_request(URI.escape(BASE_URL))['results'].each do |result|
        event = Event.find_or_initialize_by(external_id: result['id'])
        last_updated = DateTime.strptime((result['updated'] / 1000).to_s,'%s')

        next if event.last_updated == last_updated
        group = group(result['group'])
        event.update(event_hash(result, group)) if group.authorized?
      end
    end

    private

    def self.group(json)
      group = Group.meetup.find_or_initialize_by(external_id: json['id'])
      group_status = group.status || 'authorized'
      group.update(
        status: group_status,
        name: json['name'],
        url: "http://www.meetup.com/#{json['urlname']}/"
      )
      group.save
      group
    end

    def self.lat_long_from_json(json)
      venue = json['venue']

      return unless venue.try(:[], 'lat') && venue.try(:[], 'lon')

      latitude = venue['lat'] == 0 ? nil : venue['lat']
      longitude = venue['lon'] == 0 ? nil : venue['lon']
      [latitude, longitude]
    end

    def self.event_hash(json, group)
      lat, lon = lat_long_from_json(json)
      venue = json['venue']

      {
        external_id: json['id'],
        url: json['event_url'],
        name: json['name'],
        status: 'authorized',
        entry_type: 'automated',
        description: json['description'],
        start_time: DateTime.strptime((json['time'] / 1000).to_s,'%s'),
        last_updated: DateTime.strptime((json['updated'] / 1000).to_s,'%s'),
        group: group,
        location_attributes: {
          name: venue.try(:[],'name'),
          full_address: json['name'],
          street: venue.try(:[], 'address_1'),
          city: ENV['CITY'],
          state: venue.try(:[],'state'),
          country: ENV['COUNTRY'],
          latitude: lat,
          longitude: lon
        }
      }
    end
  end
end
