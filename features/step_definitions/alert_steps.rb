Then(/^I click on the alerts count$/) do
  @@alerts_page.alerts_count
end

Then(/^I should be in the Alerts section$/) do
  @@alerts_page.alerts_tab
end

And(/^I select the first Alert$/) do
  @@alerts_page.first_alert
end

Then(/^I perform an action$/) do

end

And(/^I must see empty history page$/) do

end

Then(/^I click on any of the alert and view the details$/) do

end
