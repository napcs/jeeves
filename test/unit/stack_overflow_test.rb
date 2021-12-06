require 'test_helper.rb'
require 'stack_overflow'

class StackOverflowTest < MiniTest::Test

	def test_sodd_request
		WebMock.allow_net_connect!
    	result = StackOverflow.new.get_answer("Elixir strings")
      assert_match /(.*) - https:\/\/stackoverflow.com(.*)/, result
	end

end
