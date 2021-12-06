# HackerNews plugin
class HackerNews

  require 'json'
  require 'open-uri'



    def top_story
      get_story(:first)
    end

    def random_story
      get_story(:random)
    end

    private

    def get_story(rank = :first)
      url = "https://hacker-news.firebaseio.com/v0/topstories.json"
      begin
        raw_data = URI.open(url).read
        story_ids = JSON.parse(raw_data)

        id = rank == :first ? story_ids.first : story_ids.shuffle.first

        url = "https://hacker-news.firebaseio.com/v0/item/#{id}.json"

        raw_data = URI.open(url).read
        data = JSON.parse(raw_data)

        "#{data["title"]} - #{data["url"]}"

      rescue Exception => e
        result = "I don't seem to be able to grab a story for you. #{e.message}"
      end
    end
end

$help_messages << "!hn_top:    Snag top story from HackerNews"
$help_messages << "!hn_random:  Snag a random story from HackerNews"

Jeeves.command(:hn_top) { HackerNews.new.top_story }
Jeeves.command(:hn_random) { HackerNews.new.random_story }
