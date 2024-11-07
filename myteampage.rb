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

    return nil if search_array.empty?

    puts "User created: #{search_array}"
    User.new(search_array.first)

  end

  def user_call_search(email)
    broker = {
      "email" => ENV["EMAIL"],
      "password" => ENV["PASSWORD"]
    }

    token =  Authorization.new.receive_token(broker)
    puts "token: #{token.inspect}"

    search_url = "#{ENV['APP_URL']}api/v2/user_brokers?&query=#{email}"

    puts search_url
    HTTP.headers(accept: "application/json", authorization: "Bearer #{token}").get(search_url)
  end

  def deactivate_user_ui(email)
    @driver.navigate.to "#{ENV['APP_URL']}app/profile/team/brokers?query=#{email}"
    sleep(2)
    deactivate_user_button = @wait.until { @driver.find_element(css: 'button[data-test-id="deactivate-broker-user-btn"]') }
    @wait.until { deactivate_user_button.displayed? && deactivate_user_button.enabled? }
    sleep(2)
    deactivate_user_button.click
    sleep(2)

    deactivate_user_button_confirm= @wait.until { @driver.find_element(css: 'button[data-test-id="modal_success_button"]')  }
    @wait.until { deactivate_user_button_confirm.displayed? && deactivate_user_button_confirm.enabled? }
    deactivate_user_button_confirm.click

    sleep 2
  end

  def deactivate_user_api(user_id)
    broker = {
      "email" => ENV["EMAIL"],
      "password" => ENV["PASSWORD"]
    }
    puts "here"

    token =  Authorization.new.receive_token(broker)
    deactivate_url = "#{ENV['APP_URL']}api/v2/users/#{user_id}/deactivate"
    HTTP.headers(accept: "application/json", authorization: "Bearer #{token}").put(deactivate_url)
  end
end

