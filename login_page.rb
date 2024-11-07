class LoginPage

  def initialize(driver)
    @driver = driver
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
  end

  def open
    @driver.get "#{ENV['APP_URL']}"
    sleep 3
  end

  def email
    @wait.until { @driver.find_element(id: "email") }
    @driver.find_element(id: "email")
  end

  def password
    @wait.until { @driver.find_element(id: "password") }
    @driver.find_element(id: "password")
  end

  def login_button
    sleep(2)
    @wait.until { @driver.find_element(css: 'button[data-test-id="sign-in-btn"]') }
  end

  def fill_in_email
    email.send_keys(ENV['EMAIL'])
    sleep 2
  end

  def fill_in_password
    password.send_keys(ENV['PASSWORD'])
  end

  def press_login
    sleep(2)
    login_button.click
    sleep(2)
  end

  private attr_reader :driver
end
