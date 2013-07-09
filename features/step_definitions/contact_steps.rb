def create_message
  @message ||= {:name => 'test', :email => 'test@example.com', :subject => 'My subject', :body => 'Message ...'}
end

def fill_contact_form
  fill_in 'message_name', with: @message[:name] 
  fill_in 'message_email', with: @message[:email] 
  fill_in 'message_subject', with: @message[:subject] 
  fill_in 'message_body', with: @message[:body] 
  click_button 'Send'
end

Given /^I visit the the contact rubrique$/ do
  visit contact_path
end

When /^I fill the contact form and i submit$/ do
  create_message
  fill_contact_form
end

When /^I fill the contact form with an invalid email$/ do
  create_message
  @message.merge!(:email => 'invalidemail')
  fill_contact_form
end

Then /^I should see message congratulation$/ do
  page.body.should have_content 'Thank you for your message'
end

Then /^I should see an invalid email message$/ do
  page.should have_content 'Emailis invalid'
  page.should have_content 'Please fill all fields'
end
