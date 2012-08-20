Feature: sRNA App testing
  In order to verify the sRNA app is working
  As a developer
  I want to see the home page

  Scenario: View home page
    Given I am on the home page
    Then I should see "Generate Config File"

  Scenario: Submit default form
    Given I am on the home page
    When I press "Generate Config File"
    Then I should see "NC_014248"
    And I should see "PS"
    And I should see "ALL"