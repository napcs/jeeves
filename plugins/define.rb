class DefinitionFetcher

  require 'json'
  require 'open-uri'

  def fetch_definition(word)
    uri = "http://api.wordnik.com/v4/word.json/#{word}/" +
          "definitions" +
          "?limit=200" +
          "&includeRelated=true" +
          "&useCanonical=false" +
          "&includeTags=false" +
          "&api_key=" +
          get_key

    raw_data = open(uri).read
    define = JSON.parse(raw_data).first
    output = DefinitionParser.new(define)

    rescue NameError  
      "Error" 
    rescue SocketError 
      "Socket error" 
    rescue OpenURI::HTTPError
      "Argument Error"  
    rescue URI::InvalidURIError 
      "Argument Error"
  end
 
  def get_key
    $key ||= load_settings["DEFINE_PLUGIN_WORDNIK"]
  end

  def to_s
    "#{output}"
  end

  private
  def load_settings
    begin
       YAML.load(File.read("define.yml"))
    end
  end
end


class DefinitionParser
  attr_accessor :definition
  def initialize(define)
    self.definition = define['text']
  end

  def to_s
    "#{self.definition}"
  end
end


class Define

  include Cinch::Plugin

  $help_messages << "!define <word>    :Returns the definition of a word"

  match /define (.+)/, method: :fetch_definition

  def fetch_definition(m,word)
    m.reply DefinitionFetcher.new.fetch_definition(word)
  end
end

