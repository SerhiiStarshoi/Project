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


Then(/^I check user is created:$/) do |table|
  table.symbolic_hashes.each do |data|
    aggregate_failures do
      user_attrs =  @searched_user.attrs.slice(*data.keys)
      expect(user_attrs.values.any?(&:nil?)).to be false
      expect(user_attrs).to eq(data)
    end #case when
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
  sleep 2
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
