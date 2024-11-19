module API
  module Locations
    class LocationManager < API::Manager

      LOCATION_URL = "#{ENV['LM_LINK']}api/v1/locations"

      def initialize(token)
        @token = token
      end

      def create(params)
        response = location_call_create(params)
        expect(response.status).to eq(200)
        data = JSON.parse(response.body)
        Location.new(data)
      end

      def update(params, location)
        response = location_call_update(location, params)
        expect(response.status).to eq(200)
        data = JSON.parse(response.body)
        #puts "Location updated: #{data}"
        Location.new(data)
      end

      def deactivate(location)
        response = location_call_delete(location)
        expect(response.status).to eq(200)
        JSON.parse(response.body)
      end

      def get_location(location)
        response = location_call_get(location)
        expect(response.status).to eq(200)
        Location.new(JSON.parse(response.body))
      end

      def search(location_title)
        response = location_call_search(location_title)
        data = JSON.parse(response.body)

        location_data = {
          "portal_id" => 16288,
          "id" => data[0]["id"].to_i,
          "title" => data[0]["name"],
          "custom_title" => data[0]["title"],
          "type" => data[0]["type"],
          "latitude" => data[0]["latitude"],
          "longitude" => data[0]["longitude"],
          "address" => data[0]["address"],
          "activated" => data[0]["activated"]
        }

        API::Locations::Location.new(location_data)
      end

      private

      def location_call_get(location)
        location_check_url = "https://location-management.az-dev.over-haul.com/api/v1/locations/#{location.id}" #constant use like in location_call_create
        http.get(location_check_url)
      end

      def location_call_create(params)
        call_create = http.post(LOCATION_URL, json: json_attributes(params))
        expect(call_create.status).to eq(200)
        call_create
      end

      def location_call_update(location, params)
        update_url = "#{LOCATION_URL}/#{location.id}"
        call_update = http.put(update_url, json: json_attributes(params))
        expect(call_update.status).to eq(200)
        call_update
      end

      def location_call_delete(location)
        deactivate_url = "#{LOCATION_URL}/#{location.id}/deactivate"
        call_delete = http.put(deactivate_url)
        expect(call_delete.status).to eq(200)
        call_delete
      end

      def location_call_search(location_title)
        search_url = "https://location-management.az-dev.over-haul.com/api/v1/locations?page=1&per_page=10&sort=&query=#{location_title}&filters=%7B%22portal_ids%22:[],%22types%22:[],%22statuses%22:[%22active%22,%22inactive%22]%7D"
        http.get(search_url)
      end

      def json_attributes(params)
        {
          portal: {
            id: params[:portal_id]
          },
          title: params[:title],
          custom_title: params[:custom_title],
          type: params[:type],
          address: {
            latitude: params[:latitude],
            longitude: params[:longitude]
          }
        }
      end
    end
  end
end

