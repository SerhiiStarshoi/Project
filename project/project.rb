require_relative 'location'

include RSpec::Matchers

def receive_token

  url = "#{ENV["AUTH_LINK"]}api/v1/email-auth"

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
# файл в якому я буду все це запускатись, типу create_location.rb (cucumber)
# api/v1/email-auth s константу
# expect в другий запит теж
# написати експект який буде перевіряти що на виході буде клас локейшен з такими полями (експрекс на кожне поле класу)



#Gemfile bundler #semantic versioning
#dependabot
# & -> query params i json body почитати
# дописати gem file і вказати що треба(буде лиш http) і запушати на гітхаб
# розбити на методи і на клас #get_token
# клас який буде створювати локейшен самий простий (оформити як окремий проект, решту видалити файлів)
# клас локейшен який буде мати базові рекваєрд поля
# клас який буде створювати (викликати апі і кріейт локейшена, передаєш дані і на виході інстанс класу локейшен)