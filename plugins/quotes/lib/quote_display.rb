class QuoteDisplay
  class << self

    def output(m, quote)
      output = quote.nil? || quote.empty? ? 'Quote added.' : quote
      m.reply output
    end

  end
end