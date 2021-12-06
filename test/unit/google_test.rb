require 'test_helper.rb'

require 'google'

class GoogleTest < MiniTest::Test

  def test_search_for_os
    WebMock.allow_net_connect!

    query = "what is an operating system?"
    result = GoogleSearch.new(query).search
    assert result.downcase.include?("operating system")
    assert result.include?(" (http")
  end
end
