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

	def test_ninja
		WebMock.allow_net_connect!
		bot = make_bot(Dictionary)
    	message = make_message(bot, '!define ninja')
    	replies = get_replies(message)
    	assert_equal "A member of a class of 14th-century Japanese mercenary agents who were trained in the martial arts and hired for covert operations such as assassination and sabotage.", replies.first
	end

	def test_tardis
		WebMock.allow_net_connect!
		bot = make_bot(Dictionary)
		message = make_message(bot, '!define tardis')
		replies = get_replies(message)
		assert_equal "I don't seem to be able to grab the word for you. Please check your spelling and try again. Error: undefined method `[]' for nil:NilClass.", replies.first
	end

	def test_tattoo
		WebMock.allow_net_connect!
		bot = make_bot(Dictionary)
    	message = make_message(bot, '!define tattoo')
    	replies = get_replies(message)
    	assert_equal "A signal sounded on a drum or bugle to summon soldiers or sailors to their quarters at night.", replies.first
	end

end