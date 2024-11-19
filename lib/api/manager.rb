module API
  class Manager
    include RSpec::Matchers

    attr_reader :token

    def initialize(token)
      @token = token
    end

    private

    def http
      HTTP.headers(accept: "application/json", authorization: "Bearer #{token}")
    end
  end
end

