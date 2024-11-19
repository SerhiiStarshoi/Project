Before("@admin_auth") do
  admin = { "email" => ENV["ADMIN_EMAIL"], "password" => ENV["PASSWORD"] }
  authorization = API::Authorization.new
  token = authorization.receive_token(admin)
  @device_manager = API::Devices::DeviceManager.new(token)
end

Before("@broker_auth") do
  broker = { "email" => ENV["BROKER_EMAIL"], "password" => ENV["PASSWORD"] }
  authorization = API::Authorization.new
  token = authorization.receive_token(broker)
  @location_manager = API::Locations::LocationManager.new(token)
  @user_manager = API::UserManager.new(token)
end

 Before do
   @driver = Selenium::WebDriver.for :chrome
   @wait = Selenium::WebDriver::Wait.new(timeout: 3)
 end

After do
  if @searched_user
    user_id = @user_manager.search_user_api(@searched_user.email).id
    @user_manager.deactivate_user_api(user_id)
  end
end
