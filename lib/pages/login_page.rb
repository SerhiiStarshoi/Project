require_relative "page"
class LoginPage < Page
  PATH = "app/sign-in"

  def fill_in_email
    email.send_keys(ENV['EMAIL'])
    sleep 2
  end

  def fill_in_password
    password.send_keys(ENV['PASSWORD'])
  end

  private

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
