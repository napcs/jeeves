require 'open-uri'
require 'nokogiri'
require 'cgi'

raise "This plugin no longer works and needs to be rewritten."

class SimpQotd

  def run

    url = "https://twitter.com/SimpsonsQOTD"
    ordered_list = Nokogiri::HTML(URI.open(url)).at("ol#stream-items-id")
    top_of_list = ordered_list.children[1]
    recent_quote = top_of_list.at("p").text

    if top_of_list.at("div.PlayableMedia-player")
      video = top_of_list.at("div.PlayableMedia-player").attribute("style").to_s
      media_source = video.split("('").last.split("')").first
    else
      image = top_of_list.at("div.AdaptiveMedia-singlePhoto")
      media_source = image.at("img").attribute("src").to_s
    end

    result = "#{media_source}\n"
    result << "#{recent_quote.split("pic.twitter").first}"

  end

end

$help_messages << "!simp_quote  : Provide Simpsons quote of the day with an image from @SimpsonsQOTD on Twitter"

Jeeves.command(:simp_quote) { SimpsonsQOTD.new.run }
