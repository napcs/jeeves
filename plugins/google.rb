require 'open-uri'
require 'nokogiri'
require 'cgi'


class GoogleSearch

  def initialize(query)
    @query  = query + " -w3schools"  # ensure queries exclude w3schools results
  end

  attr_reader :query

  def search
    url = "http://www.google.com/search?q=#{CGI.escape(self.query)}"
    doc = Nokogiri::HTML(URI.open(url))
    res = doc.at "div a>h3"

    title = res.text
    link = res.parent["href"].scan(/url\?q=(?<url>.*?)&sa/).join
    CGI.unescape_html "#{title} -  (#{link})"
  end

end

$help_messages << "!google <query>    : Display URL of the first search result in the channel "

Jeeves.command :google do |event, *query|
  GoogleSearch.new(query.join(" ")).search
end
