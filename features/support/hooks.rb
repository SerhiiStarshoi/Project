Before("@admin_auth") do
  admin = { "email" => ENV["ADMIN_EMAIL"], "password" => ENV["PASSWORD"] }
  authorization = Authorization.new
  @device_manager = Devices::Manager.new(authorization.receive_token(admin))
end

Before("@broker_auth") do
  broker = { "email" => ENV["BROKER_EMAIL"], "password" => ENV["PASSWORD"] }
  authorization = Authorization.new
  token = authorization.receive_token(broker)
  @location_manager = Locations::LocationManager.new(token)
end

 Before do
   @driver = Selenium::WebDriver.for :chrome
   @wait = Selenium::WebDriver::Wait.new(timeout: 3)
   broker = { "email" => ENV["BROKER_EMAIL"], "password" => ENV["PASSWORD"] }
   authorization = Authorization.new
   token = authorization.receive_token(broker)
   @user_manager = UserManager.new(token)
 end

After do |scenario|
  if scenario.failed?
    puts "Scenario failed: #{scenario.name}"
  else
    puts "Scenario passed: #{scenario.name}"

    puts "SEARCHED_USER #{@searched_user.inspect}"

    if @searched_user
      @user_manager.deactivate_user_api(@searched_user.id)
    else
      puts "No searched user found, skipping deactivation."
    end
  end
end
