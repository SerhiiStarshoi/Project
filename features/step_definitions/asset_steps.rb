And(/^I search for "([^"]*)" company$/) do |carrier_company|
  MyNetworkPage.open(query_params: { query: carrier_company })
end

And(/^I fill in data:$/) do | table|
  case current_url
  when /\/team\/brokers/
    MyTeamPage.given.user_add_section.fill_in_data(table.hashes.first, @user_email)
  when /\/assets\/create/
    MyNetworkPage.given.fill_in_data(table.hashes.first, @asset_number)
  end
end

And(/^I click Create button$/) do
  MyNetworkPage.given.create_asset
end

And(/^I open Asset Manager page$/) do
  AssetManagerPage.open
end

And(/^I search for tractor$/) do
  AssetManagerPage.open(query_params: { query: @asset_number })
end

And(/^I open Asset details$/) do
  AssetManagerPage.given.open_asset_details
end

And(/^I check asset status via UI:$/) do |table|
  data = table.symbolic_hashes.first
  expect(AssetManagerPage.given.asset_status).to eq(data[:status])
end

And(/^I check asset details via API:$/) do |table|
  data = table.symbolic_hashes.first
  @asset = @asset_manager.search(@asset_number)

  aggregate_failures do
    expect(@asset.status.capitalize).to eq(data[:status])
    expect(@asset.type.capitalize).to eq(data[:type])
  end
end

# AssetManagerPage Х
# Один степ має відкривати пейджу, переводити стрінг в назву класу, через регулярний вираз
# використати Howitzer::Web::Page.current_page.given і зробити так щоб ми не вказувалу сторінку при степі кліку на кнопку
# And(/^I fill in data at "([^"]*)" page:$/) do |page_name, table| тут теж X
# asset_create_element.click винести в окремий степ X
# серчати апішно і витягувати ід
