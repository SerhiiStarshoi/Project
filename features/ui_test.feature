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
    Then I check user is created:
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


  #1. всі менеджери мають виглядати однаково + переглянути чи немає дублікованих методів
  # (методи які є однакові в локейшен і юзер менеджер і зроби батьківський клас з наслідуваннями) X
  #2. search_ui все таки моє шукати по мейлу і розбити на менші якщо 20+ рядків буде X
  #3. get_user_id(email) замінмити на існуючий клас де ми ініціалізуємо вже новий обєкт X
  #4. модуль для юзерів і для пейджз і для авторизацій теж додати X
  #5. click який у 2ох пейджах перенести в -> Page X
  #6. модуль апі який буде рікваєр рілейтив все що там лежить X
  #7. def search_if_activated(location_title) in Locations замінити на метод серч
  # (буде вертати юзера і буду вже брати поле актівейтед) X




  # @driver.find_element(id: "email") забрати якщо воно буде працювати без нього X
  #8. class MyTeamPage глянути чи все можна перенести в прайвит + всі решта класів переглянути X
  #10 .   Then I check user is created: зробити щоб падало якщо ми не маємо Phone X
