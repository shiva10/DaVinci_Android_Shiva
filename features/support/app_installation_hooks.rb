require 'calabash-android/management/app_installation'

AfterConfiguration do |config|
  FeatureNameMemory.feature_name = nil
end

Before('@reset,@reinstall') do |scenario|
  @scenario_is_outline = (scenario.class == Cucumber::Ast::OutlineTable::ExampleRow)
  if @scenario_is_outline
    scenario = scenario.scenario_outline
  end

=begin
	feature_name = scenario.feature.title
	if FeatureNameMemory.feature_name != feature_name \
      or ENV["RESET_BETWEEN_SCENARIOS"] == "1"
		if ENV["RESET_BETWEEN_SCENARIOS"] == "1"
			log "New scenario - reinstalling apps"
		else
			log "First scenario in feature - reinstalling apps"
		end

		uninstall_apps
		install_app(ENV["TEST_APP_PATH"])
		install_app(ENV["APP_PATH"])
		FeatureNameMemory.feature_name = feature_name
		FeatureNameMemory.invocation = 1
	else
		FeatureNameMemory.invocation += 1
	end
=end


  if scenario.source_tag_names.include? "@reinstall"

    reinstall_apps()
  end

  if scenario.source_tag_names.include? "@reset"

    clear_app_data()
  end
end

FeatureNameMemory = Class.new
class << FeatureNameMemory
  @feature_name = nil
  attr_accessor :feature_name, :invocation
end


=begin
at_exit do
	path= File.absolute_path("rerun.txt")
	path_execution_state=File.absolute_path("rerun_execution_state.txt")
	path_apk=File.absolute_path("com.tesco.grocery.view-Signed.apk")

	if File.readlines(path_execution_state).grep(/Testing/).size > 0 && File.exist?(path)
		#rewrite
		puts 'calabash-android run ' + path_apk + ' -p rerun LOGIN=nav2@shop.com:qwerty'
		text = File.read(path_execution_state)
		replace = text.gsub(/Testing/, "give a hell")
		File.open(path_execution_state, "w") {
				|file| file.puts replace
			file.close
		}
		#puts ('./calabash-android-parallel.sh ' + path_apk + ' nav2@shop.com:qwerty')
		system('calabash-android run ' + path_apk + ' -p rerun LOGIN=nav2@shop.com:qwerty')
		#system('./calabash-android-parallel.sh ' + path_apk + ' nav2@shop.com:qwerty')
	else
		text = File.read(path_execution_state)
		replace = text.gsub(/give a hell/, "Testing")
		File.open(path_execution_state, "w") {
				|file| file.puts replace
			file.close
		}
	end
=end

