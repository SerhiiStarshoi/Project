module API
  class Manager
    include RSpec::Matchers

    attr_reader :token
    def http
      HTTP.headers(accept: "application/json", authorization: "Bearer #{token}")
    end
  end
end

