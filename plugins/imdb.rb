require 'open-uri'
require 'nokogiri'
require 'cgi'

class Imdb

	$help_messages << "!imdb <media>	: Display information from IMDB about a movie, game, or tv show"
	include Cinch::Plugin

	match /imdb (.+)/

	def execute(m, media)
		url = "http://www.imdb.com/search/title?title=#{media.downcase.gsub(" ", "%20")}&title_type=feature,tv_movie,tv_series,mini_series,game,short"
		main_div = Nokogiri::HTML(open(url)).at("td.title") rescue nil

		if main_div.nil?
			m.reply "IMDB encountered an error with this title.  Please refine your search or try again later."
		end

		description = main_div.at("span.outline").text rescue nil
		duration = main_div.at("span.runtime").text.split(" ").first rescue nil
		genre = main_div.at("span.genre").text.gsub(" |", ",")
		rated = main_div.at("span.certificate").children[0].attribute("title") rescue nil
		stars = main_div.at("span.credit").text rescue nil
		title = main_div.at("a").text
		user_rating = main_div.at("span.rating-rating").text rescue nil
		year = main_div.at("span.year_type").text.sub("(", "").sub(")", "").split(" ").first

		if description.nil?
			m.reply "#{title} does not have enough information to return."
		elsif (genre.nil? || rated.nil? || duration.nil? || user_rating.nil?) && stars.nil?
			m.reply "#{title} " + "(" + "#{year}" + ")" + ": #{description}"
			m.reply "No additional information is available for #{title}."
		elsif stars.nil?
			m.reply "#{title} " + "(" + "#{year}" + ")" + ": #{description}"
			m.reply "Unable to obtain information on who is involved with #{title}."
		elsif genre.nil? || rated.nil? || duration.nil? || user_rating.nil?
			m.reply "#{title} " + "(" + "#{year}" + ")" + ": #{description}"
			m.reply "#{stars.sub("Dir:", "Directed by").sub("With:", "Starring")}"
			m.reply "No additional information is available for #{title}."
		else
			m.reply "#{title} " + "(" + "#{year}" + ")" + ": #{description}"
			m.reply "#{title} has a user rating of #{user_rating} and is approximately #{duration} minutes. It's rated #{rated.to_s.gsub("_", "-")} for #{genre}."
			m.reply "#{stars.sub("Dir:", "Directed by").sub("With:", "Starring")}"
		end
	end

end