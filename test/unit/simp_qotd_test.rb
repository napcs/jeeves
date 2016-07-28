require 'test_helper.rb'
require 'simp_qotd'

class SimpQotdTest < MiniTest::Test

  def test_link_is_returned
    WebMock.allow_net_connect!
    bot = make_bot(SimpQotd)
    message = make_message(bot, "!simp_quote")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("https://pbs.twimg.com/")
  end

  def test_image_exists_in_link
    WebMock.allow_net_connect!
    bot = make_bot(SimpQotd)
    message = make_message(bot, "!simp_quote")
    replies = get_replies(message)
    output = get_replies(message).first
    assert_match(/jpg|jpeg|png|gif/, output)
  end
end