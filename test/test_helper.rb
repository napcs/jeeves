require 'minitest/autorun'

require 'cinch/test'
require 'webmock/minitest'

include Cinch::Test

$help_messages = [];  # mock the help messages

begin
  $settings = YAML.load(File.read("bot.yml"))
rescue
  puts "create bot.yml and populate it with values. See the readme file!"
end
