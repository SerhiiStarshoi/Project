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
  table.hashes.first.each do |key, value|
    aggregate_failures do
      case key
      when "First Name"
        expect(@searched_user.first_name). to eq(value)
      when "Last Name"
        expect(@searched_user.last_name). to eq(value)
      when "Email"
        expect(@searched_user.email). to eq(value)
      when "Role"
        expect(@searched_user.role). to eq(value)
      end
    end
  end
end

Given(/^I open Login page$/) do
  @login_page = LoginPage.new(@driver) #rename login_page i new(driver)
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
  expect(CommandCenter.new(@driver).check_if_opened?).to eq(data[:url])
end

When(/^I open My Team page$/) do
  @my_team_page = MyTeamPage.new(@driver)
  @my_team_page.open
end

When(/^I fill in data:$/) do |table|
  @my_team_page.fill_in(table.symbolic_hashes.first, @driver)
end


When(/^I search for user$/) do |table|
  data = table.symbolic_hashes.first
  sleep(2)
  @searched_user = @user_manager.search_user(data[:email])
end

And(/^I deactivate user$/) do
  @driver.navigate.to "#{ENV['APP_URL']}app/profile/team/brokers?query=#{@searched_user.email}"
  sleep(2)
  @my_team_page.deactivate_user_ui
end

And(/^I check user is deactivated$/) do
  expect(@user_manager.search_user(@searched_user.email)).to be nil
end

