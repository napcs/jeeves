class Quotes
  include Cinch::Plugin

  $help_messages << "!quote  :  A random quote will be printed to the screen."
  $help_messages << "!quote <quote> : Add a quote to the list of quotes to be displayed. Quote must be properly attributed and must be at least 27 characters long. ex: The dude abides. - The Dude"

  match /quote(.*)/, method: :run_quotes_plugin

  QUOTES_FILE_PATH = "config/quotes/quotes.txt"
  QUOTE_FILE_ERROR = "Unable to load the quotes file."

  def run_quotes_plugin(m, message)
    reply = File.exists?(QUOTES_FILE_PATH) ? get_reply( regularize_whitespace(message) ) : QUOTE_FILE_ERROR
    output(m, reply)
  end

  private

  def get_reply(message)
    is_invalid_quote(message) ? random_quote : add_quote(message)
  end

  def random_quote
    IO.readlines(QUOTES_FILE_PATH).shuffle.first
  end

  def add_quote(quote)
    File.open(QUOTES_FILE_PATH, "a") {|file| file.puts quote}
    "Quote added."
  end

  def is_invalid_quote(quote)
    quote.nil? || quote.empty? || quote.length < 25 || !quote.include?(" - ")
  end

  def regularize_whitespace(quote)
    quote.strip.squeeze(" ") unless quote.nil?
  end

  def output(m, output)
    m.reply output
  end
end
