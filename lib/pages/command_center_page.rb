require_relative "page"

class CommandCenterPage < Page
  def initialize(driver)
    @driver = driver
  end

  def opened?
    page_url = "#{ENV['APP_URL']}dashboard/command-center"
    if page_url == @driver.current_url
      true
    end
  end
end
