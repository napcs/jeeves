# Include the test setup:
require 'test_helper.rb'

# include the plugin you are testing
require 'hello'

# Define the test class
class HelloTest < MiniTest::Test

  # Define your first test case.
  def test_hello_greets_messenger

    # The !hello command responds to the person issuing the command
    # with "Hi there, {username}!"

    # Create a bot. Pass the class name of your plugin
    bot = make_bot(Hello)

    # Send the bot a message
    message = make_message(bot, '!hello')

    # Get the response
    replies = get_replies(message)

    # now do your assertion
    # Your username is 'test'
    assert_equal "Hi there, test!", replies.first

  end

  def test_greetings_greets_specified_user
    # The !greetings [nick] command
    # responds with "Hi there, [nick]!"

    bot = make_bot(Hello)
    message = make_message(bot, '!greetings homer')
    replies = get_replies(message)
    assert_equal "Hi there, homer!", replies.first
  end

end
