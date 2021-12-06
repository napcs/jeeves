require 'minitest/autorun'
require 'webmock/minitest'
require 'discordrb'

Jeeves = Discordrb::Commands::CommandBot.new token:  'test' , prefix: '!'

$help_messages = [];  # mock the help messages

begin
  $settings = YAML.load(File.read("bot.yml"))
rescue
  puts "create bot.yml and populate it with values. See the readme file!"
end
