# Include the test setup:
require 'test_helper.rb'

# include the plugin you are testing
require 'meme_generator'

# Define the test class
class MemeGeneratorTest < MiniTest::Test

  # Define your first test case.
  def test_all_the_things
    bot = make_bot(MemeGenerator)
    message = make_message(bot, "!X ALL the ys")
    replies = get_replies(message)
    assert_equal "http://apimeme.com/meme?meme=X+All+The+Y&top=X&bottom=ALL+the+ys", replies.first
  end

  def test_I_dont_always
    bot = make_bot(MemeGenerator)
    message = make_message(bot, "!I don't always test code, but when I do, it's in production")
    replies = get_replies(message)
    assert_equal "http://apimeme.com/meme?meme=The+Most+Interesting+Man+In+The+World&top=I+don%27t+always+test+code%2C&bottom=but+when+I+do%2C+it%27s+in+production", replies.first

    message = make_message(bot, "!I don't always test code but when I do it's in production")
    replies = get_replies(message)

    assert_equal "http://apimeme.com/meme?meme=The+Most+Interesting+Man+In+The+World&top=I+don%27t+always+test+code&bottom=but+when+I+do+it%27s+in+production", replies.first
  end

  def test_bad_time
    bot = make_bot(MemeGenerator)
    message = make_message(bot, "!If you add two integers before converting them to numbers, you're going to have a bad time")
    replies = get_replies(message)
    assert_equal "http://apimeme.com/meme?meme=Super+Cool+Ski+Instructor&top=If+you+add+two+integers+before+converting+them+to+numbers%2C&bottom=you%27re+going+to+have+a+bad+time", replies.first
  end

  def test_not_sure
    bot = make_bot(MemeGenerator)
    message = make_message(bot, "!not sure if drunk or sober")
    replies = get_replies(message)
    assert_equal "http://apimeme.com/meme?meme=Futurama+Fry&top=not+sure+if+drunk&bottom=or+sober", replies.first
  end

  def test_shut_up
    bot = make_bot(MemeGenerator)
    message = make_message(bot, '!shut up and take my money')
    replies = get_replies(message)
    assert_equal "http://apimeme.com/meme?meme=Shut+Up+And+Take+My+Money+Fry&top=SHUT+UP+AND&bottom=TAKE+MY+MONEY%21", replies.first
  end

  def test_success
    bot = make_bot(MemeGenerator)
    message = make_message(bot, "!Tests pass. SUCCESS!")
    replies = get_replies(message)
    assert_equal "http://apimeme.com/meme?meme=Success+Kid&top=Tests+pass.+&bottom=SUCCESS%21", replies.first
  end

  def test_this_is
    bot = make_bot(MemeGenerator)
    message = make_message(bot, '!THIS IS OS!')
    replies = get_replies(message)
    assert_equal "http://apimeme.com/meme?meme=Sparta+Leonidas&top=THIS+IS&bottom=OS%21", replies.first
  end

  def test_what_if_i
    bot = make_bot(MemeGenerator)
    message = make_message(bot, "!What if I told you none of this is real?")
    replies = get_replies(message)
    assert_equal "http://apimeme.com/meme?meme=Matrix+Morpheus&top=What+if+I+told+you&bottom=none+of+this+is+real%3F", replies.first
  end

  def test_wonka
    bot = make_bot(MemeGenerator)
    message = make_message(bot, "!Oh, you play Call Of Duty? Tell me more about modern warfare.")
    replies = get_replies(message)
    assert_equal "http://apimeme.com/meme?meme=Condescending+Wonka&top=Oh%2C+you+play+Call+Of+Duty%3F&bottom=Tell+me+more+about+modern+warfare.", replies.first
  end

  def test_y_u_no
    bot = make_bot(MemeGenerator)
    message = make_message(bot, '!Y U NO WRITE TESTS?')
    replies = get_replies(message)
    assert_equal "http://apimeme.com/meme?meme=Y+U+No&top=Y+U+NO&bottom=WRITE+TESTS%3F", replies.first
  end

  def test_yo_dawg
    bot = make_bot(MemeGenerator)
    message = make_message(bot, "!Yo dawg, I heard you like terminals so I put a terminal in your terminal so you can terminal while you terminal.")
    replies = get_replies(message)
    assert_equal "http://apimeme.com/meme?meme=Yo+Dawg+Heard+You&top=Yo+dawg%2C+I+heard+you+like+terminals&bottom=so+I+put+a+terminal+in+your+terminal+so+you+can+terminal+while+you+terminal.", replies.first
  end

  def test_you_are_bad
    bot = make_bot(MemeGenerator)
    message = make_message(bot, "!You are bad and you should feel bad!")
    replies = get_replies(message)
    assert_equal "http://apimeme.com/meme?meme=You+Should+Feel+Bad+Zoidberg&top=You+are+bad&bottom=and+you+should+feel+bad%21", replies.first
  end

end
