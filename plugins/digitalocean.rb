require 'open-uri'
require 'nokogiri'
require 'cgi'


class DigitalOcean < GoogleSearch

  def initialize(query)
    @query = "site:digitalocean.com " + query  # ensure queries only search DO
  end


end

$help_messages << "!do_tutorial <query>    : Display URL of the first search result in the channel "

Jeeves.command :do_tutorial do |event, *query|
  DigitalOcean.new(query.join(" ")).search
end
