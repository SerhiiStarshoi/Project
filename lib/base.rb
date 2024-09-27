# frozen_string_literal: true

require_relative 'locations/location'
require_relative 'locations/location_manager'

module Locations
  class Base

    def after(location)
      location_manager.delete(location)
    end

    def receive_token
      Authorization.new.receive_token
    end

    def before
      @location_manager = LocationManager.new(receive_token)
    end

    private

    attr_reader :location_manager
  end
end

