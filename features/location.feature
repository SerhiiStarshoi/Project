Feature: Locations

  Scenario: Create
    Given I authorize as Broker user
    When I create location:
      | portal | name     | custom title | type     | latitude  | longitude |
      | 16288  | AT_RANGE | some title   | Standard | 47.444956 | 18.960501 |
    Then I check location details:
      | name     | custom title | latitude | longitude | address                                    | activated |
      | AT_RANGE | some title   | 47.44496 | 18.9605   | Budaörs, Akron Utca 2, 2040, Pest, Hungary | true      |

  Scenario: Update
    Given I authorize as Broker user
    When I create location:
      | portal | name     | custom title | type     | latitude  | longitude |
      | 16288      | AT_RANGE | some title   | Standard | 47.444956 | 18.960501 |
    When I update location coordinates, title, coordinates:
      | portal | name     | custom title | type     | latitude | longitude |
      | 16288  | AT_RANGE | UPDATED            | Standard | 47.14431 | 21.64162  |
    Then I check location details:
      | name     | custom title | latitude | longitude | address                                    | activated |
      | AT_RANGE | UPDATED      | 47.14431 | 21.64162  | Budaörs, Akron Utca 2, 2040, Pest, Hungary | true      |

  Scenario: Deactivate
    Given I authorize as Broker user
    When I create location:
      | portal | name     | custom title | type     | latitude  | longitude |
      | 16288  | AT_RANGE | some title   | Standard | 47.444956 | 18.960501 |
    When I deactivate location
      | name     |
      | AT_RANGE |
    Then I check location details:
      | name     | custom title | latitude | longitude | address                                    | activated |
      | AT_RANGE | some title   | 47.44496 | 18.9605   | Budaörs, Akron Utca 2, 2040, Pest, Hungary | false     |
