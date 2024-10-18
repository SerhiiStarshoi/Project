require "http"
require "rspec"

class Authorization
  include RSpec::Matchers

  EMAIL_AUTH = "api/v1/email-auth"

  def http
    HTTP.headers(accept: "application/json")
  end
  def receive_token(user)

    url = "#{ENV["AUTH_LINK"]}#{EMAIL_AUTH}"

    if user == "admin"
      response = http.post(url, json: { email: ENV["ADMIN_EMAIL"], password: ENV["PASSWORD"] })
      expect(response.status).to eq(200)
    elsif user == "broker"
      response = http.post(url, json: { email: ENV["BROKER_EMAIL"], password: ENV["PASSWORD"] })
      expect(response.status).to eq(200)
    else
      puts "No such user"
    end

    token = response['Authorization']
    token.sub("Bearer ", "")
  end
end


