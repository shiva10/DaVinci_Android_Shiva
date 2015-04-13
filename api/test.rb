require File.dirname(__FILE__) + '/api_wrappers'
require 'selenium-webdriver'


puts 'opening the browser'
@@driver = Selenium::WebDriver.for :safari
@@driver.navigate.to "https://m.tesco.com/h5/groceriestabletapp/ipad/securelogin?"
username = @@driver.find_element(:id, 'loginID')
credentails=ENV['LOGIN'].split(':')
username.send_keys credentails[0]
password=@@driver.find_element(:id, 'password')
password.send_keys credentails[1]
sleep(2)
@@driver.find_element(:id, 'confirm').click
# wait for a specific element to show up
wait = Selenium::WebDriver::Wait.new(:timeout => 20) # seconds
wait.until { @@driver.find_element(:name => 'proceedToPayment') }
@@driver.find_element(:name, 'proceedToPayment').click
wait = Selenium::WebDriver::Wait.new(:timeout => 20) # seconds
wait.until { @@driver.find_element(:name => 'cardNumber') }
@@driver.find_element(:xpath,".//*[@id='cardNumber-0']").send_keys ''
@@driver.find_element(:xpath,".//*[@id='cardNumber-0']").send_keys '4444333322221111'
wait = Selenium::WebDriver::Wait.new(:timeout => 20) # seconds
wait.until { @@driver.find_element(:name => 'securityCode') }
@@driver.find_element(:id, 'securityCode-0').send_keys '123'
@@driver.find_element(:id, 'submitButtons').location_once_scrolled_into_view
sleep(2)
@@driver.find_element(:xpath, ".//*[@id='submitButtons']/div/div[1]/input").click
sleep(15)
puts 'checkout completed'
@@driver.quit