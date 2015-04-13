require 'calabash-android/cucumber'



  Dir[File.dirname(__FILE__) + '/../../features/page/*.rb'].each do |file|
  require file
  end
   require File.dirname(__FILE__) + '/../../api/api_wrappers'
   BEGIN { $VERBOSE = nil }


@@login_page||=LoginPage.new
@@httparty||=Partay.new
@@estimates_page||=EstimatesPage.new
@@settings_page||=SettingsPage.new
@@alerts_page||=AlertsPage.new