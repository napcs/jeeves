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

  def quote_file_does_not_exists
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
    quote = quote.strip.squeeze(' ') unless quote.nil?
    move_test_quotes_out

    assert !quote.nil? && !quote.empty? && quote.length > 24 && quote.include?(' - ')
  end

  def test_quote_addition_message_is_displayed
    move_test_quotes_in
    bot = make_bot(Quotes)
    message = make_message(bot, "!quote The Dude abides - Jeffery Lebowski.")
    replies = get_replies(message)
    move_test_quotes_out

    assert_equal "Quote added.", replies.first
  end

  def test_default_message_is_displayed_when_unable_to_read_quotes
    plugin_author_nick = ":amitchellbullard"
    channel_owner_nick = ":bphogan"
    default_quote = "Whether you are designing systems or individual modules, never forget to use the simplest thing that can possibly work. - Robert C. Martin"
    quote_file_not_found_message = "Attention #{plugin_author_nick} and #{channel_owner_nick}: Unable to find the quotes file. Displaying default quote..."
    default_message = "#{quote_file_not_found_message}\n#{default_quote}"

    quote_file_does_not_exists
    bot = make_bot(Quotes)
    message = make_message(bot, "!quote")
    default = get_replies(message).first
    default = default.strip.squeeze(' ') unless default.nil?
    quote_file_exists

    assert_equal default, default_message
  end

  def test_default_message_is_displayed_when_unable_to_write_quotes
    plugin_author_nick = ":amitchellbullard"
    channel_owner_nick = ":bphogan"
    default_quote = "Whether you are designing systems or individual modules, never forget to use the simplest thing that can possibly work. - Robert C. Martin"
    quote_file_not_found_message = "Attention #{plugin_author_nick} and #{channel_owner_nick}: Unable to find the quotes file. Displaying default quote..."
    default_message = "#{quote_file_not_found_message}\n#{default_quote}"

    quote_file_does_not_exists
    bot = make_bot(Quotes)
    message = make_message(bot, "!quote The Dude abides - Jeffery Lebowski.")
    default = get_replies(message).first
    default = default.strip.squeeze(' ') unless default.nil?
    quote_file_exists

    assert_equal default, default_message
  end

  def test_all_quotes_are_valid
    IO.readlines("config/quotes/quotes.txt").each do |quote|
      assert !quote.nil? && !quote.empty? && quote.length > 24 && quote.include?(' - ')
    end
  end

end

