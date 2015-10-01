# Include the test setup:
require 'test_helper.rb'

# include the plugin you are testing
require 'word_of_the_day'

# Define the test class
class WordOfTheDayTest < MiniTest::Test

	def test_word_of_the_day_real_request
		WebMock.allow_net_connect!
		bot = make_bot(WordOfTheDay)
    	message = make_message(bot, '!wotd')
    	replies = get_replies(message)
    	assert_match /Today's word: (.*) \((.*)\): (.*)/, replies.first
	end

end