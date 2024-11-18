require_relative "page"

class MyTeamPage < Page
  PATH = "app/profile/team"
  def initialize(driver)
    @driver = driver
    @wait = Selenium::WebDriver::Wait.new(timeout: 5)
  end

  def click(button_name)
    sleep 3
    button(button_name).click
  end

  def fill_in(data, driver)
    first_name_input.send_keys(data[:first_name])
    sleep(1)
    last_name_input.send_keys(data[:last_name])
    sleep(1)
    email_input.send_keys(data[:email])
    sleep(1)

    role_input.click
    sleep(1)
    watch_officer_option(driver).click
  end

  def save_user
    sleep 3
    save_user_button.click
  end

  def search_ui
    first_row = @wait.until { @driver.find_element(:xpath, "(//div[@role='row'])[1]") }

    name_parts = first_row.text.split(' ')
    first_name = name_parts[0]
    last_name = name_parts[1]
    email = name_parts[2]
    role = name_parts[3..-1].join(' ').strip.chomp(' -')

    data = {
      "id" => nil,
      "first_name" => first_name,
      "last_name" => last_name,
      "email" => email,
      "role" => role
    }

    User.new(data)
  end

  def deactivate_user_ui
    @wait.until { deactivate_user_button.displayed? && deactivate_user_button.enabled? }
    sleep(1)

    deactivate_user_button.click
    sleep(1)

    @wait.until { deactivate_user_button_confirm.displayed? && deactivate_user_button_confirm.enabled? }
    deactivate_user_button_confirm.click
    sleep(1)
  end

  private

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
    # role_options = @wait.until { driver.find_elements(css: "[role='option']") }
    # role_options.find { |option| option.text == "Watch Officer" }

    title = "Watch Officer"
    @wait.until { driver.find_element(xpath: "//*[@data-test-id='option-item-label' and text()='#{title}']") }
  end

  def deactivate_user_button
    @wait.until { @driver.find_element(css: 'button[data-test-id="deactivate-broker-user-btn"]') }
  end

  def deactivate_user_button_confirm
    @wait.until { @driver.find_element(css: 'button[data-test-id="modal_success_button"]')  }
  end

  def button(button_name)
    #@wait.until { @driver.find_element(css: 'button[data-test-id="add-broker-user-btn"]') }
    @wait.until { @driver.find_element(xpath: "//button[text()='#{button_name}']") }
  end

  def save_user_button
    @wait.until { @driver.find_element(css: 'button[data-test-id="modal_success_button"]') }
  end

  def user_email
    @wait.until { @driver.find_element(css: 'button[data-test-id="deactivate-broker-user-btn"]') }
  end

  attr_reader :driver
end
