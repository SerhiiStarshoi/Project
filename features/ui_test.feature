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
      | First Name | Last Name | Email             | Role          |
      | Serhii     | Starshoi  | 3313223@gmail.com | Watch Officer |
    And I click "Save" button
    And I search for user
      | Email                  |
      | 3313223@gmail.com |
    Then I check user is created:
      | First Name | Last Name | Email                  | Role       |
      | Serhii     | Starshoi  | 3313223@gmail.com | br_watcher |

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


  #1. deactivate перенести в myteampage X
  #2. deactivate зробити апішну і кинути в хуки X
  #3. ініціалізувати драйвер в середині кожної пейджі private attr_reader
  #4. переобити степи під клік на ріних пейджах (а не один універсальний)
  #5. Add User має працюватиз myteampage а не логін, можна в степі зроьбити через іф-ку X
  #6. https://en.wikipedia.org/wiki/SOLID
  #7. User_Manager і пейджі не має бути новий а переюзатись існуючий X
  #8. pageobject pattern - почитати
  #9 guard_clause
  #10 user_attrs =  @searched_user.attrs.slice(*data.keys)
  #      expect(user_attrs.values.any?(&:nil?)).to be false case/when X
  #11 хук на деактивацію щоб відбувався під кожним сценарієм, робив серч по юзер емейл і дивився чи ніл чи ні, якещо не ніл то деактивовуємо далі X



