@login @broker_auth
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
      | First Name | Last Name | Email                | Role          |
      | Serhii     | Starshoi  | 45248252@gmail.com | Watch Officer |
    And I search for user
      | query                |
      | 45248252@gmail.com |
    And I check user is created:
      | Name            | Email                | Role          |
      | Serhii Starshoi | 45248252@gmail.com | Watch Officer |

  @deactivate_watch_officer
  Scenario: Deactivate created Watch Officer user
    Given I login as Broker user
    When I open My Team page
    And I click "Add user" button at "My Team" page
    And I fill in data:
      | First Name | Last Name | Email               | Role          |
      | Serhii     | Starshoi  | 932482932@gmail.com | Watch Officer |
    And I click "Save" button at "My Team" page
    And I search for user
      | query               |
      | 932482932@gmail.com |
    And I deactivate user
    And I check user is deactivated
      | Email               |
      | 932482932@gmail.com |

  #. класи + наслідування в рубі книжка прочитати


  #1. CMD S щоб заберало пробіли лишні
  #2. double quots
  #3. name args підсказки забрати
  #4. зробити рандом на емейл (записувати таблицю в інстанс зміннм (вони доступні між сетпами) хеш має бути,
  # і у всіх наступних степах підтягую
  #5. api створити асет, а юайно відкрити на ам і перевірити чи він Stationary