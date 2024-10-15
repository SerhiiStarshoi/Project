When(/^I open url$/) do
  @ui_test = Uitest.new
  @driver.get "#{ENV['APP_URL']}"
  @driver.current_url
end

Then(/^I check url link:$/) do |table|
  data = table.symbolic_hashes.first
  sleep(2)
  @ui_test.url_link = @driver.current_url
  expect(@ui_test.url_link).to eq(data[:url])
end

When(/^I enter user email$/) do
  username = @wait.until { @driver.find_element(id: "email") }
  username.send_keys(ENV['EMAIL'])
end

And(/^I enter user password$/) do
  password = @wait.until { @driver.find_element(id: "password") }
  password.send_keys(ENV['PASSWORD'])
end

When(/^I press login button$/) do
  login_button = @wait.until { @driver.find_element(css: '[data-test-id="sign-in-btn"]')  }
  login_button.click
end
