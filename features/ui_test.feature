@login @broker_auth @create_users
Feature: UI Test

  @unauthorized_user
  Scenario: Check that unauthorized user is redirected to login url
    Given I open url
    Then I check url link:
      | url                           |
      | https://qa-app.over-haul.com/ |

  @user_can_login
  Scenario: Check user is able to login
    Given I login as Broker user
    Then I check Command Center page is opened

  @create_watch_officer
  Scenario: Add new Watch Officer user
    Given I login as Broker user
    When I open My Team page
    And I click "Add user" button at "My Team" page
    And I fill in data:
      | First Name | Last Name | Role          |
      | Serhii     | Starshoi  | Watch Officer |
    And I search for user
    And I check user is created:
      | Name            | Role          |
      | Serhii Starshoi | Watch Officer |

  @deactivate_watch_officer
  Scenario: Deactivate created Watch Officer user
    Given I login as Broker user
    When I open My Team page
    And I click "Add user" button at "My Team" page
    And I fill in data:
      | First Name | Last Name  | Role          |
      | Serhii     | Starshoi   | Watch Officer |
    And I click "Save" button at "My Team" page
    And I search for user
    And I deactivate user
    And I check user is deactivated

  #. класи + наслідування в рубі книжка прочитати
