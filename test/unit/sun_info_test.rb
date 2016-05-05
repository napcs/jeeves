require 'test_helper.rb'
require 'sun_info'

class SunInfoTest < MiniTest::Test

  def test_sunrise_returns_am
    bot = make_bot(SunInfo)
    message = make_message(bot, "!sun_info usa, chicago")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("AM and")
  end

  def test_sunset_returns_pm
    bot = make_bot(SunInfo)
    message = make_message(bot, "!sun_info usa, chicago")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("PM,")
  end

  def test_duration_returns_hours
    bot = make_bot(SunInfo)
    message = make_message(bot, "!sun_info usa, chicago")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("hours")
  end

  def test_duration_returns_minutes
    bot = make_bot(SunInfo)
    message = make_message(bot, "!sun_info usa, chicago")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("minutes")
  end

  def test_sun_info_returns_two_word_country
    bot = make_bot(SunInfo)
    message = make_message(bot, "!sun_info saudi arabia, riyadh")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("saudi arabia")
  end

  def test_sun_info_returns_two_word_city
    bot = make_bot(SunInfo)
    message = make_message(bot, "!sun_info usa, eau claire")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("eau claire")
  end

  def test_sun_info_returns_two_word_country_and_city
    bot = make_bot(SunInfo)
    message = make_message(bot, "!sun_info saudi arabia, khamis mushait")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("khamis mushait, saudi arabia")
  end	

end
