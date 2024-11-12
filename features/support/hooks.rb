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
  @user_manager = UserManager.new(token)
end

 Before do
   @driver = Selenium::WebDriver.for :chrome
   @wait = Selenium::WebDriver::Wait.new(timeout: 3)
 end

After do
  if @searched_user
    user_id = @user_manager.get_user_id(@searched_user.email)
    @user_manager.deactivate_user_api(user_id)
  end
end
