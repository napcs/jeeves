require 'test_helper.rb'
require 'expressions'

class ExpressionsTest < MiniTest::Test

  def test_tableflip
    assert_equal "(╯°□°）╯︵ ┻━┻", Expressions.new.tableflip
  end

  def test_wut
    assert_equal "ಠ_ಠ", Expressions.new.wut
  end

  def test_yeaaah
    assert_equal "( •_•) ( •_•)>⌐■-■ (⌐■_■)", Expressions.new.yeaaah
  end


end
