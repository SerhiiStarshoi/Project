
class UserManager

  def initialize(driver)
    @driver = driver
    @wait = Selenium::WebDriver::Wait.new(timeout: 5)
  end
  def deactivate_user(email)
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

end
