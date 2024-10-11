When(/^I create device:$/) do |table|
  data = table.symbolic_hashes.first
  create_params = {
    portal_id: data[:portal],
    imei: rand(123456789123).to_s,
    lm_origin_location: { id: nil },
    device_type_id: data[:type]
  }

  @created_device = @device_manager.create(create_params)
end

Then(/^I check device details:$/) do |table|
  data = table.symbolic_hashes.first

  case
  when @created_device
    expect(@created_device.device_model).to eq(data[:model])
    expect(@created_device.activated).to be(true)

  when @updated_device
    aggregate_failures do
      expect(@updated_device.imei).to eq(rand(123456789123).to_s)
      expect(@updated_device.origin_location).to eq(data[:origin])
    end
  end
end

Then(/^I update device:$/) do |table|
  data = table.symbolic_hashes.first
  update_params = {
    portal_id: 16288,
    imei: rand(123456789123).to_s,
    lm_origin_location: { id: data[:origin] },
    device_type_id: 14592
  }

  @updated_device = @device_manager.update(@created_device, update_params)
end

Then(/^I deactivate device:$/) do |table|
   @device_manager.deactivate(@created_device)
end

Then(/^I check device is deactivated:$/) do |table|
  data = table.symbolic_hashes.first
  expect(@device_manager.search(@created_device.imei).to_s).to eq(data[:activated].to_s)
end
