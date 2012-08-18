Feature: Cucumber web testing
  In order to verify the sRNA app is working
  As a developer
  I want to see the home page

  Scenario: View home page
    Given I am on the home page
    Then I should see "sRNA App"
    And I should see "Select your replicon of interest:"
    And I should see "Select the partner replicons for BLAST:"