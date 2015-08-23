# Include the test setup:
require 'test_helper.rb'

require 'greet_on_join'

class GreetOnJoinTest < MiniTest::Test

  def test_greets_on_join

    bot = make_bot(GreetOnJoin)

    # to trigger the damn join events, I need to send the channel a message
    # since the get_replies method needs a message object.
    message = make_message(bot, 'derp')

    # Get the response
    replies = get_replies(message, :join)

    # works
    assert replies.first.include?("test: Welcome")

  end

end
