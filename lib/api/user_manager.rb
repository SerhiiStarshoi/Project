
class UserManager

  def initialize(token)
    @token = token
  end

  def search_user(email)
    response = user_call_search(email)
    search_array = JSON.parse(response.body)

    return nil if search_array.empty?

    puts "User created: #{search_array}"
    User.new(search_array.first)
  end

  def user_call_search(email)
    search_url = "#{ENV['APP_URL']}api/v2/user_brokers?&query=#{email}"
    puts search_url
    response = HTTP.headers(accept: "application/json", authorization: "Bearer #{@token}").get(search_url)
    puts "RESPONSE: #{response}"
    response
  end

  def deactivate_user_api(user_id)
    deactivate_url = "#{ENV['APP_URL']}api/v2/users/#{user_id}/deactivate"
    puts deactivate_url
    if user_id.nil?
      nil
    else
      HTTP.headers(accept: "application/json", authorization: "Bearer #{@token}").put(deactivate_url)
    end
  end
end
