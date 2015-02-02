class QuoteSource
  attr_reader :quote

  ATTRIBUTION_FORMAT = ' - '
  ACCEPTABLE_LENGTH = 'The Dude abides. - The Dude'.length
  QUOTES_FILE = 'plugins/quotes/resources/quotes.txt'
  QUOTES = IO.readlines(QUOTES_FILE)

  def initialize(quote)
    quote = regularize_whitespace(quote)
    @quote = quote_is_invalid(quote) ? random_quote : add_quote(quote)
  end

  private

  def random_quote
    QUOTES[rand(QUOTES.length) - 1]
  end

  def add_quote(quote)
    file = File.open(QUOTES_FILE, 'a') {|file| file.puts quote}
  end

  def regularize_whitespace(quote)
    quote.strip.squeeze(' ') unless quote.nil?
  end

  def quote_is_invalid(quote)
    quote.nil? || quote.empty? || quote.length < ACCEPTABLE_LENGTH || !quote.include?(ATTRIBUTION_FORMAT)
  end
end
