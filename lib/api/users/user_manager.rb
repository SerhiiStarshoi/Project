require_relative "user"

module API
  class UserManager < Manager

    def search_user_api(email)
      response = user_call_search(email)
      search_array = JSON.parse(response.body)

      return nil if search_array.empty?

      puts "User created: #{search_array}"
      User.new(search_array.first)
    end

    def deactivate_user_api(user_id)
      deactivate_url = "#{ENV['APP_URL']}api/v2/users/#{user_id}/deactivate"
      HTTP.headers(accept: "application/json", authorization: "Bearer #{@token}").put(deactivate_url)
    end

    private

    def user_call_search(email)
      search_url = "#{ENV['APP_URL']}api/v2/user_brokers?&query=#{email}"
      HTTP.headers(accept: "application/json", authorization: "Bearer #{@token}").get(search_url)
    end
  end
end

