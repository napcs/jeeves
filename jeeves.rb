require 'rubygems'
require 'discordrb'
require 'yaml'

# This method is taken from rails core
# (didn't want to load the entire lib for one method)
# http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-constantize
def constantize(camel_cased_word)
  names = camel_cased_word.split('::')
  names.shift if names.empty? || names.first.empty?

  constant = Object
  names.each do |name|
    constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
  end
  constant
end


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
