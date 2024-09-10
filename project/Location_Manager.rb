
class LocationManager
  attr_reader :token

  LOCATION_URL = "#{ENV['LM_LINK']}api/v1/locations"

  def initialize(token)
    @token = token
  end

  def create(params)
    response = location_call_create(params)
    if response.status == 200
      expect(response.status).to eq(200)
      data = JSON.parse(response.body)
      #puts data
      location = Location.new(portal_id: data["portal"]["id"], location_id: data["id"], title: data["name"], custom_title: data["title"], type: data["type"], latitude: data["latitude"], longitude: data["longitude"], address: data["address"])
      #puts location.location_id #tap
      #location
    else
      nil
    end
  end

  def update(params, location_id)
    response = location_call_update(params, location_id)
    expect(response.status.code).to eq(200) #будуть нюанси, почитати за модулі
    #expect(response.body.empty?) eq("false") #використати матчер для перевірки трк чи фолс
    data = JSON.parse(response.body)
    puts "Location updated: #{data}"

    #Location new має передаватись лише дата, в самому класі треба її вже діставати
    Location.new(portal_id: data["portal"]["id"], title: data["name"], custom_title: data["title"], type: data["type"], latitude: data["latitude"], longitude: data["longitude"], address: data["address"])
  end

  def delete(location_id)
    response = location_call_delete(location_id)

    data = JSON.parse(response.body)
    puts "Location deleted: #{data}"
  end

  private

  def location_call_create(params)
    HTTP.headers(accept: "application/json", authorization: "Bearer #{token}")
        .post(LOCATION_URL, json: json_attributes(params))
  end

  def location_call_update(params, created_location) #приймає обєкт локацію, тоді змінна не потрібна
    location_id = created_location.location_id
    update_url = "#{ENV['LM_LINK']}api/v1/locations/#{location_id}"
    # https://location-management.az-dev.over-haul.com/api/v1/locations/5797710

    puts "URL of location to be updated: #{update_url}"

    HTTP.headers(accept: "application/json", authorization: "Bearer #{token}")
        .put(update_url, json: json_attributes(params))
  end

  def location_call_delete(location_id)
    deactivate_url = "#{ENV['LM_LINK']}api/v1/locations/#{location_id}/deactivate"
    # https://location-management.az-dev.over-haul.com/api/v1/locations/5159006/deactivate

    puts "URL of location to be deleted: #{location_id}"
    puts "Deactivate URL: #{deactivate_url}"

    HTTP.headers(accept: "application/json", authorization: "Bearer #{token}")
        .put(deactivate_url)
  end

  def json_attributes(params)
    {
      portal: {
        id: params[:portal_id]
      },
      title: params[:title],
      custom_title: params[:custom_title],
      type: params[:type],
      address: {
        latitude: params[:latitude],
        longitude: params[:longitude]
      }
    }
  end
end
