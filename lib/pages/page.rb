class Page
  def initialize(driver)
    @driver = driver
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
  end

  def open
    @driver.get "#{ENV['APP_URL']}#{self.class::PATH}"
    sleep 3
  end

  def click(button_name)
    sleep 3
    button(button_name).click
    sleep 2
  end
end
