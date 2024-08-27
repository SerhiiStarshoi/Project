class Location
  attr_reader :portal_id, :title, :latitude, :longitude, :type

  def initialize(params)
    @portal_id = params[:portal_id]
    @title = params[:title]
    @type = params[:type]
    @latitude = params[:latitude]
    @longitude = params[:longitude]
  end

  def json_attributes
    {
      portal: {
        id: portal_id
      },
      title: title,
      type: type,
      address: {
        latitude: latitude,
        longitude: longitude
      }
    }
  end

  def location_call(token, locations_url)
    response = HTTP.headers(accept: "application/json", authorization: "Bearer #{token}")
                   .post(locations_url, json: json_attributes)
  end
end


#def location_call має бути в іншому класі location_creator