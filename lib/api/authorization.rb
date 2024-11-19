
module API
  class Authorization
    include RSpec::Matchers

    EMAIL_AUTH = "api/v1/email-auth"

    def http
      HTTP.headers(accept: "application/json")
    end
    def receive_token(user)

      url = "#{ENV["AUTH_LINK"]}#{EMAIL_AUTH}"
      response = http.post(url, json: { email: user["email"], password: user["password"] })

      expect(response.status.code).to eq(200)

      token = response['Authorization']
      token.sub("Bearer ", "")
    end
  end
end



