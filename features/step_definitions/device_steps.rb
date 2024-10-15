When(/^I create device:$/) do |table|
  data = table.symbolic_hashes.first
  create_params = {
    portal_id: data[:portal],
    imei: rand(123456789123).to_s,
    lm_origin_location: { id: nil },
    device_type_id: data[:type]
  }

  @device = @device_manager.create(create_params)
  puts @device.inspect
end

Then(/^I check device details:$/) do |table|
  data = table.symbolic_hashes.first

  aggregate_failures do
    expect(@device.imei.encode("UTF-8")).to eq(@generated_imei) #fixed
    expect(@device.origin_location["id"].to_s).to eq(data[:origin])
    expect(@device.device_status).to eq(data[:device_status])
  end
end

Then(/^I update device:$/) do |table|
  data = table.symbolic_hashes.first

  @generated_imei = rand(123456789123).to_s

  update_params = {
    portal_id: 16288,
    imei: @generated_imei,
    lm_origin_location: { id: data[:origin] },
    device_type_id: 14592
  }

  @device = @device_manager.update(@device, update_params)
  puts @device.inspect
end

Then(/^I deactivate device:$/) do |table|
   @device_manager.deactivate(@device)
end

Then(/^I check device is deactivated:$/) do |table|
  data = table.symbolic_hashes.first
  searched_device = @device_manager.search(@device.imei)
  expect(searched_device.activated.to_s).to eq(data[:activated].to_s)
end
