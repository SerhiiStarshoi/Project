class Location
  attr_accessor :portal_id, :location_id, :title, :custom_title, :latitude, :longitude, :type, :address

  def initialize(params)
    @portal_id = params[:portal_id]
    @location_id = params[:location_id]
    @title = params[:title]
    @custom_title = params[:custom_title]
    @type = params[:type]
    @latitude = params[:latitude]
    @longitude = params[:longitude]
    @address = params[:address]
  end

  def location_attrs
    puts "Location Attrs:"
    puts "Portal: #{portal_id}"
    puts "Location ID: #{location_id}"
    puts "Name: #{title}"
    puts "Title: #{custom_title}"
    puts "Type: #{type}"
    puts "Latitude: #{latitude}"
    puts "Longitude: #{longitude}"
    puts "Address: #{address}"
  end

end
