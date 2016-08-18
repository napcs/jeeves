require 'test_helper.rb'
require 'expressions'

class ExpressionsTest < MiniTest::Test

  def test_tableflip
    bot = make_bot(Expressions)
    message = make_message(bot, '!tableflip')
    replies = get_replies(message)
    assert_equal "(╯°□°）╯︵ ┻━┻", replies.first
  end

  def test_wut
    bot = make_bot(Expressions)
    message = make_message(bot, '!wut')
    replies = get_replies(message)
    assert_equal "ಠ_ಠ", replies.first
  end

  def test_yeaaah
    bot = make_bot(Expressions)
    message = make_message(bot, '!yeaaah')
    replies = get_replies(message)
    assert_equal "( •_•) ( •_•)>⌐■-■ (⌐■_■)", replies.first
  end


end
