require File.dirname(__FILE__) + '/../../features/repo_id/ids'


Given(/^I am on the dash board screen$/) do
  @@estimates_page.dashboard
end

Then(/^I tap on lhn$/) do
  @@estimates_page.lhn
end

Then(/^I select option as (.*)$/) do |arg|
  @@estimates_page.navigation_tab(arg)
end

Then(/^I select Tab as (.*)$/) do |arg|
  @@estimates_page.estimates(arg)
end

Then (/^I should see the selected screen (.*)$/) do |arg|
  if element_exists ("* marked:'#{arg}'")
    touch("* marked:'#{arg}'")
  end
end

Then(/^I tap on lhn options (.*)$/) do |arg|
  if element_exists ("* marked:'#{arg}'")
    touch("* marked:'#{arg}'")
  end
end

Then(/^I should see the estimate screen$/) do
  if element_exists ("* marked:'Estimates'")
    puts"Estimates screen is displayed"
  end
end

