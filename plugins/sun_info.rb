require 'open-uri'
require 'nokogiri'
require 'cgi'

class SunInfo

  def run(country, city)
    url = "https://www.timeanddate.com/sun/#{country.downcase.gsub(" ", "-")}/#{city.downcase.gsub(" ", "-")}"

    main_div = Nokogiri::HTML(URI.open(url)).at(".bk-focus")

    #Future proofing for grabbing the distance
    #distance = main_div.next_sibling.children[3].text

    duration = main_div.at("p.dn-mob").text.split("pm").last
    solstice = main_div.css(".bk-focus__info > table td")[4].text
    sunrise = main_div.css(".bk-focus__info > table td")[5].text
    sunset = main_div.css(".bk-focus__info > table td")[6].text

    result = "In #{city}, #{country} the sun rises at #{sunrise} and sets at #{sunset}, a duration of #{duration}\n"
    result << "The next solstice will be on #{solstice}"

  end

end

$help_messages << "!sun_info <country> <city>	: Display current information about the sun"

Jeeves.command(:sun_info) { |_event, country, city| SunInfo.new.run(country, city) }
