Before("@admin_auth") do
  admin = { "email" => ENV["ADMIN_EMAIL"], "password" => ENV["PASSWORD"] }
  authorization = Authorization.new
  @device_manager = Devices::Manager.new(authorization.receive_token(admin))
end

Before("@broker_auth") do
  broker = { "email" => ENV["BROKER_EMAIL"], "password" => ENV["PASSWORD"] }
  authorization = Authorization.new
  @location_manager = Locations::LocationManager.new(authorization.receive_token(broker))
end

 Before do
   @driver = Selenium::WebDriver.for :chrome
   @wait = Selenium::WebDriver::Wait.new(timeout: 3)
 end

After("@create_watch_officer") do |scenario|
  if scenario.failed?
    puts "Scenario failed: #{scenario.name}"
  else
    puts "Scenario passed: #{scenario.name}"
    user_manager = UserManager.new(@login_page.instance_variable_get(:@driver))
    user_manager.deactivate_user(@searched_user.email)
  end
end
