dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require File.expand_path(File.join(dir, 'httparty'))
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
require 'rubygems'
require 'pp'
# require 'selenium-webdriver'
require 'json'


=begin
# You can also use post, put, delete, head, options in the same fashion
response = HTTParty.get('https://api.stackexchange.com/2.2/questions?site=stackoverflow')
puts response.body, response.code, response.message, response.headers.inspect
=end

# An example post to a minimal rails app in the development environment
# Note that "skip_before_filter :verify_authenticity_token" must be set in the
# "pears" controller for this example

class Partay
	include HTTParty
	http_proxy('proxy4.utest.com', 9999, 'utest', 'proxy')


	attr_accessor :access_token, :token_type, :status_info, :status_code, :deliveryslotid, :virtual_store_id, :post_code, :collection_id, :contract_id, :sorted_z_a, :sorted_a_z, :fav_count, :fav_prod_count, :total_search_count, :product_list_name, :amend_mode, :cc_hd_info, :order_size_pending, :slot_booked_info, :nickname, :postcode, :user_name
	# $url='http://212.140.177.75'
	$url='http://mobile.tesco.com'



	# def login_token(access_token, token_type, status_code, status_info)
	# 	self.access_token = access_token
	# 	self.token_type = token_type
	# 	self.status_code = status_code
	# 	self.status_info = status_info
	# end

	def login_token(access_token)
		self.access_token = access_token
	end

	def profile(amend_mode)
		self.amend_mode=amend_mode
	end



	def slot_info(cc_hd_info, slot_booked_info)
		self.cc_hd_info=cc_hd_info
		self.slot_booked_info=slot_booked_info
	end



	def pending_order_count(order_size_pending)
		self.order_size_pending=order_size_pending
	end



	# @return [Object]
	def slot_id(deliveryslotid)
		self.deliveryslotid=deliveryslotid
	end



	def product_name_list(product_list_name)
		self.product_list_name=product_list_name
	end



	def total_product_count(total_search_count)
		self.total_search_count=total_search_count
		puts total_search_count
	end



	def favourite_count(fav_count)
		self.fav_count=fav_count
	end



	def favoutire_product_count(fav_prod_count)
		self.fav_prod_count=fav_prod_count
	end



	def sorted_Z_A(sorted_z_a)
		self.sorted_z_a=sorted_z_a
	end



	def sorted_A_Z(sorted_a_z)
		self.sorted_a_z=sorted_a_z
	end



	def virtual_store(virtual_store_id)
		self.virtual_store_id=virtual_store_id
	end



	def post_code_id(post_code)
		self.post_code=post_code
	end



	def collection_slot_id(collection_id)
		self.collection_id=collection_id
	end



	def order_number(contract_id)
		self.contract_id=contract_id
	end

	# @@credentails=ENV['LOGIN'].split(':')

	def login_access
		response = Partay.post('http://mobiledemo.davinciansupport.com:8080/mvp/mobile-bridge/user/login/', :body => {"username" => "davuser", "password" => "12345", "os" => "1"}.to_json, :headers => {'Content-Type' => 'application/json'})
    # puts response
    data=JSON(response["data"])
    user = JSON(data)["user"]
    session = JSON(user)
    token = JSON(session)["session"]
		if response.success?
			self.login_token(token["token"])
		else
			raise 'exception'
		end
	end

	def login_access_malaysia
		response = Partay.put('https://r.tesco.com.my/api/v1/session', :body => {"email" => @@credentails[0], "password" => @@credentails[1], "ipAddress" => "172.25.58.114"}.to_json, :headers => {'Content-Type' => 'application/json', 'language' => 'en-GB', 'region' => 'MY', 'Host' => 'r.tesco.com.my','Content-Length' => '81'})
		if response.success?
			self.login_token(response["id"])
		else
			raise 'exception'
		end
	end

	# for thailand, only for fetching the customer API
	def profile_state
		response=Partay.get('http://shoponline.tescolotus.com/api/v1/Customer/',:headers => {'Content-Type' => 'application/json', 'language' => 'en-GB', 'region' => 'TH', 'userId' => access_token })
		puts response
		self.profile(JSON(response)["InAmendOrderMode"])
	end



	def get_choosen_slot
		slot_cc_hd=Partay.get($url+'/groceryapi/RESTService.aspx?COMMAND=GETCHOSENSLOTINFO&sessionkey='+access_token+'&version=2.0&SURCHARGEMSG=Y')
		puts slot_cc_hd
		self.slot_info(JSON(slot_cc_hd)["IsClickAndCollect"], JSON(slot_cc_hd)["ChosenDeliverySlotInfo"])
	end



	def add_item
		response_search = Partay.get('http://shoponline.tescolotus.com/api/v1/search/products?query=Sugar&page=1&sortBy=Relevance', :headers => {'Content-Type' => 'application/json', 'language' => 'en-gb', 'region' => 'TH', 'userId' => access_token})
		puts search_result=JSON(response_search['productItems'][0])
		puts productid =JSON(search_result)["product"]["id"]
		items_json_responses = {'items' => [{'id'=>'6022597263','oldValue'=>0.0,'oldUnitChoice'=>'pcs','newUnitChoice'=>'pcs','newValue'=>1.0}]}.to_json
		puts items_json_responses
		response = Partay.put('http://shoponline.tescolotus.com/api/v1/trolley/items/', :headers => {'Content-Type' => 'application/json', 'language' => 'en-GB', 'region' => 'TH', 'userId' => access_token}, :body => items_json_responses)
		puts response
	end



	def book_a_slot_homedelivery
		base_url='http://mobile.tesco.com/groceryapi/RESTService.aspx?'
		response_book_a_slot=Partay.get(URI.escape(URI.encode($url+'/groceryapi/RESTService.aspx?COMMAND=LISTDELIVERYSLOTS&sessionkey='+access_token+'&version=2.0&WEEKNO=2')))
		self.slot_id(JSON(response_book_a_slot)["DeliverySlots"][0]["DeliverySlotId"])
		response_choose_a_slot=Partay.get(URI.escape(URI.encode($url+'/groceryapi/RESTService.aspx?COMMAND=CHOOSEDELIVERYSLOT&sessionkey='+access_token+'&DELIVERYSLOTID='+deliveryslotid+'&version=2.0')))
	end



	def book_a_slot_click_and_collect
		response_collection_point=Partay.get($url+'/groceryapi/RESTService.aspx?COMMAND=LISTCOLLECTIONPOINTS&sessionkey='+access_token+'&version=2.0')
		puts '****** response collection point'+ response_collection_point
		self.virtual_store(JSON(response_collection_point)["CollectionPoints"][0]["VirtualStoreID"])

		response_post_code=Partay.get($url+'/groceryapi/RESTService.aspx?COMMAND=DEFAULTDELIVERYADDRESS&sessionkey='+access_token+'&version=2.0')
		self.post_code_id(JSON(response_post_code)["Postcode"])

		response_list_collection_slot=Partay.get($url+'/groceryapi/RESTService.aspx?COMMAND=LISTCOLLECTIONSLOTS&sessionkey='+access_token+'&version=2.0&virtualstoreid='+virtual_store_id+'&PostCode='+post_code+'&WEEKNO=2')

		self.collection_slot_id(JSON(response_list_collection_slot)["CollectionSlots"][0]["CollectionSlotID"])

		response_choose_collection_slot=Partay.get(URI.escape(URI.encode($url+'/groceryapi/RESTService.aspx?COMMAND=CHOOSECOLLECTIONSLOT&sessionkey='+access_token+'&version=2.0&CollectionSlotId='+collection_id+'&virtualstoreid='+virtual_store_id+'&PostCode='+post_code)))
		puts response_choose_collection_slot
	end



	#  for Malaysia
	def empty_basket
		response = Partay.delete('http://eshop.tesco.com.my/api/v1/trolley/items', :headers => {'Content-Type' => 'application/json','language' => 'en-GB', 'region' => 'MY', 'userId' => access_token, 'Host' => 'r.tesco.com.my'})
		puts response
		#response_empty_backet=Partay.get($url+'/groceryapi/RESTService.aspx?COMMAND=EMPTYBASKET&sessionkey='+access_token+'&version=2.0')
	end




	def pending_order_size
		response_get_order=Partay.get($url+'/groceryapi/RESTService.aspx?COMMAND=LISTPENDINGORDERS&sessionkey='+access_token+'&version=2.0')
		self.pending_order_count(JSON(response_get_order)["PendingOrders"].size)
	end



	def cancel_pending_order
    order_details = Partay.get('http://shoponline.tescolotus.com/api/v1/orders', :headers => {'language' => 'en-gb', 'region' => 'TH', 'userId' => access_token})
    # response = Partay.delete('http://eshop.tesco.com.my/api/v1/orders', :headers => {'Content-Type' => 'application/json','language' => 'en-GB', 'region' => 'MY', 'userId' => access_token, 'Host' => 'r.tesco.com.my'})
    puts order_details
    puts count=JSON(order_details[0])
    productid = JSON(count)["id"]
    puts productid
    # $orderurl='http://shoponline.tescolotus.com/api/v1/orders/'
    # response = Partay.delete($orderurl+productid, :headers => {'language' => 'en-gb', 'region' => 'TH', 'userId' => access_token})

    if JSON(order_details)["PendingOrders"].empty?
      puts 'No Pending orders'
    else
      count=JSON(order_details)["PendingOrders"].size
      count.times do |i|
        self.order_number(JSON(order_details)["PendingOrders"][i]["id"])
        $orderurl='http://shoponline.tescolotus.com/api/v1/orders/'
        response = Partay.delete($orderurl+productid, :headers => {'language' => 'en-gb', 'region' => 'TH', 'userId' => access_token})
      end
    end
  end

	def amend_order
		order_details = Partay.get('http://shoponline.tescolotus.com/api/v1/orders', :headers => {'language' => 'en-gb', 'region' => 'TH', 'userId' => access_token})
		# response = Partay.delete('http://eshop.tesco.com.my/api/v1/trolley/items', :headers => {'Content-Type' => 'application/json','language' => 'en-GB', 'region' => 'MY', 'userId' => access_token, 'Host' => 'r.tesco.com.my'})
		puts order_details
		puts count=JSON(order_details[0])
		productid = JSON(count)["id"]
		puts productid
		$orderurl='http://shoponline.tescolotus.com/api/v1/orders/amend/'

		response = Partay.put($orderurl+productid, :headers => {'language' => 'en-gb', 'region' => 'TH', 'userId' => access_token})

	end


	def save_amend_order
		$orderurl='http://shoponline.tescolotus.com/api/v1/orders/amend'
		response = Partay.post($orderurl, :headers => {'language' => 'en-GB', 'region' => 'TH', 'userId' => access_token})
	end

	def cancel_amend_mode

		# response = Partay.delete('http://eshop.tesco.com.my/api/v1/trolley/items', :headers => {'Content-Type' => 'application/json','language' => 'en-GB', 'region' => 'MY', 'userId' => access_token, 'Host' => 'r.tesco.com.my'})

		order_details = Partay.get('http://shoponline.tescolotus.com/api/v1/orders', :headers => {'language' => 'en-gb', 'region' => 'TH', 'userId' => access_token})
		puts count=JSON(order_details[0])
		productid = JSON(count)["id"]
		puts productid
		$orderurl='http://shoponline.tescolotus.com/api/v1/orders/amend/'
		response = Partay.delete($orderurl, :headers => {'language' => 'en-gb', 'region' => 'TH', 'userId' => access_token})
	end

	def sort_by_a_z
		response_get_fav_list=Partay.get($url+'/groceryapi/RESTService.aspx?COMMAND=LISTFAVOURITES&sessionkey='+access_token+'&page=1&version=2.0&SORTBY=Alphabetical+A-Z')
		#@@response_sorted_z_a=JSON(response_get_fav_list)["Products"].sort_by { |hash| hash['Name'] }
		@@response_sorted_a_z=JSON(response_get_fav_list)["Products"]
		count=3
		@@sorted_names_a_z=Array.new
		count.times { |i|
			@@sorted_names_list=@@response_sorted_a_z[i]['Name']
			if @@sorted_names_list.include? 'UNAVAILABLE:'
				@@sorted_names_list.to_s
				@@sorted_names_list.slice! "UNAVAILABLE:"
				@@sorted_names_a_z.push @@sorted_names_list.strip
			elsif @@sorted_names_list.include? 'WHY NOT TRY:'
				@@sorted_names_list.to_s
				@@sorted_names_list.slice! "WHY NOT TRY:"
				@@sorted_names_a_z.push @@sorted_names_list.strip
			else
				@@sorted_names_a_z.push @@sorted_names_list.strip
			end
		}
		self.sorted_A_Z(@@sorted_names_a_z)
	end



	def sort_by_z_a
		response_get_fav_list=Partay.get($url+'/groceryapi/RESTService.aspx?COMMAND=LISTFAVOURITES&sessionkey='+access_token+'&page=1&version=2.0&SORTBY=Alphabetical+Z-A')
		#@@response_sorted_z_a=JSON(response_get_fav_list)["Products"].sort_by { |hash| hash['Name'] }
		@@response_sorted_z_a=JSON(response_get_fav_list)["Products"]
		count=3
		@@sorted_names_z_a=Array.new
		count.times { |i|
			@@sorted_names_list=@@response_sorted_z_a[i]['Name']
			if @@sorted_names_list.include? 'UNAVAILABLE:'
				@@sorted_names_list.to_s
				@@sorted_names_list.slice! "UNAVAILABLE:"
				@@sorted_names_z_a.push @@sorted_names_list
			elsif @@sorted_names_list.include? 'WHY NOT TRY:'
				@@sorted_names_list.to_s
				@@sorted_names_list.slice! "WHY NOT TRY:"
				@@sorted_names_z_a.push @@sorted_names_list
			else
				@@sorted_names_z_a.push @@sorted_names_list
			end
		}
		self.sorted_Z_A(@@sorted_names_z_a)
	end



	#Thailand for favourites count
	def favourites
		favourites = Partay.get('http://shoponline.tescolotus.com/api/v1/favorites/by-category?page=1&sortby=Relevance&issecure=False', :headers => {'Content-Type' => 'application/json','language' => 'en-GB', 'region' => 'TH', 'userId' => access_token, 'Host' => 'r.tesco.com.my'})
		favourites_counter = JSON(favourites)
		self.favourite_count(JSON(favourites_counter)["pageInformation"]["totalCount"])
		if fav_count >= 1
			puts "Your favourites count is:#{fav_count}"
		else
			raise "There are no products in your favourites list."
		end
	end




	def favourites_assertion
		favourites_cnt = Partay.get($url+'/groceryapi/RESTService.aspx?COMMAND=LISTFAVOURITES&sessionkey='+access_token+'&page=1&version=2.0')
		if favourites_cnt.success?
			self.favourite_count(JSON(favourites_cnt)["PageProductCount"])
			self.favoutire_product_count(JSON(favourites_cnt)["Products"].count.to_i)
		else
			raise "response failed"
		end
		if fav_count >= 1
			puts "Your favourites count is:#{fav_count}"
		else
			raise "There are no products in your favourites list."
		end
	end



	def addrress_slot_change
		adrs_cng = Partay.get($url+'/groceryapi/RESTService.aspx?COMMAND=CHANGEDELIVERYADDRESS&sessionkey='+access_token+'&version=2.0&newaddressid=1')
		puts "#{adrs_cng}"
		list_adrs = Partay.get($url+'/groceryapi/RESTService.aspx?COMMAND=LISTDELIVERYADDRESSES&sessionkey='+access_token+'&version=2.0')
		if list_adrs.success?
			address_id = JSON(list_adrs)["DeliveryAddresses"][0]["AddressID"]
			address_change = Partay.get($url+'/groceryapi/RESTService.aspx?COMMAND=CHANGEDELIVERYADDRESS&sessionkey='+access_token+'&version=2.0&newaddressid='+address_id+'')
			puts "#{address_change}"
		else
			raise 'failed'
		end

	end



	#Thailand search count annonymous
	def get_searchproduct_count_anonymous
		response_search = Partay.get('http://shoponline.tescolotus.com/api/v1/search/products?query=Sugar&page=1&sortBy=Relevance', :headers => {'Content-Type' => 'application/json', 'language' => 'en-gb', 'region' => 'TH'})
		search_result=JSON(response_search)
		self.total_product_count(JSON(search_result)["pageInformation"]["totalCount"])
		puts total_search_count

	end


	#Thailand search count
	def get_searchproduct_count
		response_search = Partay.get('http://shoponline.tescolotus.com/api/v1/search/products?query=Sugar&page=1&sortBy=Relevance', :headers => {'Content-Type' => 'application/json', 'language' => 'en-gb', 'region' => 'TH', 'userId' => access_token})
		search_result=JSON(response_search)
		self.total_product_count(JSON(search_result)["pageInformation"]["totalCount"])
		puts total_search_count
	end


	#Thailand for getting product name
	def get_search_product_list
		response_search = Partay.get('http://shoponline.tescolotus.com/api/v1/search/products?query=Sugar&page=1&sortBy=Relevance', :headers => {'Content-Type' => 'application/json', 'language' => 'en-gb', 'region' => 'TH', 'userId' => access_token})
		@@product_list=Array.new
		3.times do |i|
			@@count ||=0
			search_result=JSON(response_search['productItems'][i])
			product_list_name =JSON(search_result)["product"]["shortDescription"]
			@@product_list.push product_list_name
			@@count+= 1
		end
		self.product_name_list(@@product_list)
	end


  # def add_item_value_twenty_five
		# base_url=$url+'/groceryapi/RESTService.aspx?COMMAND=CHANGEBASKET&sessionkey='+access_token+'&PRODUCTID=&CHANGEQUANTITY=0&version=2.0&SURCHARGEMSG=Y&GETLINEITEMS=Y&MULTIADD=Y&PRODUCTIDSWITHQUANTITIES=281426090~25'
		# puts base_url
		# Partay.get(URI.escape(base_url))
  # end


  def add_item_value_twenty_four
    response_search = Partay.get('http://shoponline.tescolotus.com/api/v1/search/products?query=Sugar&page=1&sortBy=Relevance', :headers => {'Content-Type' => 'application/json', 'language' => 'en-gb', 'region' => 'TH', 'userId' => access_token})
    puts search_result=JSON(response_search['productItems'][0])
    puts productid =JSON(search_result)["product"]["id"]
    items_json_responses = {'items' => [{'id'=>'6071448594','oldValue'=>0.0,'oldUnitChoice'=>'pcs','newUnitChoice'=>'pcs','newValue'=>24.0}]}.to_json
    puts items_json_responses
    response = Partay.put('http://shoponline.tescolotus.com/api/v1/trolley/items/', :headers => {'Content-Type' => 'application/json', 'language' => 'en-GB', 'region' => 'TH', 'userId' => access_token}, :body => items_json_responses)
    puts response
  end



	def add_item_missed_promotion
		response_additem=Partay.get($url+'/groceryapi/restservice.aspx?COMMAND=CHANGEBASKET&sessionkey='+access_token+'&PRODUCTID=259373535&CHANGEQUANTITY=1&version=2.0')
	end



	def add_item_rdg_message
		response_additem=Partay.get($url+'/groceryapi/restservice.aspx?COMMAND=CHANGEBASKET&sessionkey='+access_token+'&PRODUCTID=279705367&CHANGEQUANTITY=1&version=2.0')
	end



	def add_item_multiple(count)
		response_search=Partay.get($url+'/groceryapi/RESTService.aspx?COMMAND=PRODUCTSEARCH&searchtext=Sugar&page=1&sessionkey='+access_token+'&version=2.0')
		count_product=count
		@@base_url=$url+'/groceryapi/RESTService.aspx?COMMAND=CHANGEBASKET&sessionkey='+access_token+'&PRODUCTID=&CHANGEQUANTITY=0&version=2.0&SURCHARGEMSG=Y&GETLINEITEMS=Y&MULTIADD=Y&PRODUCTIDSWITHQUANTITIES'
		@@product_id_list=Array.new
		count_product.to_i.times do |i|
			search_result=JSON(response_search)["Products"][i]["ProductId"]
			@@product_id_list.push search_result
		end
		puts @@product_id_list
		@amend_prod_count='~1|'
		@amended_string='='
		count_product.to_i.times do |i|
			@amended_string=@amended_string + @@product_id_list[i]
			@amended_string = @amended_string + @amend_prod_count
		end
		@amended_string.chop!
		@@base_url=@@base_url+@amended_string
		puts @@base_url
		Partay.get(URI.escape(@@base_url))
	end



	def check_out
		begin
			puts 'opening the browser'
			@@driver = Selenium::WebDriver.for :firefox
			@@driver.navigate.to "https://s.tescolotus.com/en-GB/checkout?chromeless=1&ui=mobile"
			username = @@driver.find_element(:id, 'email')
			credentails=ENV['LOGIN'].split(':')
			username.send_keys credentails[0]
			password=@@driver.find_element(:id, 'password')
			password.send_keys credentails[1]
			sleep(2)
			@@driver.find_element(:xpath, "//button[contains(.,'Sign in')]").click
			sleep 10
			@@driver.find_element(:link_text => 'Pay at the door').click
			sleep 5
			@@driver.find_element(:xpath, "//button[contains(.,'Place order')]").click
			sleep(15)
			puts 'checkout completed'
			@@driver.quit
		rescue
			#@@driver.quit
			puts 'in rescue block execution'
			puts 'opening the browser'
			@@driver = Selenium::WebDriver.for :firefox
			@@driver.navigate.to "https://s.tescolotus.com/en-GB/checkout?chromeless=1&ui=mobile"
			username = @@driver.find_element(:id, 'email')
			credentails=ENV['LOGIN'].split(':')
			username.send_keys credentails[0]
			password=@@driver.find_element(:id, 'password')
			password.send_keys credentails[1]
			sleep(2)
			@@driver.find_element(:xpath, "//button[contains(.,'Sign in')]").click
			sleep 10
			@@driver.find_element(:link_text => 'Pay at the door').click
			sleep 5
			@@driver.find_element(:xpath, "//button[contains(.,'Place order')]").click
			sleep(15)
			puts 'checkout completed'
			@@driver.quit
		end
	end



	#thailand for customer profile
	def delivery_address
		add=Partay.get('http://shoponline.tescolotus.com/api/v1/Customer/', :headers => {'Content-Type' => 'application/json', 'language' => 'en-gb', 'region' => 'TH', 'userId' => access_token })
		response_address=JSON(add)
		self.address_info(JSON(response_address)["address"]["name"])
	end



	def address_info(user_name)
		user_name= user_name
		puts user_name
	end

	def empty_trolley
		response = Partay.delete('http://shoponline.tescolotus.com/api/v1/trolley/items', :headers => {'Content-Type' => 'application/json','language' => 'en-gb', 'region' => 'TH', 'userId' => access_token})
		# response = Partay.delete('http://eshop.tesco.com.my/api/v1/trolley/items', :headers => {'Content-Type' => 'application/json','language' => 'en-GB', 'region' => 'MY', 'userId' => access_token, 'Host' => 'r.tesco.com.my'})
		puts response
	end


	def check_out_ops
		begin
			puts 'opening the browser'
			@@driver = Selenium::WebDriver.for :safari
			@@driver.navigate.to https "://uat-tesco-avocado-ops.usdk.net/mt/secure.tesco.com/register/default.aspx?from=https%3a%2f%2fsecure.tesco.com%2fgroceries%2fcheckout%2fdefault.aspx%3freviewed%3dno&un_jtt_application_platform=android"
			username = @@driver.find_element(:id, 'loginID')
			credentails=ENV['LOGIN'].split(':')
			username.clear
			username.send_keys credentails[0]
			password=@@driver.find_element(:id, 'password')
			password.clear
			password.send_keys credentails[1]
			sleep(2)
			@@driver.find_element(:id, 'un_bluebtn').click
			# wait for a specific element to show up
			wait = Selenium::WebDriver::Wait.new(:timeout => 60) # seconds
			wait.until { @@driver.find_element(:xpath, "//*[@id='checkout']/div[1]/div[1]/div[1]/div") }
			@@driver.find_element(:xpath, ".//*[@id='nextStage']").location_once_scrolled_into_view
			@@driver.find_element(:name, 'proceedToPayment').click
			wait = Selenium::WebDriver::Wait.new(:timeout => 60) # seconds
			wait.until { @@driver.find_element(:name => 'securityCode') }
			@@driver.find_element(:xpath, ".//*[@id='fOrder']/div/div[3]/div[1]/div/div[2]/div[1]/div[4]/div[2]/input").send_keys '123'
			@@driver.find_element(:xpath, ".//*[@id='fOrder']/div/div[4]").location_once_scrolled_into_view
			sleep(2)
			@@driver.find_element(:xpath, ".//*[@id='fOrder']/div/div[4]/input").click
			sleep(15)
			puts 'checkout completed'
			@@driver.quit
		rescue
			@@driver.quit
			puts 'in rescue block execution'
			puts 'opening the browser'
			driver = Selenium::WebDriver.for :safari
			driver.navigate.to "https://uat-tesco-avocado-ops.usdk.net/mt/secure.tesco.com/register/default.aspx?from=https%3a%2f%2fsecure.tesco.com%2fgroceries%2fcheckout%2fdefault.aspx%3freviewed%3dno&un_jtt_application_platform=android"
			username = @@driver.find_element(:id, 'loginID')
			credentails=ENV['LOGIN'].split(':')
			username.send_keys credentails[0]
			password=@@driver.find_element(:id, 'password')
			password.send_keys credentails[1]
			sleep(2)
			driver.find_element(:id, 'un_bluebtn').click
			# wait for a specific element to show up
			wait = Selenium::WebDriver::Wait.new(:timeout => 120) # seconds
			wait.until { @@driver.find_element(:xpath, "//*[@id='checkout']/div[1]/div[1]/div[1]/div") }
			driver.find_element(:xpath, ".//*[@id='nextStage']").location_once_scrolled_into_view
			driver.find_element(:name, 'proceedToPayment').click
			wait = Selenium::WebDriver::Wait.new(:timeout => 120) # seconds
			wait.until { @@driver.find_element(:name => 'securityCode') }
			driver.find_element(:xpath, ".//*[@id='fOrder']/div/div[3]/div[1]/div/div[2]/div[1]/div[4]/div[2]/input").send_keys '123'
			driver.find_element(:xpath, ".//*[@id='fOrder']/div/div[4]").location_once_scrolled_into_view
			sleep(2)
			driver.find_element(:xpath, ".//*[@id='fOrder']/div/div[4]/input").click
			sleep(15)
			puts 'checkout completed'
			driver.quit
		end
	end
    end


api=Partay.new
api.login_access
# api.check_out
puts api.access_token
