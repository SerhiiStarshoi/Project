require_relative 'location'

include RSpec::Matchers

EMAIL_AUTH = "api/v1/email-auth"

def receive_token

  url = "#{ENV["AUTH_LINK"]}{EMAIL_AUTH}"

  response = HTTP.headers(accept: "application/json")
                 .post(url, json: { email: ENV["EMAIL"], password: ENV["PASSWORD"] })

  # expect if 200 OK
expect(response.status).to eq(200) # This matcher checks if the status code is in the 2xx range

  token = response['Authorization']
  token.sub("Bearer ", "")
end

locations_url = "#{ENV["LM_LINK"]}api/v1/locations"

# Fetch the token and create the location
puts "Authorization token: #{receive_token}"

response = location.location_call(receive_token, locations_url)
puts response.body

location = Location.new(response.body.to_json)

location_creator = LocationCreator.new
location = location_creator.create(portal_id: 16288, title: "location_6520", latitude: "47.444956", longitude: "18.960501")

#file conf rubocop
# project = class location_creator
# має бути метод кріейт який приймає хеш з параметрами ключ - тайтл
# один публічний метод кріейт
# перейменувати файл відповідно до класу
# клас авторизації з методом receive_token який викликаю в кріейті
# ++++ файл в якому я буду все це запускатись, типу create_location.rb (cucumber)
# ++++ api/v1/email-auth s константу
# expect в другий запит теж
# написати експект який буде перевіряти що на виході буде клас локейшен з такими полями (експрекс на кожне поле класу)
#
# gitignore (всі файли які не треба) має лижати в корені і додати папку ідеа
# git push IDE розібратись чого не пушає
# видалити з гіта через консольку папку idea (??)
# поставити sublime text
