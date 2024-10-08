require 'bigdecimal'
require "http"
require "rspec"
require "securerandom"

require_relative "../../lib/locations"
require_relative "../../tests"

require_relative "../../lib/authorization"
require_relative "../../lib/locations/location"
require_relative "../../lib/locations/location_manager"
require_relative "../../tests/base"
require_relative "../../tests/create"
require_relative "../../tests/update"
require_relative "../../tests/deactivate"
