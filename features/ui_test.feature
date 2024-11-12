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
      | Serhii     | Starshoi  | 2213313223@gmail.com | Watch Officer |
    And I click "Save" button at "My Team" page
    And I search for user
    Then I check user is created:
      | First Name | Last Name | Email                | Role          |
      | Serhii     | Starshoi  | 2213313223@gmail.com | Watch Officer |

  @deactivate_watch_officer
  Scenario: Deactivate created Watch Officer user
    Given I login as Broker user
    When I open My Team page
    And I click "Add user" button at "My Team" page
    And I fill in data:
      | First Name | Last Name | Email                     | Role          |
      | Serhii     | Starshoi  | 2tf2g12312fvev2@gmail.com | Watch Officer |
    And I click "Save" button at "My Team" page
    And I search for user
    And I deactivate user
    And I check user is deactivated


  #1. всі менеджери мають виглядати однаково + переглянути чи немає дублікованих методів
  # (методи які є однакові в локейшен і юзер менеджер і зроби батьківський клас з наслідуваннями)
  #2. I search for user переробити на юайний Email -> query (rename) X
  #3. решту перенести (5. classes all in lib/pages (ui)  + in lib/api (api) X) + COMMAND CENTER (старе видалити) X
  #4. СommandCenterPage все ренейм X
  #5. #xpath {title} один метод який буде приймати тайтл і клікати на кнопку і він має бути у всіх пейджах (буде один іф або вен замість двох) X
  #6. має наслідуватись для логін пейдж   def initialize(driver)
  #    @driver = driver
  #    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
  #  end
  #7.   def open
  #    @driver.get "#{ENV['APP_URL']}"
  #    sleep 3
  #  має бути в батківському і глянути чи get/navigate? X
  # @driver.find_element(id: "email") забрати якщо воно буде працювати без нього X
  #8. class MyTeamPage глянути чи все можна перенести в прайвит + всі решта класів переглянути X
  #9. watchofficer role - знайти який теег відповідає X
  #10 .   Then I check user is created: зробити щоб падало якщо ми не маємо Phone X
