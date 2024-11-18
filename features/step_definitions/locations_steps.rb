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
  table.hashes.each do |row|
    data = table.symbolic_hashes.first
    location_state = table.symbolic_hashes.first[:activated]

    case
    when @updated_location
      expect(@updated_location.custom_title).to eq(data[:custom_title])
      expect(@updated_location.latitude.to_s).to eq(data[:latitude].to_s)
      expect(@updated_location.longitude.to_s).to eq(data[:longitude].to_s)
      expect(@updated_location.address).to eq(data[:address])
      expect(@location_manager.get_location(@location).activated.to_s).to eq(location_state)
    when @location
      expect(@location.custom_title).to eq(data[:custom_title])
      expect(@location.latitude.to_s).to eq(data[:latitude].to_s)
      expect(@location.longitude.to_s).to eq(data[:longitude].to_s)
      expect(@location.address).to eq(data[:address])
      expect(@location_manager.get_location(@location).activated.to_s).to eq(location_state)
    end
  end
end

When(/^I update location:$/) do |table|
  data = table.symbolic_hashes.first
  update_params = {
    portal_id: @location.portal_id,
    title: SecureRandom.alphanumeric(11), # not working without
    custom_title: data[:custom_title],
    id: @location.id,
    type: @location.type,
    latitude: data[:latitude],
    longitude: data[:longitude]
  }
  @updated_location = @location_manager.update(update_params, @location) #updated_location = location
  #remove fetch and add it to check location step
end

When(/^I deactivate location:$/) do |table|
  @location_manager.deactivate(@location)
end

Then(/^I check location is deactivated:$/) do |table|
  data = table.symbolic_hashes.first
  #search by location title or smth else, activated?
  activated = @location_manager.search_if_activated(@location.title)
  expect(activated.to_s).to eq(data[:activated].to_s)
end
