require 'calabash-android/abase'
require 'test/unit/assertions'
require 'pry'
require File.dirname(__FILE__) + '/../../features/repo_id/ids'
require 'test/unit/assertions'
include Test::Unit::Assertions


module Tesco

	def enter_credentials(username, password)
		sleep 3
		wait_for_elements_exist [$username_field], timeout: $wait_time
		set_text "webView css:input[id=email]", "#{username}"
		set_text "webView css:input[id=password]", "#{password}"
		# query($username_field, :setText => "#{username}")
		# query($password_field, :setText => "#{password}")
	end


	def assert_element_on_screen(actual)
		escape_special_char=actual.gsub("'", "")
		mark = escape_quotes(actual)
		wait_for_elements_exist ["* marked:'#{mark}'"], timeoout: 20
		on_screen=query("* RobotoTextView", :text)
		count_arry =on_screen.count
		new_ele=Array.new
		count_arry.times do |i|
			new_ele.push on_screen[i].gsub("'", "")
		end
		expected= new_ele.include? escape_special_char
		 assert expected, "Application could not see" + escape_special_char
	end



	#####################################################
	# For Example:                                      #
	#  assert_send([[1, 2], :member?, 1]) # -> pass     #
	#  assert_send([[1, 2], :member?, 4]) # -> fail     #
	#####################################################
	def assert_array_element(array_list, expected_in_array)
		assert_send([array_list, :member?, expected_in_array], message='Element'+expected_in_array+' not present in array list')
	end



	def assert_element_not_same(expected, actual)
		assert_not_equal(expected, actual, message='Expected::'+expected.to_s+' and Actual::'+actual.to_s+' are holding the same value')
	end



	def assert_element_equal(expected, actual)
		assert_equal(expected, actual)
	end



	######################################################################
	# For Example:                                                        #
	#  assert_two_arrays([1,2],[2,1],msg='arrays not same') # -> pass     #
	#  assert_two_arrays([1,2],[1,1],msg='arrays not same') # -> fail     #
	######################################################################

	def assert_two_arrays(a1, a2, msg = nil)
		[:select, :inject, :size].each do |m|
			[a1, a2].each { |a| assert_respond_to(a, m, "Are you sure that #{a.inspect} is an array?  It doesn't respond to #{m}.") }
		end
		assert a1h = a1.inject({}) { |h, e| h[e] ||= a1.select { |i| i == e }.size; h }
		assert a2h = a2.inject({}) { |h, e| h[e] ||= a2.select { |i| i == e }.size; h }
		assert_equal(a1h, a2h, msg)
	end



	def assert_two_arrays_not_same(a1, a2, msg = nil)
		[:select, :inject, :size].each do |m|
			[a1, a2].each { |a| assert_respond_to(a, m, "Are you sure that #{a.inspect} is an array?  It doesn't respond to #{m}.") }
		end
		assert a1h = a1.inject({}) { |h, e| h[e] ||= a1.select { |i| i == e }.size; h }
		assert a2h = a2.inject({}) { |h, e| h[e] ||= a2.select { |i| i == e }.size; h }
		assert_not_equal(a1h, a2h, msg)
	end



	def wait_for_none_animating
		sleep 8
	end



	def until_element_exists element, action
		wait_poll until_exists: element, timeout: $wait_time do
			action.call
		end
	end



	def once_element_exists element, action = lambda { touch element }
		#With this time out you better be sure it will show
		wait_for_elements_exist [element], timeout: $wait_time
		action.call
	end



	def scroll_down_to? element
		performAction "scroll_down"
		element_exists element
	end



	def scroll_up_to? element
		performAction "scroll_up"
		element_exists element
	end



	def assert_true(bool, msg)
		assert(bool, msg)
	end



	def wait_for_animate_3sec
		sleep(3)
	end



	def wait_for_animate_2sec
		sleep(2)
	end



	def wait_for_animation
		sleep(1)
	end



	def wait_for_animate_5sec
		sleep(5)
	end


	def scroll_down
		back_button_anchor = query "android.widget.ImageView id:'action_bar_up_navigation'"
		x = back_button_anchor.first["rect"]["center_x"]
		y = back_button_anchor.first["rect"]["center_y"]

		performAction('drag_coordinates', x, 10*y, x, y)
	end



	def scroll_down_a_bit
		back_button_anchor = query "android.widget.ImageView id:'action_bar_up_navigation'"
		x = back_button_anchor.first["rect"]["center_x"]
		y = back_button_anchor.first["rect"]["center_y"]

		performAction('drag_coordinates', x, 3*y, x, y)
	end



	def scroll_up
		back_button_anchor = query "android.widget.ImageView id:'action_bar_up_navigation'"
		x = back_button_anchor.first["rect"]["center_x"]
		y = back_button_anchor.first["rect"]["center_y"]

		performAction('drag_coordinates', x, 2*y, x, 10*y)
	end


	def dismiss_dialogue
		if element_exists "* marked:'ok_single_btn'"
			touch "* marked:'ok_single_btn'"
			wait_for_elements_do_not_exist ["* marked:'ok_single_btn'"]
		else
			query_size = query("*").size - 1
			touch("* index:#{query_size}") if element_exists "* index:#{query_size}"
			wait_for_elements_do_not_exist ["* index:#{query_size}"]
		end
	end

	def visible?(uiquery)
		frame_height = (query "FrameLayout")[0]["rect"]["height"]
		frame_width = (query "FrameLayout")[0]["rect"]["width"]
		test_height = (query uiquery)[0]["rect"]["center_y"]
		test_width = (query uiquery)[0]["rect"]["center_x"]

		if within_frame_y?(test_height, frame_height) && within_frame_x?(test_width, frame_width)
			true
		else
			false
		end

	end



	def within_frame_y?(test_height, frame_height)
		test_height < frame_height && test_height > 0
	end



	def within_frame_x?(test_width, frame_width)
		test_width < frame_width && test_width > 0
	end



	def escape_quotes(str)
		str.gsub("'", "\\\\'")
	end



	def touch_element(element_id)
		query_string = "* marked:'#{element_id}'"
		if element_exists query_string
			touch query_string
		else
			raise "Element does not exist"
		end
	end


	def array_element_exists(elements_arr, options={})
		options[:timeout_message] = options[:timeout_message] || "Timeout waiting for elements: #{elements_arr.join(",")}"
		elements_arr.any? { |q| element_exists(q) }
	end

end

World(Tesco)
