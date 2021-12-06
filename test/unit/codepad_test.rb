require 'test_helper.rb'

require 'codepad'

class CodepadTest < MiniTest::Test

  def test_create_pad
    prefix = "test_bot"
    assert Pad.new(prefix).url.include? "https://pad.riseup.net/p/#{prefix}_"
  end


end
