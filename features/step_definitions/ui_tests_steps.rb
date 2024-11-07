When(/^I open url$/) do
  @driver.get "#{ENV['APP_URL']}"
  @driver.current_url
end

Then(/^I check url link:$/) do |table|
  data = table.symbolic_hashes.first
  sleep(2)
  url_link = @driver.current_url
  expect(url_link).to eq(data[:url])
end

Given(/^I login as Broker user$/) do
  step("I open Login page")
  step("I enter user email")
  step("I enter user password")
  step("I press login button")
end

When(/^I click "([^"]*)" button$/) do |title|
  case title
  when "Add user"
    @my_team_page.add_user
  when "Save"
    @my_team_page.save_user
  else
    raise "Unknown button title: #{title}"
  end
end

Then(/^I check user is created:$/) do |table|
  table.symbolic_hashes.each do |data|
    aggregate_failures do
      user_attrs = @searched_user.attrs.slice(*data.keys)
      case
      when user_attrs.values.any?(&:nil?)
        expect(user_attrs.values.any?(&:nil?)).to be false
      when user_attrs != data
        expect(user_attrs).to eq(data)
      end
    end
  end
end

Given(/^I open Login page$/) do
  @login_page = Login.new #rename login_page i new(driver)
  @login_page.open
end

When(/^I enter user email$/) do
  @login_page.fill_in_email
end

When(/^I enter user password$/) do
  @login_page.fill_in_password
end

When(/^I press login button$/) do
  @login_page.press_login
end

Then(/^I check Command Center page is opened:$/) do |table|
  data = table.symbolic_hashes.first
  expect(CommandCenter.new(@login_page.instance_variable_get(:@driver)).check_if_opened?).to eq(data[:url])
end

When(/^I open My Team page$/) do
  @my_team_page = MyTeamPage.new(@login_page.instance_variable_get(:@driver))
  @my_team_page.open
end

When(/^I fill in data:$/) do |table|
  @my_team_page.fill_in(table.symbolic_hashes.first, @login_page.instance_variable_get(:@driver))
end


When(/^I search for user$/) do |table|
  data = table.symbolic_hashes.first
  @searched_user = @my_team_page.search(data[:email])
end

And(/^I deactivate user$/) do
  @my_team_page.deactivate_user_ui(@searched_user.email)
end

And(/^I check user is deactivated$/) do
  expect(@my_team_page.search(@searched_user.email)).to be nil
end
