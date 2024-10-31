class  CommandCenter

  def initialize(driver)
    @driver = driver
  end
  def check_if_opened?
    @driver.current_url
  end
end
