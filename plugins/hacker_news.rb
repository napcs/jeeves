# HackerNews plugin
class HackerNews

  require 'json'
  require 'open-uri'

  include Cinch::Plugin

  $help_messages << "!hn_top:    Snag top story from HackerNews"

  match /hn_top$/

  def execute(message)
    message.reply top_story
  end

  private
    def top_story

      url = "https://hacker-news.firebaseio.com/v0/topstories.json"
      begin
        raw_data = open(url).read
        story_ids = JSON.parse(raw_data)
        id = story_ids.first

        url =  "https://hacker-news.firebaseio.com/v0/item/#{id}.json"

        raw_data = open(url).read
        data = JSON.parse(raw_data)
        
        "#{data["title"]} - #{data["url"]}"


      rescue Exception => e
        result = "I don't seem to be able to grab the top story for you. #{e.message}"
      end
    end



end
