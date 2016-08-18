require 'test_helper.rb'
require 'lmgtfy'

class LmgtfyTest < MiniTest::Test
  def test_search_for_amazon_echo
    WebMock.allow_net_connect!
    bot = make_bot(Lmgtfy)
    message = make_message(bot, '!lmgtfy amazon echo')
    replies = get_replies(message)
    assert_equals("http://lmgtfy.com/?q=amazon+echo")
  end

  def test_search_for_commercial_at
    WebMock.allow_net_connect!
    bot = make_bot(Lmgtfy)
    message = make_mesage(bot, '!lmgtfy @')
    replies = get_replies(message)
    assert_equals("http://lmgtfy.com/?q=%40")
  end

  def test_search_for_m_ampersand_m
    WebMock.allow_net_connect!
    bot = make_bot(Lmgtfy)
    message = make_message(bot, '!lmgtfy M&M')
    replies = get_replies(message)
    assert_equals("http://lmgtfy.com/?q=M%26M")
  end

end
