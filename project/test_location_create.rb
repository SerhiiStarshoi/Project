require_relative 'Authorization'
require_relative 'Location'
require_relative "LocationManager"
require "securerandom"

authorization = Authorization.new
token = authorization.receive_token
puts "Authorization token: #{token}"

create_params = {
  portal_id: 16288,
  title: SecureRandom.alphanumeric(11),
  custom_title: "some title",
  type: "Standard",
  latitude: "47.444956",
  longitude: "18.960501"
}

location_creator = LocationManager.new(token)
location = location_creator.create(create_params)

location.location_attrs

expect(location.address).to eq("Budaörs, Akron Utca 2, 2040, Pest, Hungary")
