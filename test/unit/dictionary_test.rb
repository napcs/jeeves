# Include the test setup:
require 'test_helper.rb'

# include the plugin you are testing
require 'dictionary'

# Define the test class
class DictionaryTest < MiniTest::Test

	def test_assassin
		WebMock.allow_net_connect!
		bot = make_bot(Dictionary)
    	message = make_message(bot, '!define assassin')
    	replies = get_replies(message)
    	assert_equal "One who murders by surprise attack, especially one who carries out a plot to kill a prominent person.", replies.first
	end

end