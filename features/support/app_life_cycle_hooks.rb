require 'calabash-android/management/adb'
require 'calabash-android/operations'
require 'fileutils'
require 'minitest/autorun'

@@project_path=File.expand_path("../../../", __FILE__)
FileUtils.rm_rf(Dir.glob(@@project_path+'/screenshot/pass'+'/*.png'+''))
FileUtils.rm_rf(Dir.glob(@@project_path+'/screenshot/fail'+'/*.png'+''))


Before do |scenario|
#checks if the scenario is outlined
#copies default value 390 error code to test_data.txt under search


  unless File.directory?(@@project_path +'/screenshot/pass')
    FileUtils.mkdir_p(@@project_path+'/screenshot/pass')
  end
  @@path=@@project_path + "/screenshot"
  start_test_server_in_background
end

=begin
AfterStep do |scenario|
	sleep 1.5
	screenshot_embed(:prefix => @@path+'/pass/'+'', :name => "sc_#{Time.now.to_i}")
end
=end

After do |scenario|
  if scenario.failed?
    unless File.directory?(@@project_path +'/screenshot/fail')
      FileUtils.mkdir_p(@@project_path+'/screenshot/fail')
    end
    screenshot_embed(:prefix => @@path+'/fail/', :name => "sc_#{Time.now.to_i}")
  end
  shutdown_test_server
end
