class Location
  attr_reader :portal_id, :title, :latitude, :longitude, :type

  def initialize(params)
    @portal_id = params[:portal_id]
    @title = params[:title]
    @type = params[:type]
    @latitude = params[:latitude]
    @longitude = params[:longitude]
  end
end
