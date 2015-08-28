require 'test_helper.rb'

require 'google'

class GoogleTest < MiniTest::Test

  def test_search_for_os
    WebMock.allow_net_connect!
    bot = make_bot(Google)
    message = make_message(bot, '!google what is an operating system?')
    replies = get_replies(message)
    assert replies.first.include?("An operating system")
    assert replies.first.include?(" (http")
  end
end
