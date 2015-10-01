# HackerNews plugin
class StackOverflow

  require 'json'
  require 'open-uri'
  require 'cgi'

  include Cinch::Plugin

  $help_messages << "!sodd <query>:    Stack Overflow query"

  match /sodd (.*)$/, method: :get_answer

  def get_answer(message, query)
    query = CGI.escape(query)
    url  ="https://api.stackexchange.com/2.1/search/advanced?order=desc&sort=votes&site=stackoverflow&q=#{query}"
    begin
      raw_data = open(url).read
      data = JSON.parse(raw_data)

      3.times do |i|
        message.reply "#{data["items"][i]["title"]} - #{data["items"][i]["link"]}"
      end

    rescue Exception => e
      message.reply "I don't seem to be able to grab an answer for you. #{e.message}"
    end
  end
end
