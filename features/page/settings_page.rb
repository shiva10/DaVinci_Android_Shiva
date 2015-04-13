require 'calabash-android/abase'
require File.dirname(__FILE__) + '/../../features/repo_id/ids'
require File.dirname(__FILE__) + '/../../features/page/basepage'

class SettingsPage < BasePage
  include Calabash::Android::Operations
  include Minitest::Assertions


  def settings_screen
    wait_for_elements_exist ["* marked:'SETTINGS'"], timeout: 10
  end

end
