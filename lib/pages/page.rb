class Page

  def initialize(driver)
    @driver = driver
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
  end
  def open
    @driver.get "#{ENV['APP_URL']}"
    sleep 3
  end

end
