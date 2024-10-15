require_relative "../authorization"

module Devices
  class Device
    attr_reader :portal_id, :imei, :id, :device_model, :origin_location, :activated

    def initialize(data)
      @portal_id = data["portal_id"]
      @imei = data["imei"]
      @id = data["id"]
      @device_model = data["model_type_name"]
      @origin_location = data["lm_origin_location"]
      @activated = data["active"]
    end
    private

    attr_reader :data
  end
end
