require 'calabash-android/abase'
require File.dirname(__FILE__) + '/../../features/repo_id/ids'
require File.dirname(__FILE__) + '/../../features/page/basepage'
require 'test/unit/assertions'

class AlertsPage < BasePage
  include Calabash::Android::Operations
  include Minitest::Assertions


  def alerts_count
    wait_for_elements_exist($count_alert, :timeout => $wait_time)
    touch($count_alert)
  end

  def first_alert
    wait_for_elements_exist($first_alert, :timeout => $wait_time)
    touch($first_alert)
  end

  def alerts_tab
    wait_for_elements_exist($alert_tab, :timeout => $wait_time)
    touch($alert_tab)
  end

end
