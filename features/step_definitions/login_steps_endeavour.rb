# Restfull Calls for Class Server

     Then (/^I login to davincian$/) do
     user = DAVINCIAN_ADMIN_CREDENTIALS
     instance = CallServer.new
     instance.login(user[:username], user[:password], user[:os], user[:deviceToken])
     puts instance.getToken()
     end
     
     Then (/^I check davincian token$/) do
     user = DAVINCIAN_ADMIN_CREDENTIALS
     instance = CallServer.new
     instance.login(user[:username], user[:password], user[:os], user[:deviceToken])
     puts instance.getToken()
     end

     Then (/^I get activation code$/) do
     user = DAVINCIAN_ADMIN_CREDENTIALS
     instance = CallServer.new
     instance.requestActivationCode(user[:username], user[:password], user[:os], user[:deviceToken], user[:userid])
     puts instance.getActivationCode()
     end

     Then (/^I get verification code$/) do
     user = DAVINCIAN_ADMIN_CREDENTIALS
     instance = CallServer.new
     instance.requestVerificationCode(user[:username], user[:password], user[:os], user[:deviceToken], user[:userid])
     puts instance.getVerificationCode()
     end

     Then (/^I reset the user$/) do
     user = DAVINCIAN_ADMIN_CREDENTIALS
     instance = CallServer.new
     instance.resetUser(user[:username], user[:password], user[:os], user[:deviceToken], user[:userid])
     end

     Then (/^I enter the activation code$/) do
     user = DAVINCIAN_ADMIN_CREDENTIALS
     instance = CallServer.new
     instance.requestActivationCode(user[:username], user[:password], user[:os], user[:deviceToken], user[:userid])
     puts instance.getActivationCode
     @current_page.enter_activation_code(instance.getActivationCode())
     end

     Then (/^I press the verification code$/) do
     user = DAVINCIAN_ADMIN_CREDENTIALS
     instance = CallServer.new
     instance.requestVerificationCode(user[:username], user[:password], user[:os], user[:deviceToken], user[:userid])
     puts instance.getVerificationCode()
     @current_page.enter_token_verification_code(instance.getVerificationCode())
     end


