require 'rspec'
require 'http'

class Authorization
  include RSpec::Matchers

  EMAIL_AUTH = "api/v1/email-auth"
  def receive_token

    url = "#{ENV["AUTH_LINK"]}#{EMAIL_AUTH}"

    response = HTTP.headers(accept: "application/json")
                   .post(url, json: { email: ENV["EMAIL"], password: ENV["PASSWORD"] })

    expect(response.status).to eq(200) # This matcher checks if the status code is in the 2xx range

    token = response['Authorization']
    token.sub("Bearer ", "")
  end
end


