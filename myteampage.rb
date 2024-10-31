require_relative "user"
require_relative "lib/authorization"
class MyTeamPage

  def initialize(driver)
    @driver = driver
    @wait = Selenium::WebDriver::Wait.new(timeout: 5)
  end


  def open
    @driver.navigate.to "#{ENV['APP_URL']}app/profile/team"
  end

  def fill_in(data, driver)
    first_name_input = @wait.until { driver.find_element(xpath: '//*[@data-test-id="first_name-input"]') }
    last_name_input = @wait.until { driver.find_element(css: '[data-test-id="last_name-input"]') }
    email_input = @wait.until { driver.find_element(css: '[data-test-id="email-input"]') }

    first_name_input.send_keys(data[:first_name])
    last_name_input.send_keys(data[:last_name])
    email_input.send_keys(data[:email])

    sleep(2)

    input_field = @wait.until { driver.find_element(css: 'input[role="combobox"][name="role"]') }
    input_field.click

    sleep(2)

    options = @wait.until { driver.find_elements(css: "[role='option']") }

    watch_officer_option = options.find { |option| option.text == "Watch Officer" }
    watch_officer_option.click
  end

  def search(email)
    response = user_call_search(email)
    search_array = JSON.parse(response.body)
    if search_array.empty?
      false
    else
      puts search_array
      User.new(search_array.first)
    end
  end

  def user_call_search(email)
    broker = {
      "email" => ENV["EMAIL"],
      "password" => ENV["PASSWORD"]
    }
    puts broker

    token =  Authorization.new.receive_token(broker)
    puts "token: #{token.inspect}"

    search_url = "#{ENV['APP_URL']}api/v2/user_brokers?&query=#{email}"

    puts search_url
    HTTP.headers(accept: "application/json", authorization: "Bearer #{token}").get(search_url)
  end
end

