require File.dirname(__FILE__) + '/../../features/support/helpers'
class BasePage
  include Tesco
  def trait
    raise "You should define a trait method or a title method" unless respond_to?(:title)
    "* marked:'#{self.title}'"
  end



  def embed(*args)
    puts "Embed is a Cucumber method and is not available in this console."
  end
end