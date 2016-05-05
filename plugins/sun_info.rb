require 'open-uri'
require 'nokogiri'
require 'cgi'

class SunInfo
	$help_messages << "!sun_info <country>, <city>	: Display current information about the sun in the USA"
	
	include Cinch::Plugin
	match /sun_info (.*),\s?(.*)/

	def execute(m, country, city)
	url = "http://www.timeanddate.com/sun/#{country.downcase.gsub(" ", "-")}/#{city.downcase.gsub(" ", "-")}"
	main_div = Nokogiri::HTML(open(url)).at("div#qlook")
  	
  #Future proofing for grabbing the distance
	#distance = main_div.next_sibling.children[3].text

	duration = main_div.at("p.dn-mob").text.split("M").last
  solstice = main_div.next_sibling.children[5].text.split(": ").last
  sunrise = main_div.next_sibling.children[6].children[1].text
  sunset = main_div.next_sibling.children[7].children[1].text

  m.reply "In #{city}, #{country} the sun rises at #{sunrise} and sets at #{sunset}, a duration of #{duration}"
  m.reply "The next solstice will be on #{solstice}"

	end

end