# Include the test setup:
require 'test_helper.rb'

# include the plugin you are testing
require 'grammar_nazi'

# Define the test class
class GrammarNaziTest < MiniTest::Test

  # Define your first test case.
  def test_shouldve

    # Create a bot. Pass the class name of your plugin
    bot = make_bot(GrammarNazi)

    # Send the bot a message
    message = make_message(bot, 'You shouldve come over')

    # Get the response
    replies = get_replies(message)

    # now do your assertion
    # Your username is 'test'
    assert_equal "It's \"should have\", you idiot!", replies.first

  end

  def test_sneak_peak

    # Create a bot. Pass the class name of your plugin
    bot = make_bot(GrammarNazi)

    # Send the bot a message
    message = make_message(bot, 'Sneak peak')

    # Get the response
    replies = get_replies(message)

    # now do your assertion
    # Your username is 'test'
    assert_equal "Sneak PEEK!", replies.first

  end

  def test_couldve

    # Create a bot. Pass the class name of your plugin
    bot = make_bot(GrammarNazi)

    # Send the bot a message
    message = make_message(bot, 'couldve')

    # Get the response
    replies = get_replies(message)

    # now do your assertion
    # Your username is 'test'
    assert_equal "Could HAVE moron!", replies.first

  end


end
