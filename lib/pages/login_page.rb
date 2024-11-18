require_relative "page"
class LoginPage < Page

  def fill_in_email
    email.send_keys(ENV['EMAIL'])
    sleep 2
  end

  def fill_in_password
    password.send_keys(ENV['PASSWORD'])
  end

  def click(button_name)
    sleep 3
    button(button_name).click
    sleep 2
  end

  private

  attr_reader :driver

  def button(button_name)
    @wait.until { @driver.find_element(xpath: "//*[text()='#{button_name}']") }
  end

  def email
    @wait.until { @driver.find_element(id: "email") }
  end

  def password
    @wait.until { @driver.find_element(id: "password") }
  end

  def login_button
    sleep(2)
    @wait.until { @driver.find_element(css: 'button[data-test-id="sign-in-btn"]') }
  end
end
