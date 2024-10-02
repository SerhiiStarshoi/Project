Given(/^I authorize as Broker user$/) do
  authorization = Authorization.new
  @location_manager = Locations::LocationManager.new(authorization.receive_token)
end

When(/^I create location:$/) do |table|
  create_params = {
    portal_id: 16288,
    title: SecureRandom.alphanumeric(11),
    custom_title: "some title",
    type: "Standard",
    latitude: "47.444956",
    longitude: "18.960501"
  }
  @location = @location_manager.create(create_params)
end

Then(/^I check location details:$/) do |table|
  expect(@location.address).to eq("Budaörs, Akron Utca 2, 2040, Pest, Hungary")
end

When(/^I update location coordinates:$/) do |table|
  update_params = {
    portal_id: 16288,
    title: SecureRandom.alphanumeric(11),
    custom_title: "UPDATED",
    id: @location.id,
    type: "Standard",
    latitude: "47.144312",
    longitude: "21.64162"
  }
  @updated_location = @location_manager.update(update_params, @location)
end

Then(/^I check location is updated:$/) do |table|
  aggregate_failures do
    expect(@updated_location.custom_title).to eq("UPDATED")
    expect(@updated_location.latitude).to eq(47.14431)
    expect(@updated_location.longitude).to eq(21.64162)
    expect(@updated_location.type).to eq("Standard")
  end
end

When(/^I deactivate location$/) do |table|
  @location_manager.delete(@location)
end

Then(/^I check location is deactivated:$/) do |table|
  expect(@location_manager.get_location(@location).activated).to eq(false)
end
