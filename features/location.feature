Feature: Locations

  Scenario: Create
    Given I authorize as Broker user
    When I create location:
      | portal | name     | custom title | type     | latitude  | longitude |
      | 16288  | AT_RANGE | some title   | Standard | 47.444956 | 18.960501 |
    Then I check location details:
      | name     | address                                    |
      | AT_RANGE | Budaörs, Akron Utca 2, 2040, Pest, Hungary |

  Scenario: Update
    Given I authorize as Broker user
    When I create location:
      | portal | name     | custom title | type     | latitude  | longitude |
      | 16288      | AT_RANGE | some title   | Standard | 47.444956 | 18.960501 |
    When I update location coordinates:
      | portal | name     | custom title | type     | latitude | longitude |
      | 16288  | AT_RANGE | UPDATED            | Standard | 47.14431 | 21.64162  |
    Then I check location is updated:
      | name     | custom title | latitude | longitude |
      | AT_RANGE | UPDATED      | 47.14431 | 21.64162  |

  Scenario: Deactivate
    Given I authorize as Broker user
    When I create location:
      | portal | name     | custom title | type     | latitude  | longitude |
      | 16288  | AT_RANGE | some title   | Standard | 47.444956 | 18.960501 |
    When I deactivate location
      | name     |
      | AT_RANGE |
    Then I check location is deactivated:
      | name     | activated |
      | AT_RANGE | false     |


