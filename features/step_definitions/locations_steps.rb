Given(/^I authorize as Broker user$/) do
  authorization = Authorization.new
  @location_manager = Locations::LocationManager.new(authorization.receive_token)
end

When(/^I create location:$/) do |table|
  data = table.symbolic_hashes.first
  create_params = {
    portal_id: data[:portal],
    title: SecureRandom.alphanumeric(11),
    custom_title: data[:custom_title],
    type: data[:type],
    latitude: data[:latitude],
    longitude: data[:longitude]
  }

  @location = @location_manager.create(create_params)
end

Then(/^I check location details:$/) do |table|
  data = table.symbolic_hashes.first
  expect(@location.address).to eq(data[:address])
end

When(/^I update location coordinates:$/) do |table|
  data = table.symbolic_hashes.first
  update_params = {
    portal_id: data[:portal],
    title: SecureRandom.alphanumeric(11),
    custom_title: data[:custom_title],
    id: @location.id,
    type: data[:type],
    latitude: data[:latitude],
    longitude: data[:longitude]
  }
  @updated_location = @location_manager.update(update_params, @location)
end

Then(/^I check location is updated:$/) do |table|
  data = table.symbolic_hashes.first
  aggregate_failures do
    expect(@updated_location.custom_title).to eq(data[:custom_title])
    expect(@updated_location.latitude.to_s).to eq(data[:latitude])
    expect(@updated_location.longitude.to_s).to eq(data[:longitude])
  end
end

When(/^I deactivate location$/) do |table|
  @location_manager.delete(@location)
end

Then(/^I check location is deactivated:$/) do |table|
  location_state = table.symbolic_hashes.first[:activated]
  expect(@location_manager.get_location(@location).activated.to_s).to eq(location_state)
end
