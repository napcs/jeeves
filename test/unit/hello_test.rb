# Include the test setup:
require 'test_helper.rb'

# include the plugin you are testing
require 'hello'

# Define the test class
class HelloTest < MiniTest::Test

  # Define your first test case.
  def test_hello_greets_messenger

    assert_equal "Hi there, test!", Hello.new.say("test")

  end

end
