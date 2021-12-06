# Include the test setup:
require 'test_helper.rb'

# include the plugin you are testing
require 'word_of_the_day'

# Define the test class
class WordOfTheDayTest < MiniTest::Test

	def test_word_of_the_day_real_request
    WebMock.allow_net_connect!
    w = WordOfTheDay.fetch
    message = w.to_s
    assert_match /Today's word: (.*) \((.*)\): (.*)/, message
	end

end
