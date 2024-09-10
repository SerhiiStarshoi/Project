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

location_updater = LocationManager.new(token)
updated_location = location_updater.update(create_params, location)

aggregate_failures do
  expect(updated_location.address).to eq("Budaörs, Akron Utca 2, 2040, Pest, Hungary")
  expect(updated_location.latitude).to eq(47.14431)
  expect(updated_location.type).to eq("Standard")
  puts "End"
end

deleted_location = LocationManager.new(token)

deleted_location.delete(location.location_id)





# обидва тести як окремі класи
# апдейт і кріейт один клас +++++
# назва класу = назва файлу +++++
# після кожного тесту той локейшен який ми створили він деактивовується (буде в одному ж класі з іншими)++++
# #приймає обєкт локацію, тоді змінна не потрібна ++++
# постаратись не дублювати код з інших класів (наслідування)

# почитати за cucumber наперед (cucmber ruby! (cucmber.org))
# rake що таке, і для чого він
