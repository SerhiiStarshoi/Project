@login @broker_auth
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
    And I click "Sign in" button at "Login" page
    Then I check Command Center page is opened

  @create_watch_officer
  Scenario: Add new Watch Officer user
    Given I login as Broker user
    When I open My Team page
    And I click "Add user" button at "My Team" page
    And I fill in data:
      | First Name | Last Name | Email                | Role          |
      | Serhii     | Starshoi  | 4322143@gmail.com | Watch Officer |
    And I click "Save" button at "My Team" page
    And I search for user
    | Email |
    | 4322143@gmail.com |
    #Then I check there is only one user in the list
    And I check user is created:
      | First Name | Last Name | Email                | Role          |
      | Serhii     | Starshoi  | 4322143@gmail.com | Watch Officer |

  @deactivate_watch_officer
  Scenario: Deactivate created Watch Officer user
    Given I login as Broker user
    When I open My Team page
    And I click "Add user" button at "My Team" page
    And I fill in data:
      | First Name | Last Name | Email                     | Role          |
      | Serhii     | Starshoi  | 4322143@gmail.com | Watch Officer |
    And I click "Save" button at "My Team" page
    And I search for user
    |  Email  |
    | 4322143@gmail.com |
    And I deactivate user
    And I check user is deactivated

  #1. user_manager -> user folder X
  #2. def search_ui(email) елементи мають бути в окремих методах + переглянути решту
  #3. Зробити юайний клас UserListItem який відображатиме один рядок в таблиці результатів пошуку юзерів і використатти як інстанс в методі def search_ui(email)
  #4. Then I check there is only one user in the list використовуючи UserListItem
  #5. UserManager < Manager X
  #6. def watch_officer_option(driver) замість драйваер має передаватись тайтл
  #7. @driver driver? X