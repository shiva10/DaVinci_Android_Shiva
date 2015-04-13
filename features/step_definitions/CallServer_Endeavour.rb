# ruby -r "./CallServer.rb" -e "CallServer.new.valid_login" #Running this file

require "net/https"
require 'json'

class CallServer
    @token = ""
    
    @activationCode = ""

    def getToken
        @token
    end

    def getActivationCode
        @activationCode
    end

    def getVerificationCode
        @verificationcode
    end


	def http_ruby_object 
		uri = URI.parse("http://mobile.davinciansupport.com:8080")
		Net::HTTP.new(uri.host, uri.port)
	end

	def secure_http_ruby_object
		uri = URI.parse("https://mobile.davinciansupport.com:8443")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		http
	end

    def _requestactivationcode(http_ruby_object,userid)
    request = Net::HTTP::Post.new("/mvp/mobile-bridge/user/retrieveactivationcode/")
    request.add_field('Content-Type', 'application/json')
    request.add_field('Authorization', @token)
    request.body = '{"id":"' + userid + '"}'
    JSON.parse(http_ruby_object.request(request).body)
    end
    
    def requestActivationCode(username, password, os, deviceToken, userid)
    login(username, password, os, deviceToken)
    json = _requestactivationcode(secure_http_ruby_object, userid)
    #puts json ["msg"]
    @activationCode = json["data"]["resetUser"]["activationCode"]
    puts json ["data"]#["resetUser"]["activationCode"]
    end

    def _requestVerificationCode(http_ruby_object,userid)
    request = Net::HTTP::Post.new("/mvp/mobile-bridge/user/retrieveverificationcode/")
    request.add_field('Content-Type', 'application/json')
    request.add_field('Authorization', @token)
    request.body = '{"id":"' + userid + '"}'
    JSON.parse(http_ruby_object.request(request).body)
    end
    
    def requestVerificationCode(username, password, os, deviceToken, userid)
    login(username, password, os, deviceToken)
    json = _requestVerificationCode(secure_http_ruby_object, userid)
    @verificationcode = json["data"]["resetUser"]["verificationCode"]
    puts json ["data"]["resetUser"]["verificationCode"]
    end

    def _resetUser(http_ruby_object,userid)
    request = Net::HTTP::Post.new("/mvp/mobile-bridge/user/reset/")
    request.add_field('Content-Type', 'application/json')
    request.add_field('Authorization', @token)
    request.body = '{"id":"' + userid + '"}'
    JSON.parse(http_ruby_object.request(request).body)
    end
    
    def resetUser(username, password, os, deviceToken, userid)
    login(username, password, os, deviceToken)
    json = _resetUser(secure_http_ruby_object, userid)
    puts json ["msg"]
    end

	def _login(http_ruby_object, username, password, os, deviceToken)
		request = Net::HTTP::Post.new("/mvp/mobile-bridge/user/login/")
		request.add_field('Content-Type', 'application/json')
		request.body = '{"username":"' + username + '","password":"' + password + '","os":"' + os + '","deviceToken":"' + deviceToken + '"}'
		JSON.parse(http_ruby_object.request(request).body)
	end

    def login(username, password, os, deviceToken)
     # json = _login(secure_http_ruby_object, username, password, os, deviceToken)
     json = _login(http_ruby_object, "androiduser", "12345", "1", "0123456789ABCDEF") # Also works
    puts json["msg"]
    puts json["data"]["user"]["session"]["token"]
    @token = json["data"]["user"]["session"]["token"]
    end


    # api=CallServer.new
    # api.login("davuser", "12345", "1", "APA91bGwgzi0FaUz_JGsrqnU1mMb9FU8s4SxxTpxB8PIzFtL0Qzglm61JuyKCjw_8o6OfC1EA0Fd6k_PzU1S92Bf38mBJz3J9B_ttgA0uSqXjwasdrInX17HWrACs89cLUlxjOb_I2fdM0WQVzd8QA0YrR0g6Hzh3A")
    # puts api.getToken
end