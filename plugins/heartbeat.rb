require 'net/http'
require 'open-uri'

$help_messages << "!up <url>    : Tests the given URL to see if it's up or down."
class Heartbeat
  include Cinch::Plugin
  match /up (.+)/

  def test_url(query)
    url = query
    begin
      response = Net::HTTP.get_response(URI.parse(url.to_s))
      (response.code =~ /2|3\d{2}/ ) ? "#{url} is up!" : "#{url} appears to be down."
    rescue Timeout::Error => e
      "#{url} didn't respond in a timely manner. Assume it's down."
    end
  end

  def execute(m, query)
    m.reply(test_url(query))
  end
end

