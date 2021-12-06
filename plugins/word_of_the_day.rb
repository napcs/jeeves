# Get the word of the day data from wordnik.com.
# represent,  parse, and interpret/present the word of the day data
class WordOfTheDay

  require 'cgi'
  require 'json'
  require 'open-uri'

  attr_accessor :word_of_the_day, :definition, :speech

  # Grab the word of the day data
  def self.fetch
  	date = Time.now.strftime("%Y-%m-%d")
    key = $settings["settings"]["wordnik_key"]
    url = "http://api.wordnik.com/v4/words.json/wordOfTheDay?date=#{date}&api_key=#{key}"
    begin
      raw_data = URI.open(url).read
      word_data = JSON.parse(raw_data)
      result = WordOfTheDay.new(word_data)
    rescue Exception => e
      result = "I don't seem to be able to grab the word of the day for you. Error: #{e.message}."
    end
    result
  end

  def initialize(word_data)
    self.word_of_the_day = word_data["word"]
    self.speech = word_data["definitions"].first["partOfSpeech"]
    self.definition = word_data["definitions"].first["text"]
  end

  def to_s
    "Today's word: #{self.word_of_the_day} (#{self.speech}): #{self.definition}"
  end

end


$help_messages << "!wotd    : Displays the word of the day with definition."
Jeeves.command(:wotd) { WordOfTheDay.fetch.to_s }
