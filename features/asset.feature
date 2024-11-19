@asset @broker_auth
Feature: UI/API Test

  @create_tractor
  Scenario: Create new tractor
    Given I login as Broker user
    When I search for "810 Carriers" company
    And I click "Manage Assets" button at "My Network" page
    And I click "Add Asset" button at "Assets" page
    And I fill in data:
  #at "Assets" page:
      | Category | Type    |
      | Road     | Tractor |
    And I click Create button
    And I search for tractor
    And I open Asset details
    Then I check asset status via UI:
      | Status     |
      | Stationary |
    Then I check asset details via API:
      | Status     | Type    |
      | Stationary | Tractor |
