@admin_auth
Feature: Devices

  Scenario: Create Device
    When I create device:
      | portal | type  |
      | 16288  | 14592 |
    Then I check device details:
      | model  | origin | device_status      | activated |
      | 001den | nil      | assigned_to_portal | true      |

  Scenario: Update Device
    When I create device:
      | portal | imei     | origin | type  |
      | 16288  | AT_RANGE | nil    | 14592 |
    Then I update device:
      | imei     | origin   |
      | AT_RANGE | 5837333 |
    Then I check device details:
      | imei     | origin  | model  | device_status      |
      | AT_RANGE | 5837333 | 001den | assigned_to_origin |

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


  # different combinations of tests (create device + create location for example)
  # rake (одна команда запустити складену велику дію)
  # test folder remove
  # selenium (web driver)
  # rspec minitest

