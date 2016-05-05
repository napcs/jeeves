require 'open-uri'
require 'nokogiri'
require 'cgi'

class MoonInfo
  $help_messages << "!moon_info <country>, <city>	: Display current information about the moon"
	
  include Cinch::Plugin
  match /moon_info (.*),\s?(.*)/

  def execute(m, country, city)
    url = "http://www.timeanddate.com/moon/#{country.downcase.gsub(" ", "-")}/#{city.downcase.gsub(" ", "-")}"
    main_div = Nokogiri::HTML(open(url)).at("div#qlook")
  	
    moon_type = main_div.at("p").text


    #Future proofing for grabbing the distance
    #distance = main_div.next_sibling.children[3].text
  
    next_new_date = main_div.next_sibling.children[5].children[1].text
    next_new_time = main_div.next_sibling.children[5].children[2].text
    next_full_date = main_div.next_sibling.children[6].children[1].text
    next_full_time = main_div.next_sibling.children[6].children[2].text
    next_moon_date = main_div.next_sibling.children[7].children[1].text
    next_moon_time = main_div.next_sibling.children[7].children[2].text

    m.reply "In #{city}, #{country} the moon tonight will be a #{moon_type.downcase}"
    m.reply "The next new moon will be #{next_new_date} at #{next_new_time}, and the next full moon will be #{next_full_date} at #{next_full_time}"
    m.reply "Expect to see the moon again #{next_moon_date} at #{next_moon_time}"

  end

end
