class Login

  attr_accessor :driver

  def initialize
    @driver = Selenium::WebDriver.for :chrome
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
  end

  def open
    @driver.get "#{ENV['APP_URL']}"
    sleep 3
  end

  def fill_in_email
    @wait.until { @driver.find_element(id: "email") }
    username = @driver.find_element(id: "email")

    username.send_keys(ENV['EMAIL'])
    sleep 2
  end

  def fill_in_password
    @wait.until { @driver.find_element(id: "password") }
    password = @driver.find_element(id: "password")
    password.send_keys(ENV['PASSWORD'])
  end

  def press_login
    sleep(2)
    login_button = @wait.until { @driver.find_element(css: 'button[data-test-id="sign-in-btn"]') }
    @wait.until { login_button.displayed? && login_button.enabled? }
    sleep(2)
    login_button.click
    sleep(2)
  end

end
