require "rspec" # <- parent class

module Devices
  class DeviceManager
    include RSpec::Matchers # <- parent class

    attr_reader :token # <- parent class

    DEVICE_URL = "#{ENV['API_V3']}device_management/devices"

    def initialize(token)# <- parent class
      @token = token
    end

    def http # <- parent class
      HTTP.headers(accept: "application/json", authorization: "Bearer #{token}")
    end

    def create(params)
      response = device_call_create(params)
      expect(response.status).to eq(200)
      data = JSON.parse(response.body)
      Device.new(data)
    end

    def update(device, params)
      response = device_call_update(device, params)
      expect(response.status).to eq(200)
      data = JSON.parse(response.body)
      Device.new(data)
    end

    def deactivate(device)
      response = device_call_delete(device)
      expect(response.status).to eq(200)
      puts "Device with id: #{device.id} was deactivated"
    end

    def search(device_imei)
      response = device_call_search(device_imei)
      data = JSON.parse(response.body)

      return nil if data.empty?

      device_data = {
        "portal_id" => 16288,
        "imei" => data[0]["device_id"],
        "id" => data[0]["id"].to_i,
        "model_type_name" => data[0]["device_model"],
        "lm_origin_location" => data[0]["origin"],
        "active" => data[0]["active"],
        "device_status" => data[0]["stage"],
      }

      Device.new(device_data)
    end

    private

    def device_call_create(params)
      call_create = http.post(DEVICE_URL, json: json_attributes(params))
      expect(call_create.status).to eq(200)
      call_create
    end

    def device_call_update(device, params)
      update_url = "#{DEVICE_URL}/#{device.id}"
      call_update = http.put(update_url, json: json_attributes(params))
      expect(call_update.status).to eq(200)
      call_update
    end

    def device_call_delete(device)
      deactivate_url = "#{DEVICE_URL}/#{device.id}"
      call_delete = http.delete(deactivate_url)
      expect(call_delete.status).to eq(200)
      call_delete
    end

    private

    def device_call_search(query)
      filters = { "active_statuses" => ["inactive"] }
      search_url = "#{DEVICE_URL}?&#query=#{query}"
      puts "Search url: #{search_url}"
      http.get(search_url, params: { query: query, filters: filters.to_json })
    end

    def json_attributes(params)
      {
        portal_id: params[:portal_id],
        imei: params[:imei],
        device_type_id: params[:device_type_id],
        lm_origin_location: params[:lm_origin_location]
      }
    end
  end
end
