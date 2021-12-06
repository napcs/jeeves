# Get the word data from wordnik.com.
class WordFetcher

  require 'cgi'
  require 'json'
  require 'open-uri'

  # Grab the word data
  def self.fetch(query)
    word = CGI.escape(query)
    key = $settings["settings"]["wordnik_key"]
    #http://api.wordnik.com/v4/word.json/ninja/definitions?limit=200&includeRelated=true&useCanonical=false&includeTags=false&api_key={key}
    url = "http://api.wordnik.com/v4/word.json/#{word}/definitions?api_key=#{key}"
    begin
      raw_data = URI.open(url).read
      word_data = JSON.parse(raw_data)
      result = WordData.new(word, word_data)
    rescue Exception => e
      result = "I don't seem to be able to grab the word for you. Please check your spelling and try again. Error: #{e.message}."
    end
    result
  end

end

# represent,  parse, and interpret/present the word data
class WordData
  attr_accessor :word, :definition, :speech

  def initialize(word, word_data)
    self.word = word
    self.speech = word_data.first["partOfSpeech"]
    self.definition = word_data.first["text"]
  end

  def to_s
    "#{word} (#{self.speech}): #{self.definition}"
  end

end
# The plugin
class Dictionary

  def fetch(query)
    word = WordFetcher.fetch(query)
    word.to_s
  end

end

$help_messages << "!define <word>    : Displays the word definition."
Jeeves.command(:define) { |event, word| Dictionary.new.fetch(word) }
