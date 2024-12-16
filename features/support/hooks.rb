Before("@asset") do
  @asset_number = SecureRandom.alphanumeric(8)
end

Before("@create_users") do
  @user_email = SecureRandom.alphanumeric(8).downcase + "@gmail.com"
  puts "User will be created with such email: #{@user_email}"
end

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
  @asset_manager = API::Assets::AssetManager.new(token)
end

After("@asset") do
  if !@asset_number.nil?
    @asset_manager.deactivate(@asset.id)
  end
end
