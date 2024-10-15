require "http"
require "rspec"
require "securerandom"

require_relative "../../lib/authorization"
require_relative "../../lib/devices/device_manager"
require_relative "../../lib/locations"
require_relative "../../lib/locations/location"
require_relative "../../lib/locations/location_manager"
require_relative "../../tests"
require_relative "../../tests/base"
require_relative "../../tests/create"
require_relative "../../tests/deactivate"
require_relative "../../tests/update"


Before do
  authorization = Authorization.new
  @location_manager = Locations::LocationManager.new(authorization.receive_token("broker"))
  @device_manager = Devices::DeviceManager.new(authorization.receive_token("admin"))
end
