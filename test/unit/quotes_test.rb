require 'test_helper.rb'
require 'quotes'

class QuotesTest < MiniTest::Test
  def move_test_quotes_in
    FileUtils.mv('plugins/quotes/resources/quotes.txt', 'plugins/quotes/resources/tmp/quotes.txt')
    FileUtils.mv('plugins/quotes/resources/quotes_test.txt', 'plugins/quotes/resources/quotes.txt')
  end

  def move_test_quotes_out
    FileUtils.mv('plugins/quotes/resources/quotes.txt', 'plugins/quotes/resources/quotes_test.txt')
    FileUtils.mv('plugins/quotes/resources/tmp/quotes.txt', 'plugins/quotes/resources/quotes.txt')
  end

  def test_quote_is_returned
    move_test_quotes_in

    bot = make_bot(Quotes)
    message = make_message(bot, '!quote')
    quote = get_replies(message).first
    quote = quote.strip.squeeze(' ') unless quote.nil?

    move_test_quotes_out

    assert !quote.nil? && !quote.empty? && quote.length >= 'The Dude abides - Jeffery Lebowski.'.length && quote.include?(' - ')
  end

  def test_quote_addition_message_is_displayed
    move_test_quotes_in
    bot = make_bot(Quotes)
    message = make_message(bot, '!quote The Dude abides - Jeffery Lebowski.')
    replies = get_replies(message)
    move_test_quotes_out

    assert_equal 'Quote added.', replies.first
  end

  def test_all_quotes_are_valid
    IO.readlines('plugins/quotes/resources/quotes.txt').each do |quote|
      assert !quote.nil? && !quote.empty? && quote.length >= 'The Dude abides - Jeffery Lebowski.'.length && quote.include?(' - ')
    end
  end

end

