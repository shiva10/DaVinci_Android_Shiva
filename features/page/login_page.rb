require 'calabash-android/abase'
require File.dirname(__FILE__) + '/../../features/repo_id/ids'
require File.dirname(__FILE__) + '/../../features/page/basepage'

class LoginPage < BasePage
  include Calabash::Android::Operations
  include Minitest::Assertions

  def enter_user_credential(username, password)
    clear_text_in("android.widget.EditText id:'editText_username'")
    query("* id:'editText_username'",:setText=>username)
    clear_text_in("android.widget.EditText id:'editText_password'")
    query("* id:'editText_password'",:setText=>password)
  end

  def enter_username(username)
    clear_text_in("android.widget.EditText id:'editText_username'")
    query("* id:'editText_username'",:setText=>username)
  end

  def enter_password(password)
    clear_text_in("android.widget.EditText id:'editText_password'")
    query("* id:'editText_password'",:setText=>password)
  end

  def login
    login_button = "* marked:'LOG IN'"
    wait_for_elements_exist [login_button], timeout: $wait_time
    touch(login_button)
    sleep 5
    # wait_for_elements_do_not_exist ["* id:'loader_image'"], timeout: $wait_time

    if element_exists("* marked:'CANCEL'")
      touch("* marked:'CANCEL'")
      sleep 5
    end
  end

end

