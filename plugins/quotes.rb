class Quotes
  include Cinch::Plugin
  require_relative 'quotes/lib/quote_source'
  require_relative 'quotes/lib/quote_display'

  $help_messages << '!quote  :  A random quote will be printed to the screen.'
  $help_messages << '!quote <quote> : Add a quote to the list of quotes to be displayed. Quote must be properly attributed and must be at least 27 characters long. ex: The dude abides. - The Dude'

  match /quote(.*)/, method: :run_quotes

  def run_quotes(m, message = nil)
    quote_source = QuoteSource.new(message)
    QuoteDisplay.output(m, quote_source.quote)
  end
end
