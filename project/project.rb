
require "http"
require "bundler/inline"
require_relative 'location'

gemfile do
  source "https://rubygems.org"
  gem "rspec", "~> 3.9"
end

include RSpec::Matchers



def receive_token

  url = "#{ENV["AUTH_LINK"]}api/v1/email-auth"

  response = HTTP.headers(accept: "application/json")
                 .post(url, json: { email: ENV["EMAIL"], password: ENV["PASSWORD"] })

  # expect if 200 OK
  unless expect(response.status).to be_success # This matcher checks if the status code is in the 2xx range
    puts "Request failed"
  end

  token = response['Authorization']
  token.sub("Bearer ", "")
end

locations_url = "#{ENV["LM_LINK"]}api/v1/locations"
location = Location.new(16288, "location_6520", "47.444956", "18.960501")

# Fetch the token and create the location
puts "Authorization token: #{receive_token}"

response = location.location_call(receive_token, locations_url)
puts response.body
#gemfile bundler #semantic versioning
#dependabot
# & -> query params i json body почитати

# дописати gem file і вказати що треба(буде лиш http) і запушати на гітхаб
# розбити на методи і на клас #get_token
# клас який буде створювати локейшен самий простий (оформити як окремий проект, решту видалити файлів)
# клас локейшен який буде мати базові рекваєрд поля
# клас який буде створювати (викликати апі і кріейт локейшена, передаєш дані і на виході інстанс класу локейшен)