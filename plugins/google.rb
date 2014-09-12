require 'open-uri'
require 'nokogiri'
require 'cgi'

$help_messages << "!google <query>    : Display URL of the first search result in the channel "

class Google
  include Cinch::Plugin
  match /google (.+)/

  def search(query)
    query << " -w3schools"  # ensure queries exclude w3schools results
    url = "http://www.google.com/search?q=#{CGI.escape(query)}"
    res = Nokogiri::HTML(open(url)).at("h3.r")

    title = res.text
    link = res.at('a')["href"].scan(/url\?q=(?<url>.*?)&sa=U&ei=/).join
    desc = res.at("./following::div").children[1].text
    CGI.unescape_html "#{title} - #{desc} (#{link})"
  rescue
    "No results found"
  end

  def execute(m, query)
    m.reply(search(query))
  end
end
