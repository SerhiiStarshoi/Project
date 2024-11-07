@login
Feature: UI Test

  @unauthorized_user
  Scenario: Check that unauthorized user is redirected to login url
    Given I open url
    Then I check url link:
      | url                                      |
      | https://qa-app.over-haul.com/app/sign-in |

  @user_can_login
  Scenario: Check user is able to login
    Given I open Login page
    When I enter user email
    And I enter user password
    And I press login button
    Then I check Command Center page is opened:
      | url                                                   |
      | https://qa-app.over-haul.com/dashboard/command-center |


  @create_watch_officer
  Scenario: Add new Watch Officer user
    Given I login as Broker user
    When I open My Team page
    And I click "Add user" button
    And I fill in data:
      | First Name | Last Name | Email                | Role          |
      | Serhii     | Starshoi  | 2213313223@gmail.com | Watch Officer |
    And I click "Save" button
    And I search for user
      | Email              |
      | 13313223@gmail.com |
    Then I check user is created:
      | First Name | Last Name | Email                | Role       |
      | Serhii     | Starshoi  | 2213313223@gmail.com | br_watcher |

  @deactivate_watch_officer
  Scenario: Deactivate created Watch Officer user
    Given I login as Broker user
    When I open My Team page
    And I click "Add user" button on "My Team" page
    And I fill in data:
      | First Name | Last Name | Email                     | Role          |
      | Serhii     | Starshoi  | 2tf2g12312fvev2@gmail.com | Watch Officer |
    And I click "Save" button on "Add New User" pop up
    And I search for user
      | Email                     |
      | 2tf2g12312fvev2@gmail.com |
    And I deactivate user
    And I check user is deactivated


  #1. deactivate user api -> user manager і search теж, переглянути решту чи щось ще треба перенести X
  #2. @driver.navigate.to "#{ENV['APP_URL']}app/profile/team/brokers?query=#{email}" має бути не там а в серчі X
  #3. Before("@broker_auth") do додати UserManager.new(token) X
  #4. #@searched_user check if not null, if not than deactivate_api in hook X
  #5. classes all in lib/pages (ui)  + in lib/api (api) X
  #6. remove instance_variable_get(:@driver)).check_if_opened?).to eq(data[:url]) (command_center) X
  #7. переобити степи під клік на ріних пейджах (а не один універсальний)
  #When(/^I click "([^"]*)" button$/) do |title| зробити щоб метод клік був один на всіх пейджах,
  # приймав тайтл і міг клікнути але перед тим перевіряти яка пейджа. Перейменувати на сценарії on Location page (for example)
  #8. переробити все під pageobject pattern in myteampage X
  #9. expect(@searched_user.first_name). to eq(value) дописати решту X
