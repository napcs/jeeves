require 'test_helper.rb'
require 'stack_overflow'

class StackOverflowTest < MiniTest::Test

	def test_word_of_the_day_real_request
		WebMock.allow_net_connect!
		bot = make_bot(StackOverflow)
    	message = make_message(bot, '!sodd Elixir strings')
    	replies = get_replies(message)
      assert_match /(.*) - http:\/\/stackoverflow.com(.*)/, replies.first
	end

end
