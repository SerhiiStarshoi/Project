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

deleted_location = LocationManager.new(token)
deleted_location.delete(location.location_id)

aggregate_failures do
  
end





# обидва тести як окремі класи ++++
# апдейт і кріейт один клас +++++
# назва класу = назва файлу +++++
# після кожного тесту той локейшен який ми створили він деактивовується (буде в одному ж класі з іншими)++++
# #приймає обєкт локацію, тоді змінна не потрібна ++++
# захаркоджених значень немає бути #UPDATED ++++++
# постаратись не дублювати код з інших класів (наслідування)

# почитати за cucumber наперед (cucmber ruby! (cucmber.org))
# rake що таке, і для чого він
