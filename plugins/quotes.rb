class Quotes

  QUOTE_FILE_ERROR = "Unable to load the quotes file."

  attr_reader :path

  def initialize(path)
    @path = path
  end


  def run(message = nil)
    reply = File.exists?(self.path) ? get_reply(regularize_whitespace(message) ) : QUOTE_FILE_ERROR
  end

  private

  def random_quote
    IO.readlines(self.path).shuffle.first
  end

  def add_quote(quote)
    begin
      File.open(self.path, "a") {|file| file.puts quote}
      "Quote added."
    rescue Errno::ENOENT
      QUOTE_FILE_ERROR
    end
  end

  def get_reply(message)
    is_invalid_quote(message) ? random_quote : add_quote(message)
  end

  def is_invalid_quote(quote)
    quote.nil? || quote.empty? || quote.length < 25 || !quote.include?(" - ")
  end

  def regularize_whitespace(quote)
    quote.strip.squeeze(" ") unless quote.nil?
  end

end


$help_messages << "!quote  :  A random quote will be printed to the screen."
$help_messages << "!quote <quote> : Add a quote to the list of quotes to be displayed. Quote must be properly attributed and must be at least 27 characters long. ex: The dude abides. - The Dude"

Jeeves.command :quote do |event, *quote|
  quotes = Quotes.new("config/quotes/quotes.txt")
  # quote class expects nil or a string. Turn the splat into nil or string.
  quote = quote == [] ? nil : quote.join(" ")
  quotes.run(quote)
end
