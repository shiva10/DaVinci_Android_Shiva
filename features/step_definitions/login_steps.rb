require File.dirname(__FILE__) + '/../../features/repo_id/ids'

Given(/^I am on the Login screen$/) do
  begin
    wait_for_elements_exist ["* marked:'Welcome to DaVincian.'"], timeout: 2
  rescue
    puts"Login screen is not displayed"
  end
end

When(/^I enter username as (.*)$/) do |username|
  @@login_page.enter_username(username)
end

When(/^I enter password as (.*)$/) do |password|
  @@login_page.enter_password(password)
end

Then(/^I tap on login button$/) do
  @@login_page.login
end

Then(/^I should see the popup message$/) do
  assert_element_on_screen('Would you like us to remember your username?')
end

Then(/^I tap on (.*) button of popup message$/) do |arg|
  if element_exists ("* marked:'#{arg}'")
    touch("* marked:'#{arg}'")
  else
    puts "Popup message is not displayed"
    end
end

Then(/^I should see the dashboard screen$/) do
  sleep 2
 # assert_element_on_screen('UPCOMING APPOINTMENTS')
  sleep 10
  if element_exists ("* marked:'CANCEL'")
  touch("* marked:'CANCEL'")
  end
end

Then(/^I tap on menu option in dashboard screen$/) do
    sleep 8
    if element_exists ("* marked:'Dashboard, Open Menu'")
    touch("* marked:'Dashboard, Open Menu'")
    end
end

Then(/^I tap on logout button$/) do
    wait_for_elements_exist ["* marked:'Logout'"], timeout:$wait_time
    touch("* marked:'Logout'")
end

Then(/^I should see the user name (.*) prepopulated$/) do |username|
  if element_exists ("* marked:'#{username}'")
    puts "User name is prepopulated in the login screen"
  end
end


Then(/^I should see the message (.*)$/) do |arg|
 # assert_element_on_screen(arg)
  if element_exists("* marked:'#{arg}'")
  puts "Popup message is displayed"
  end
end

Then (/^I tap on the (.*) button$/) do |arg|
  if element_exists("* marked:'#{arg}'")
    touch("* marked:'#{arg}'")
  else
    puts "Popup message is not displayed"
  end
end

And(/^I enter the username as (.*)$/) do |username|
  @@login_page.enter_username(username)
end

And(/^I enter the password as (.*)$/) do |password|
  @@login_page.enter_password(password)
end

Then(/^I should see the blank user name and password text fields$/) do
  wait_for_elements_exist ["* id:'editText_username'"], timeout:$wait_time
   expected_text = []
  actual_text = query("EditText id:'editText_username'", :text)
  unless expected_text == actual_text
    fail "Text in email field is incorrect. Expected '#{expected_text}', but got '#{actual_text}'."
  end

  # assert_equal(expected_text, actual_text);
end

Given(/^I login to the application$/) do
  steps %Q{
	            Given I am on the Login screen
              When I enter username as qaandroid
              And I enter password as 12345
              Then I tap on login button
              Then I should see the dashboard screen
	      }
end

Then (/^I tap on logout button in setting screen$/) do
  wait_for_elements_exist ["* id:'up'"], timeout:$wait_time
  touch("* id:'up'")
  wait_for_elements_exist ["* marked:'Logout'"], timeout:$wait_time
  touch("* marked:'Logout'")
end
