module Tests
  class Base
    include RSpec::Matchers

    def whole_test
      before_action
      test_action
    end

    def before_action
      @location_manager = Locations::LocationManager.new(receive_token)
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
