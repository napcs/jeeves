class Quotes
  include Cinch::Plugin

  $help_messages << "!quote  :  A random quote will be printed to the screen."
  $help_messages << "!quote <quote> : Add a quote to the list of quotes to be displayed. Quote must be properly attributed and must be at least 27 characters long. ex: The dude abides. - The Dude"

  match /quote(.*)/, method: :run_quotes

  def run_quotes(m, message = nil)
    quote_source = QuoteSource.new(message)
    QuoteDisplay.output(m, quote_source.quote)
  end
end

class QuoteSource
  attr_reader :quote

  ACCEPTABLE_QUOTE_LENGTH = 25
  QUOTE_ATTRIBUTION_FORMAT = " - "
  CHANNEL_OWNER_NICK = ":bphogan"
  PLUGIN_AUTHOR_NICK = ":amitchellbullard"
  QUOTES_FILE = "config/quotes/quotes.txt"
  DEFAULT_QUOTE = "Whether you are designing systems or individual modules, never forget to use the simplest thing that can possibly work. - Robert C. Martin"
  QUOTE_FILE_NOT_FOUND_MESSAGE = "Attention #{PLUGIN_AUTHOR_NICK} and #{CHANNEL_OWNER_NICK}: Unable to find the quotes file. Displaying default quote..."
  DEFAULT_MESSAGE = "#{QUOTE_FILE_NOT_FOUND_MESSAGE}\n#{DEFAULT_QUOTE}"

  def initialize(quote)
    quote = regularize_whitespace(quote)
    @quote = quote_is_invalid(quote) ? random_quote : add_quote(quote)
  end

  private

  def random_quote
    File.exists?(QUOTES_FILE) ? IO.readlines(QUOTES_FILE).shuffle.first : DEFAULT_MESSAGE
  end

  def add_quote(quote)
    file = File.exists?(QUOTES_FILE) ? File.open(QUOTES_FILE, "a") {|file| file.puts quote} : DEFAULT_MESSAGE
  end

  def regularize_whitespace(quote)
    quote.strip.squeeze(" ") unless quote.nil?
  end

  def quote_is_invalid(quote)
    quote.nil? || quote.empty? || quote.length < ACCEPTABLE_QUOTE_LENGTH || !quote.include?(QUOTE_ATTRIBUTION_FORMAT)
  end
end

class QuoteDisplay
  class << self

    def output(m, quote)
      output = quote.nil? || quote.empty? ? "Quote added." : quote
      m.reply output
    end

  end
end