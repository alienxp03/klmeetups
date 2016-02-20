module Api
  class MeetupController < ApiApplicationController
    BASE_URL = "https://api.meetup.com/2/open_events?"\
      "&sign=true"\
      "&key=#{ENV['MEETUP_API_KEY']}"\
      "&country=#{ENV['COUNTRY']}"\
      "&city=#{ENV['CITY']}"\
      "&time=#{Time.now.to_i * 1000},#{3.months.from_now.to_i * 1000}"\
      "&category=34"

    def self.update_events
      make_request(URI.escape(BASE_URL))['results'].each do |result|
        event = Event.find_or_create_by(external_id: result['id'])
        last_updated = DateTime.strptime((result['updated'] / 1000).to_s,'%s')
        
        next if event.last_updated == last_updated
        event.update(event_hash(result))
      end
    end

    private

    def self.event_hash(json)
      lat =
        if json['venue'].try(:[], 'lat')
          json['venue']['lat'] == 0 ? nil : json['venue']['lat']
        else
          nil
        end

      lon =
        if json['venue'].try(:[], 'lon')
          json['venue']['lon'] == 0 ? nil : json['venue']['lon']
        else
          nil
        end

      {
        external_id: json['id'],
        name: json['name'],
        description: json['description'],
        start_time: DateTime.strptime((json['time'] / 1000).to_s,'%s'),
        attending_count: json['headcount'],
        last_updated: DateTime.strptime((json['updated'] / 1000).to_s,'%s'),
        group_attributes: {
          external_id: json['group']['id'],
          name: json['group']['name']
        },
        location_attributes: {
          name: json['venue'].try(:[],'name'),
          street: json['venue'].try(:[], 'address_1'),
          city: ENV['CITY'],
          state: json['venue'].try(:[],'state'),
          country: ENV['COUNTRY'],
          latitude: lat,
          longitude: lon
        }
      }
    end

    def self.make_request(url)
      JSON.parse(HTTP.get(url).to_s)
    end
  end
end
