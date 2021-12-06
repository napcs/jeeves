require 'net/http'
require 'open-uri'

$help_messages << "!up <url>    : Tests the given URL to see if it's up or down."


class Heartbeat
  def test_url(query)
    begin
      url = URI.parse(query)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = url.scheme == "https"

      # this is bad if you're actually USING SSL. but we don't care
      # as we are just pinging the box. If you actually need data
      # exchange, ensure your cert authority is set.
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      http.read_timeout = 30
      path = url.path == "" ? "/" : url.path
      response = http.request_get(path)
      (response.code =~ /2|3\d{2}/ ) ? "#{url} is up!" : "#{url} responded but gave a status code of #{response.code}."

    rescue Errno::ECONNREFUSED
      "#{url} refused my connection. Try HTTPS?"
    rescue ArgumentError => e
      "#{url} appears to be an invalid URL. I can't use it to make a request."
    rescue URI::InvalidURIError => e
      "#{url} appears to be an invalid URL. I can't figure out how to parse it. "
    rescue SocketError => e
      "#{url} is either down, or the domain you're hitting doesn't exist. I got a 'socket error'"
    rescue Timeout::Error => e
      "#{url} didn't respond in a timely manner. Assume it's down."
    end
  end
end

Jeeves.command(:up, min_args: 1, max_args: 1) do |event, query|
  Heartbeat.new.test_url(query)
end
