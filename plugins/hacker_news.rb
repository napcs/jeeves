# HackerNews plugin
class HackerNews

  require 'json'
  require 'open-uri'

  include Cinch::Plugin

  $help_messages << "!hn_top:    Snag top story from HackerNews"

  match /hn_top$/, method: :top_story 
  match /hn_random$/, method: :random_story

  private
    def top_story(message)
      message.reply get_story(:first)
    end
  
    def random_story(message)
      message.reply get_story(:random) 
    end

    def get_story(rank = :first)
      url = "https://hacker-news.firebaseio.com/v0/topstories.json"
      begin
        raw_data = open(url).read
        story_ids = JSON.parse(raw_data)
        
        id = rank == :first ? story_ids.first : story_ids.shuffle.first

        url = "https://hacker-news.firebaseio.com/v0/item/#{id}.json"

        raw_data = open(url).read
        data = JSON.parse(raw_data)

        "#{data["title"]} - #{data["url"]}"

      rescue Exception => e
        result = "I don't seem to be able to grab a story for you. #{e.message}"
      end
    end
end
