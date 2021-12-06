require "test_helper.rb"
require "quotes"

class QuotesTest < MiniTest::Test
  PATH = "test/test_resources/test_quotes.txt"

  def setup
    File.open(PATH, "w") { |file| file.write ("The Dude abides - Jeffery Lebowski") }
  end


  def test_quote_is_returned
    quotes = Quotes.new(PATH)
    quote = quotes.run
    assert quote
  end

  def test_quote_addition_message_is_displayed
    string = "Me fail English? That's unpossible! - Ralph Wiggum"
    quotes = Quotes.new(PATH)

    output = quotes.run(string)
    assert_equal "Quote added.", output
  end


  def test_error_message_is_displayed_when_unable_to_write_quotes_file
    quotes = Quotes.new("foo.txt")
    output = quotes.run "The Dude abides - Jeffery Lebowski"

    assert_equal("Unable to load the quotes file.", output)
  end


end
