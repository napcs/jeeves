require 'test_helper.rb'
require 'lmgtfy'

class LmgtfyTest < MiniTest::Test
  def test_search_for_amazon_echo
    l = Lmgtfy.new
    result = l.run('amazon echo')
    assert_equal "http://lmgtfy.com/?q=amazon+echo", result
  end

  def test_search_for_commercial_at
    l = Lmgtfy.new
    result =  l.run('@')
    assert_equal"http://lmgtfy.com/?q=%40", result
  end

  def test_search_for_m_ampersand_m
    l = Lmgtfy.new
    result = l.run('M&M')
    assert_equal "http://lmgtfy.com/?q=M%26M", result
  end

end
