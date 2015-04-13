require File.dirname(__FILE__) + '/../../features/repo_id/ids'


Then(/^I should see the settings screen$/) do
  @@settings_page.settings_screen
end

Then(/^I tap on remember username as (.*)$/) do |arg|
  if element_exists ("* marked:'#{arg}'")
    touch("* marked:'#{arg}'")
  end
end

Then(/^I select appointment prePay option$/) do
  if element_exists("* id:'setting_prepay'")
    touch("* id:'setting_prepay'")
    $short_wait
  end
end

Then(/^I select  fill form option$/) do
  if element_exists("* id:'settings_fill_form_button'")
    touch("* id:'settings_fill_form_button'")
  end
end

Then(/^I should see the provider name as (.*)$/) do |arg|
  if element_exists("* marked:'#{arg}'")
    query("* marked:'#{arg}'")
    puts "#{arg}"
  end
end

Then (/^I should see the user name in the text field as (.*)$/) do |username|
  if element_exists ("* marked:'#{username}'")
    puts "User name is in the login screen"
  end
end

Then (/^I should not see the user name in the text field$/) do
  wait_for_elements_exist ["* id:'editText_username'"], timeout:$wait_time
  expected_text = ["qaandroid"]
  actual_text = query("EditText id:'editText_username'", :text)
  unless expected_text == actual_text
    fail "Text in email field is incorrect. Expected '#{expected_text}', but got '#{actual_text}'."
  end





end