
require_relative 'authorization'
require_relative 'location'

location_url = "#{ENV['LM_LINK']}api/v1/locations"

class CreateLocation
  def initialize(location)
    @location = location
  end

  def json_attributes
    {
      portal: {
        id: @location.portal_id
      },
      title: @location.title,
      type: @location.type,
      address: {
        latitude: @location.latitude,
        longitude: @location.longitude
      }
    }
  end

  def location_call(token, location_url)
    response = HTTP.headers(accept: "application/json", authorization: "Bearer #{token}")
                   .post(location_url, json: json_attributes)

    expect(response.status).to eq(200)

    response
  end

  def create(token, location_url)
    location_call(token, location_url)
  end
end

authorization = Authorization.new
token = authorization.receive_token
puts "Authorization token: #{token}"


location = Location.new(
  portal_id: 16288,
  title: "sds11s32sss",
  type: "Standard",
  latitude: "47.444956",
  longitude: "18.960501"
)

location_creator = CreateLocation.new(location)
response = location_creator.create(token, location_url)

body = JSON.parse(response.body).to_h
puts body

expect(body["address"]).to eq("Budaörs, Akron Utca 2, 2040, Pest, Hungary")
expect(body["activated"]).to eq(true)
expect(body["type"]).to eq(location.type)
expect(body["portal"]).to eq("id"=>16288, "name"=>"ssportal")
expect(body["portal"]["id"]).to eq(16288)



  # ++++ file conf rubocop
  # ++++ project = class location_creator
  # ++++ має бути метод кріейт який приймає хеш з параметрами ключ - тайтл
  # ++++ один публічний метод кріейт
  # ++++ перейменувати файл відповідно до класу
  # ++++ клас авторизації з методом receive_token який викликаю в кріейті
  # ++++ файл в якому я буду все це запускатись, типу create_location.rb (cucumber)
  # ++++ api/v1/email-auth s константу
  # ++++ expect в другий запит теж
  # ++++ написати експект який буде перевіряти що на виході буде клас локейшен з такими полями (експрекс на кожне поле класу)
  # ++++ def location_call має бути в іншому класі location_creator
  #
  # ++++ gitignore (всі файли які не треба) має лижати в корені і додати папку ідеа
  # git push IDE розібратись чого не пушає
  # видалити з гіта через консольку папку idea (??)
  # поставити sublime text
