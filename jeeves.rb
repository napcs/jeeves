require 'rubygems'
require 'discordrb'
require 'yaml'

require './lib/helpers'

include JeevesHelpers::Utilities
include JeevesHelpers::UserHelper

begin
  $settings = YAML.load(File.read("bot.yml"))
rescue
  puts "create bot.yml and populate it with values. See the readme file!"
end

Jeeves = Discordrb::Commands::CommandBot.new token:  $settings['discord_token'] , prefix: '!'

# need redis?
if $settings["redis"]["redis_host"]
require 'redis'

$redis = Redis.new(:host => $settings["redis"]["redis_host"],
                    :port => $settings["redis"]["redis_port"] || 6380)

end

# hold those help messages
$help_messages = []


# load those plugins
$settings["plugins"].each do |plugin|
  require "./plugins/#{plugin}"
end


# help command
Jeeves.command :help do |event|
  message = $help_messages.join("\n")
  event.user.pm message
  nil
end

Jeeves.run
