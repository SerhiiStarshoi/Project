require_relative "../../lib/api/user"
require_relative "../../lib/authorization"
class MyTeamPage

  def initialize(driver)
    @driver = driver
    @wait = Selenium::WebDriver::Wait.new(timeout: 5)
  end

  def open
    @driver.navigate.to "#{ENV['APP_URL']}app/profile/team"
  end

  def first_name_input
    @wait.until { driver.find_element(xpath: '//*[@data-test-id="first_name-input"]') }
  end

  def last_name_input
    @wait.until { driver.find_element(css: '[data-test-id="last_name-input"]') }
  end

  def email_input
    @wait.until { driver.find_element(css: '[data-test-id="email-input"]') }
  end

  def role_input
    @wait.until { driver.find_element(css: 'input[role="combobox"][name="role"]') }
  end

  def watch_officer_option(driver)
    role_options = @wait.until { driver.find_elements(css: "[role='option']") }
    role_options.find { |option| option.text == "Watch Officer" }
  end

  def fill_in(data, driver)
    first_name_input.send_keys(data[:first_name])
    last_name_input.send_keys(data[:last_name])
    email_input.send_keys(data[:email])
    sleep(2)

    role_input.click
    sleep(2)
    watch_officer_option(driver).click
  end

  def deactivate_user_button
    sleep(2)
    @wait.until { @driver.find_element(css: 'button[data-test-id="deactivate-broker-user-btn"]') }
  end

  def deactivate_user_button_confirm
    @wait.until { @driver.find_element(css: 'button[data-test-id="modal_success_button"]')  }
  end

  def deactivate_user_ui
    @wait.until { deactivate_user_button.displayed? && deactivate_user_button.enabled? }
    sleep(2)

    deactivate_user_button.click
    sleep(2)

    @wait.until { deactivate_user_button_confirm.displayed? && deactivate_user_button_confirm.enabled? }
    deactivate_user_button_confirm.click
    sleep 3
  end

  def add_user
    sleep 3
    add_user_button.click
  end

  def add_user_button
    @wait.until { @driver.find_element(css: 'button[data-test-id="add-broker-user-btn"]') }
  end

  def save_user_button
    @wait.until { @driver.find_element(css: 'button[data-test-id="modal_success_button"]') }
  end

  def save_user
    sleep 3
    save_user_button.click
  end

  private attr_reader :driver
end
