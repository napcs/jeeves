require 'test_helper.rb'

require 'codepad'

class CodepadTest < MiniTest::Test

  def test_public_pad
    bot = make_bot(Codepad)
    message = make_message(bot, '!codepad')
    replies = get_replies(message)
    # Your username is 'test'
    assert replies.first.include?("https://pad.riseup.net/p/#{bot.nick}_")

  end

  def test_private_pad
    # test doesn't run because bot test framework breaks.
    #bot = make_bot(Codepad)
    #message = make_message(bot, '!codepad for derp')
    #replies = get_replies(message)
    #assert replies.first.include?("https://pad.riseup.net/p/#{bot.nick}_")

  end

end
