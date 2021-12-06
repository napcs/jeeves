require 'test_helper.rb'
require 'sun_info'

class SunInfoTest < MiniTest::Test

  def setup
    WebMock.allow_net_connect!
  end

  def test_sunrise_returns_am
    output = SunInfo.new.run("usa", "chicago")
    assert output.include?("am")
  end

  def test_sunset_returns_pm
    output = SunInfo.new.run("usa", "chicago")
    assert output.include?("pm")
  end

  def test_duration_returns_hours
    output = SunInfo.new.run("usa", "chicago")
    assert output.include?("hours")
  end

  def test_duration_returns_minutes
    output = SunInfo.new.run("usa", "chicago")
    assert output.include?("minutes")
  end

  def test_sun_info_returns_two_word_country
    output = SunInfo.new.run("saudi arabia", "riyadh")
    assert output.include?("saudi arabia")
  end

  def test_sun_info_returns_two_word_city
    output = SunInfo.new.run("usa", "eau claire")
    assert output.include?("eau claire")
  end

  def test_sun_info_returns_two_word_country_and_city
    output = SunInfo.new.run("saudi arabia", "khamis mushait")
    assert output.include?("khamis mushait, saudi arabia")
  end

end
