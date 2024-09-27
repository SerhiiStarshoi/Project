require "securerandom"

require_relative "../lib/authorization"
require_relative "../lib/base"

module Tests
  class Base
    def whole_test
      before_action
      test_action
      #after_action(location) #лежати окремо, забрати в бейз
    end

    def before_action
      @location_manager = LocationManager.new(receive_token)
    end

    def after_action(location)
      location_manager.delete(location)
    end

    def receive_token
      Authorization.new.receive_token
    end

    private

    attr_reader :location_manager
  end
end
