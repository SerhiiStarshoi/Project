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
      | First Name | Last Name | Email              | Role          |
      | Serhii     | Starshoi  | 1312fvev@gmail.com | Watch Officer |
    And I click "Save" button
    And I search for user
      | Email              |
      | 1312fvev@gmail.com |
    Then I check user is created:
      | First Name | Last Name | Email              | Role       |
      | Serhii     | Starshoi  | 1312fvev@gmail.com | br_watcher |

  @deactivate_watch_officer
  Scenario: Deactivate created Watch Officer user
    Given I login as Broker user
    When I open My Team page
    And I click "Add user" button
    And I fill in data:
      | First Name | Last Name | Email              | Role          |
      | Serhii     | Starshoi  | 1312fvev@gmail.com | Watch Officer |
    And I click "Save" button
    And I search for user
      | Email              |
      | 1312fvev@gmail.com |
    And I deactivate user
    And I check user is deactivated



#  1. розібратись чому два браузера X
#  2. переробити степ перевірки юзера, щоб не використовувати масив tested_key X
#  3. не зберігати MyTeamPage в змінну ?
#  4. зробити users manager X
#  5. додати апішний метод для деактивації і деактивовувати юзер в хуках X
#  6. окремий тест для деактивації юзера через UI X

#  8. виділити клас LoginPage
#  9. додати метод #open for MyTeamPage, LoginPage
#  10. вся UI логіка має бути в пейджах
#  11. Command Center page with method #opened? (edited) X

  #  7. pageobject pattern - почитати


