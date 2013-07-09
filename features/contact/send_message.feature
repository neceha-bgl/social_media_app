Feature: Send a message
  As a visitor to the website
  I want to send a message via the contact form
  so I can know if the message is sent 

    Scenario: The message is sent successfuly 
      Given I visit the the contact rubrique 
      When I fill the contact form and i submit
      Then I should see message congratulation

    Scenario: The user enters a wrong email 
      Given I visit the the contact rubrique 
      When I fill the contact form with an invalid email
      Then I should see an invalid email message
