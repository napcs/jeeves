require 'open-uri'
require 'nokogiri'
require 'cgi'

class SimpQotd

  $help_messages << "!simp_quote  : Provide Simpsons quote of the day with an image from @SimpsonsQOTD on Twitter"
  include Cinch::Plugin

  match /simp_quote/

  def execute(m)

    url = "https://twitter.com/SimpsonsQOTD"
    ordered_list = Nokogiri::HTML(open(url)).at("ol#stream-items-id")
    top_of_list = ordered_list.children[1]
    recent_quote = top_of_list.at("p").text
    
    if top_of_list.at("div.PlayableMedia-player")
      video = top_of_list.at("div.PlayableMedia-player").attribute("style").to_s
      media_source = video.split("('").last.split("')").first
    else
      image = top_of_list.at("div.AdaptiveMedia-singlePhoto")
      media_source = image.at("img").attribute("src").to_s
    end

    m.reply "#{media_source}"
    m.reply "#{recent_quote.split("pic.twitter").first}"

  end

end
