When(/^I open url$/) do
  visit("/")
end

Then(/^I check url link:$/) do |table|
  data = table.symbolic_hashes.first
  expect(page.current_url).to eq(data[:url])
end

And(/^I deactivate user$/) do
  MyTeamPage.given.deactivate_user_ui
end

Given(/^I login as Broker user$/) do
  LoginPage.open
  LoginPage.given.login(user: "watchofficerssportal@gmail.com", pass: "somepass")
  wait_for_ajax
end

When(/^I open My Team page$/) do
  MyTeamPage.open
end

And(/^I click "([^"]*)" button at "([^"]*)" page$/) do |button_name, page_name|
  case page_name
  when "My Team"
    puts "button_name = #{button_name}"
    MyTeamPage.given.click(button_name)
  when "Login"
    #@login_page.click(button_name)
    LoginPage.given.click(button_name)
  when "My Network"
    MyNetworkPage.given.click(button_name)
  when "Assets"
    MyNetworkPage.given.click(button_name)
  else
    raise "Unknown page: #{page_name}"
  end
end

When(/^I search for user$/) do
  MyTeamPage.open(query_params: { query: @user_email })
end

Then(/^I check there is only one user in the list$/) do

end

  Then(/^I check user is created:$/) do |table|
    actual_user_data = table.hashes.first

    user = MyTeamPage.given.user_by_name(actual_user_data["Name"])

    aggregate_failures do
      actual_user_data.each do |key, value|
        case key
        when "Name"
          expect(user.name).to eq(value)
        when "Email"
          expect(user.email).to eq(@user_email)
        when "Role"
          expect(user.role).to eq(value)
        else
          raise "Unexpected key: '#{key}' with value '#{value}'"
        end
      end
    end
  end

Then(/^I check Command Center page is opened$/) do
  expect(CommandCenterPage.given.opened?).to be true
end

And(/^I check user is deactivated$/) do
  expect(@user_manager.search_user_api(@user_email)).to be nil
end
