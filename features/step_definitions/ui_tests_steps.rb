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
  sleep 3
  add_user_button = @wait.until { @login_page.instance_variable_get(:@driver).find_element(xpath: "//button[text()='#{title}']")  }
  add_user_button.click

  pop_up = @wait.until { @login_page.instance_variable_get(:@driver).find_element(css: '[data-test-id="add-broker-user-modal"]')  }
  expect(pop_up.displayed?).to be true
end

When(/^I fill in data:$/) do |table|
  @new_user.fill_in(table.symbolic_hashes.first, @login_page.instance_variable_get(:@driver))
end

Then(/^I check user is created:$/) do |table|
  # data = table.symbolic_hashes.first
  # aggregate_failures do
  #   expect(@searched_user.first_name).to eq(data[:first_name])
  #   expect(@searched_user.last_name).to eq(data[:last_name])
  #   expect(@searched_user.email).to eq(data[:email])
  #   expect(@searched_user.role).to eq(data[:role])

  table.symbolic_hashes.each do |data|
    aggregate_failures do
      user_attrs =  @searched_user.attrs.slice(*data.keys)
      expect(user_attrs.values.any?(&:nil?)).to be false
      expect(user_attrs).to eq(data)
    end
  end
  # end
end

Given(/^I open Login page$/) do
  @login_page = Login.new
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
  sleep 2
end

Then(/^I check Command Center page is opened:$/) do |table|
  @command_center = CommandCenter.new(@login_page.instance_variable_get(:@driver))
  data = table.symbolic_hashes.first
  expect( @command_center.check_if_opened?).to eq(data[:url])
end

When(/^I open My Team page$/) do
  @new_user = MyTeamPage.new(@login_page.instance_variable_get(:@driver))
  @new_user.open
end

When(/^I search for user$/) do |table|
  data = table.symbolic_hashes.first
  puts data[:email]
  @searched_user = @new_user.search(data[:email]) #user_manager class (module)
end

And(/^I deactivate user$/) do
  user_manager = UserManager.new(@login_page.instance_variable_get(:@driver))
  puts @searched_user.email
  user_manager.deactivate_user(@searched_user.email)
end

And(/^I check user is deactivated$/) do
  my_team_page = MyTeamPage.new(@login_page.instance_variable_get(:@driver))
  expect(my_team_page.search(@searched_user.email)).to be false
end
