When(/^I open url$/) do
  @driver.get "#{ENV['APP_URL']}"
  @driver.current_url
end

Then(/^I check url link:$/) do |table|
  data = table.symbolic_hashes.first
  sleep(2)
  expect(@driver.current_url).to eq(data[:url])
end

Given(/^I login as Broker user$/) do
  step("I open Login page")
  step("I enter user email")
  step("I enter user password")
  step('I click "Sign in" button at "Login" page')
end

And(/^I click "([^"]*)" button at "([^"]*)" page$/) do |button_name, page_name|
  case page_name
  when "My Team"
    @my_team_page.click(button_name)
    sleep(3)
  when "Login"
    @login_page.click(button_name)
    sleep(3)
  else
    raise "Unknown page: #{page_name}"
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
      else
        raise "Unexpected key: #{key}"
      end
    end
  end
end

Given(/^I open Login page$/) do
  @login_page = LoginPage.new(@driver)
  @login_page.open
end

When(/^I enter user email$/) do
  @login_page.fill_in_email
end

When(/^I enter user password$/) do
  @login_page.fill_in_password
end

Then(/^I check Command Center page is opened$/) do
  expect(CommandCenterPage.new(@driver).opened?).to be true
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
  @searched_user = @my_team_page.search_ui(data[:email])
end

And(/^I deactivate user$/) do
  @driver.get "#{ENV['APP_URL']}app/profile/team/brokers?query=#{@searched_user.email}"

  sleep(2)
  @my_team_page.deactivate_user_ui
end

And(/^I check user is deactivated$/) do
  expect(@user_manager.search_user(@searched_user.email)).to be nil
end
