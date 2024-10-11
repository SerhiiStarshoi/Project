Feature: Devices

  Scenario: Create Device
    When I create device:
      | portal | imei     | origin | type  |
      | 16288  | AT_RANGE | nil    | 14592 |
    Then I check device details:
      | model  | activated |
      | 001den | true      |

  Scenario: Update Device
    When I create device:
      | portal | imei     | origin | type  |
      | 16288  | AT_RANGE | nil    | 14592 |
    Then I update device:
      | imei     | origin   |
      | AT_RANGE | 5837333 |
    Then I check device details:
      | imei     | origin  | model |
      | AT_RANGE | 5837333 | 001den |

  Scenario: Deactivate Device
    When I create device:
      | portal | imei     | origin | type  |
      | 16288  | AT_RANGE | nil    | 14592 |
    Then I deactivate device:
      | name     |
      | AT_RANGE |
    Then I check device is deactivated:
      | activated |
      | false     |

