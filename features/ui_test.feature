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
      Given I open url
      When I enter user email
      And I enter user password
      When I press login button
      Then I check url link:
      | url                                                   |
      | https://qa-app.over-haul.com/dashboard/command-center |
