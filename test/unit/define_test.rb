require 'test_helper'
require 'define'

class DefineTest < MiniTest::Test
  
  def test_meaning_of_tree
    WebMock.allow_net_connect!
    bot = make_bot(Define)
    message = make_message(bot, "!define defenestrate")
    replies = get_replies(message)
    assert_equal "To throw out of a window.", replies.first.to_s
  end

  def test_invalid_word
    WebMock.allow_net_connect!
    bot = make_bot(Define)
    message = make_message(bot, "!define Beerisaur")
    replies = get_replies(message)
    assert_equal "Error", replies.first
  end

  def test_too_many_words
    WebMock.allow_net_connect!
    bot = make_bot(Define)
    message = make_message(bot, "!define ruby rocks")
    replies = get_replies(message)
    assert_equal "Argument Error", replies.first
  end
end
