require "test_helper.rb"
require "quotes"

class QuotesTest < MiniTest::Test
  def move_test_quotes_in
    FileUtils.mv("config/quotes/quotes.txt", "config/quotes/test_resources/quotes.txt")
    FileUtils.mv("config/quotes/test_resources/test_quotes.txt", "config/quotes/quotes.txt")
  end

  def move_test_quotes_out
    FileUtils.mv("config/quotes/quotes.txt", "config/quotes/test_resources/test_quotes.txt")
    FileUtils.mv("config/quotes/test_resources/quotes.txt", "config/quotes/quotes.txt")
  end

  def quote_file_does_not_exist
    FileUtils.mv("config/quotes/quotes.txt", "config/quotes/test_resources/quotes.txt")
  end

  def quote_file_exists
    FileUtils.mv("config/quotes/test_resources/quotes.txt", "config/quotes/quotes.txt")
  end

  def test_quote_is_returned
    move_test_quotes_in
    bot = make_bot(Quotes)
    message = make_message(bot, "!quote")
    quote = get_replies(message).first
    move_test_quotes_out

    assert !quote.nil? && !quote.empty? && quote.length > 24 && quote.include?(' - ') && !quote.include?("Attention :amitchellbullard")
  end

  def test_quote_addition_message_is_displayed
    move_test_quotes_in
    bot = make_bot(Quotes)
    message = make_message(bot, "!quote The Dude abides - Jeffery Lebowski.")
    replies = get_replies(message)
    move_test_quotes_out

    assert_equal "Quote added.", replies.first
  end

  def test_error_message_is_displayed_when_unable_to_read_quotes
    quote_file_does_not_exist
    bot = make_bot(Quotes)
    message = make_message(bot, "!quote")
    output = get_replies(message).first
    quote_file_exists

    assert output.include?("amitchellbullard: Unable to load the quotes file.")
  end

  def test_error_message_is_displayed_when_unable_to_write_quotes_file
    quote_file_does_not_exist
    bot = make_bot(Quotes)
    message = make_message(bot, "!quote The Dude abides - Jeffery Lebowski.")
    output = get_replies(message).first
    quote_file_exists

    assert output.include?("amitchellbullard: Unable to load the quotes file.")
  end

  def test_all_quotes_are_valid
    IO.readlines("config/quotes/quotes.txt").each do |quote|
      assert !quote.nil? && !quote.empty? && quote.length > 24 && quote.include?(' - ')
    end
  end

end
