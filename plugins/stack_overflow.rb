# HackerNews plugin
class StackOverflow

  require 'json'
  require 'open-uri'
  require 'cgi'


  def get_answer(query)
    query = CGI.escape(query)
    url  ="https://api.stackexchange.com/2.3/search/advanced?order=desc&sort=votes&accepted=True&site=stackoverflow&q=#{query}"
    begin
      raw_data = URI.open(url).read
      data = JSON.parse(raw_data)

      message = []

      3.times do |i|
        message << "#{data["items"][i]["title"]} - #{data["items"][i]["link"]}"
      end

      message.join("\n\n")

    rescue Error => e
      "I don't seem to be able to grab an answer for you. #{e.message}"
    end
  end
end

$help_messages << '!sodd <query>:    Stack Overflow query'
Jeeves.command(:sodd) { |event, *query| StackOverflow.new.get_answer(query.join(" ")) }
