# Include the test setup:
require 'test_helper.rb'

# include the plugin you are testing
require 'meme_generator'

# Define the test class
class MemeGeneratorTest < MiniTest::Test

  def test_all_the_things
    m = MemeGenerator.new
    string = "!X ALL the ys"

    MemeGenerator::REGEX_ALL_THE.match(string)
    line1 = $1
    line2 = $2
    result = MemeGenerator.new.meme_all_the(line1, line2)

    assert_equal "http://apimeme.com/meme?meme=X+All+The+Y&top=X&bottom=ALL+the+ys", result
  end

  def test_I_dont_always
    string = "!I don't always test code, but when I do, it's in production"
    MemeGenerator::REGEX_I_DONT_ALWAYS.match(string)
    line1 = $1
    line2 = $2
    result = MemeGenerator.new.meme_i_dont_always(line1, line2)
    assert_equal "http://apimeme.com/meme?meme=The+Most+Interesting+Man+In+The+World&top=I+don%27t+always+test+code%2C&bottom=but+when+I+do%2C+it%27s+in+production", result

    string = "!I don't always test code but when I do it's in production"
    MemeGenerator::REGEX_I_DONT_ALWAYS.match(string)
    line1 = $1
    line2 = $2
    result = MemeGenerator.new.meme_i_dont_always(line1, line2)

    assert_equal "http://apimeme.com/meme?meme=The+Most+Interesting+Man+In+The+World&top=I+don%27t+always+test+code&bottom=but+when+I+do+it%27s+in+production", result
  end

  def test_bad_time
    string = "!If you add two integers before converting them to numbers, you're going to have a bad time"
    MemeGenerator::REGEX_BAD_TIME.match(string)
    line1 = $1
    result = MemeGenerator.new.meme_bad_time(line1)
    assert_equal "http://apimeme.com/meme?meme=Super+Cool+Ski+Instructor&top=If+you+add+two+integers+before+converting+them+to+numbers%2C&bottom=you%27re+going+to+have+a+bad+time", result
  end

  def test_not_sure
    string = "!not sure if drunk or sober"
    MemeGenerator::REGEX_NOT_SURE_IF.match(string)
    line1 = $1
    line2 = $2
    result =  MemeGenerator.new.meme_not_sure(line1, line2)
    assert_equal "http://apimeme.com/meme?meme=Futurama+Fry&top=not+sure+if+drunk&bottom=or+sober", result
  end

  def test_shut_up
    _string = '!shut up and take my money'
    result = MemeGenerator.new.meme_shut_up
    assert_equal "http://apimeme.com/meme?meme=Shut+Up+And+Take+My+Money+Fry&top=SHUT+UP+AND&bottom=TAKE+MY+MONEY%21", result
  end

  def test_success
    string = "!Tests pass. SUCCESS!"
    MemeGenerator::REGEX_SUCCESS.match(string)
    line1 = $1
    line2 = $2
    result = MemeGenerator.new.meme_success(line1, line2)
    assert_equal "http://apimeme.com/meme?meme=Success+Kid&top=Tests+pass.+&bottom=SUCCESS%21", result
  end

  def test_this_is
    string = '!THIS IS DEVOPS!'

    MemeGenerator::REGEX_THIS_IS.match(string)
    line2 = $1
    result = MemeGenerator.new.meme_this_is(line2)
    assert_equal "http://apimeme.com/meme?meme=Sparta+Leonidas&top=THIS+IS&bottom=DEVOPS%21", result
  end

  def test_one_does_not_simply
    string = "!one does not simply deploy servers"
    MemeGenerator::REGEX_SIMPLY.match(string)
    line2 = $1
    result = MemeGenerator.new.meme_simply(line2)
    assert_equal "http://apimeme.com/meme?meme=One+Does+Not+Simply&top=One+does+not+simply&bottom=deploy+servers", result
  end

  def test_what_if_i
    string = "!What if I told you none of this is real?"

    MemeGenerator::REGEX_WHAT_IF_I.match(string)
    line2 = $1
    result = MemeGenerator.new.meme_what_if_i(line2)
    assert_equal "http://apimeme.com/meme?meme=Matrix+Morpheus&top=What+if+I+told+you&bottom=none+of+this+is+real%3F", result
  end

  def test_wonka
    string = "!Oh, you play Call Of Duty? Tell me more about modern warfare."
    MemeGenerator::REGEX_WONKA.match(string)
    line1 = $1
    line2 = $2
    result = MemeGenerator.new.meme_wonka(line1, line2)
    assert_equal "http://apimeme.com/meme?meme=Condescending+Wonka&top=Oh%2C+you+play+Call+Of+Duty%3F&bottom=Tell+me+more+about+modern+warfare.", result
  end

  def test_y_u_no
    string = '!Y U NO WRITE TESTS?'
    MemeGenerator::REGEX_Y_U_NO.match(string)
    line2 = $1
    result =  MemeGenerator.new.meme_y_u_no(line2)
    assert_equal "http://apimeme.com/meme?meme=Y+U+No&top=Y+U+NO&bottom=WRITE+TESTS%3F", result
  end

  def test_yo_dawg
    string = "!Yo dawg, I heard you like terminals so I put a terminal in your terminal so you can terminal while you terminal."

    MemeGenerator::REGEX_YO_DAWG.match(string)
    line1 = $1
    line2 = $2
    result = MemeGenerator.new.meme_yo_dawg(line1, line2)
    assert_equal "http://apimeme.com/meme?meme=Yo+Dawg+Heard+You&top=Yo+dawg%2C+I+heard+you+like+terminals&bottom=so+I+put+a+terminal+in+your+terminal+so+you+can+terminal+while+you+terminal.", result
  end

  def test_you_are_bad
    _string = "!You are bad and you should feel bad!"
    result = MemeGenerator.new.meme_you_are_bad
    assert_equal "http://apimeme.com/meme?meme=You+Should+Feel+Bad+Zoidberg&top=You+are+bad&bottom=and+you+should+feel+bad%21", result
  end

end
