class Quotes
  include Cinch::Plugin

  $help_messages << "!quote  :  A random quote will be printed to the screen."
  $help_messages << "!quote <quote> : Add a quote to the list of quotes to be displayed. Quote must be properly attributed and must be at least 27 characters long. ex: The dude abides. - The Dude"

  match /quote(.*)/, method: :run_quotes

  def run_quotes(m, message = nil)
    quote_source = QuoteSource.new(message)
    output(m, quote_source.quote)
  end

  private

  def output(m, quote)
    output = quote.nil? || quote.empty? ? "Quote added." : quote
    m.reply output
  end
end

class QuoteSource
  attr_reader :quote

  QUOTES_FILE = "config/quotes/quotes.txt"
  QUOTE_FILE_ERROR = "amitchellbullard: Unable to load the quotes file."
  ACCEPTABLE_QUOTE_LENGTH = 25
  QUOTE_ATTRIBUTION_FORMAT = " - "

  def initialize(quote)
    quote = regularize_whitespace(quote)
    @quote = quote_is_invalid(quote) ? random_quote : add_quote(quote)
  end

  private

  def random_quote
    return QUOTE_FILE_ERROR unless File.exists?(QUOTES_FILE)
    IO.readlines(QUOTES_FILE).shuffle.first
  end

  def add_quote(quote)
    File.open(QUOTES_FILE, "a") {|file| file.puts quote}
  end

  def regularize_whitespace(quote)
    quote.strip.squeeze(" ") unless quote.nil?
  end

  def quote_is_invalid(quote)
    quote.nil? || quote.empty? || quote.length < ACCEPTABLE_QUOTE_LENGTH || !quote.include?(QUOTE_ATTRIBUTION_FORMAT)
  end
end
