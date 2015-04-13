require 'calabash-android/abase'
require File.dirname(__FILE__) + '/../../features/repo_id/ids'
require File.dirname(__FILE__) + '/../../features/page/basepage'



class EstimatesPage < BasePage
  include Calabash::Android::Operations
  include Minitest::Assertions

  def estimates
    estimates_button = "* marked:'Estimates & Statements'"
    wait_for_elements_exist [estimates_button], timeout: $wait_time
    touch(estimates_button)
    sleep 5
    # wait_for_elements_do_not_exist ["* id:'loader_image'"], timeout: $wait_time
  end

  def navigation_tab (navigation_tab)
      query_string = "* marked:'#{navigation_tab}'"

      if navigation_tab == "Due"
        sleep 2
        touch("* marked:'Due'")
        sleep 5

      elsif navigation_tab == "Processing"
        sleep 2
        touch("* marked:'Processing'")
        sleep 5
      elsif navigation_tab == "Paid"
        sleep 3
        touch("* marked:'Paid'")
        sleep 3

      else navigation_tab == "Failed"
      sleep 3
        touch("* marked:'Failed'")
      sleep 4
      end

  end

  def dashboard
     wait_for_elements_exist ["* marked:'UPCOMING APPOINTMENTS'"], timeout: $wait_time
     sleep 3
     touch("* marked:'CANCEL'")
  end

  def lhn
    lhn = "* marked:'Dashboard, Open Menu'"
    # wait_for_elements_exist [lhn], timeout: $wait_time
    touch(lhn)
    sleep 3
  end


end