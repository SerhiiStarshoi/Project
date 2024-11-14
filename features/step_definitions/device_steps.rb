When(/^I create device:$/) do |table|
  data = table.symbolic_hashes.first

  @generated_imei = rand(123456789123).to_s

  create_params = {
    portal_id: data[:portal],
    imei: @generated_imei,
    lm_origin_location: { id: nil },
    device_type_id: data[:type]
  }

  @device = @device_manager.create(create_params)
  puts "Created device:#{@device.inspect}"
end

Then(/^I check device details:$/) do |table|
  table.hashes.first.each do |key, value|
    aggregate_failures do
      case key
      when "imei"
        expect(@device.imei.encode("UTF-8")).to eq(@generated_imei)
      when "origin"
        expect(@device.origin_location["id"].to_s).to eq(value)
      when "model"
        expect(@device.device_model). to eq(value)
      when "device_status"
        expect(@device.device_status).to eq(value)
      else
        raise "Unexpected key: #{key}"
      end
    end
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
  puts "Updated device:#{@device.inspect}"
end

Then(/^I deactivate device:$/) do |table|
   @device_manager.deactivate(@device)
end

Then(/^I check device is deactivated:$/) do |table|
  data = table.symbolic_hashes.first
  searched_device = @device_manager.search(@device.imei)
  expect(searched_device).not_to be_nil, "Can't find device"
  expect(searched_device.activated.to_s).to eq(data[:activated].to_s)
end
