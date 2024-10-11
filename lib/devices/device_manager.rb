require "rspec"
require_relative "devices"

module Devices
  class DeviceManager
    include RSpec::Matchers

    attr_reader :token

    DEVICE_URL = "#{ENV['API_V3']}device_management/devices"

    def initialize(token)
      @token = token
    end

    def http
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
      #puts "The data: #{data}"
      #dev = Device.new(data)
      data[0]["active"]

      #The data: [{"id"=>2473475,
      # "active"=>false,
      # "asset"=>nil,
      # "assigned_to_origin_at"=>nil,
      # "battery_level"=>nil,
      # "certification_data"=>nil,
      # "created_at"=>"2024-10-15T10:15:23.050Z",
      # "description"=>nil, "device_id"=>"103559748930",
      # "device_model"=>"001den",
      # "editable"=>true,
      # "enabled"=>true,
      # "in_stage"=>"2024-10-15T10:15:23.045Z",
      # "last_location"=>nil,
      # "last_ping"=>nil,
      # "last_shipment_id"=>nil,
      # "origin"=>nil,
      # "portal_name"=>"ssportal",
      # "report_status"=>"red",
      # "returned_at"=>nil,
      # "reusable_type"=>"Reusable",
      # "shipment_created_at"=>nil,
      # "shipment_delivered_at"=>nil,
      # "shipment_id"=>nil,
      # "shipments_count"=>0, "stage"=>{"stage"=>"assigned_to_portal", "off"=>false},
      # "tag_devices"=>[], "timezone"=>"UTC", "trailer_id"=>nil, "updated_at"=>"2024-10-15T10:15:23.536Z",
      # "vendor_name"=>"01Denys_upd"}]
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
      puts "Device is: #{device}"
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
