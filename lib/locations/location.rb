module Locations
  class Location
    attr_reader :portal_id, :id, :title, :custom_title, :latitude, :longitude, :type, :address, :activated

    def initialize(data)
      @data = data
      @portal_id = data["portal"]["id"]
      @id = data["id"]
      @title = data["name"]
      @custom_title = data["title"]
      @type = data["type"]
      @latitude = data["latitude"]
      @longitude = data["longitude"]
      @address = data["address"]
      @activated = data["activated"]
    end

    def to_s #вияснити чому не виводить puts = p
      data
    end

    def inspect
      data
    end

    private

    attr_reader :data
  end
end
