require 'minitest/autorun'

require 'cinch/test'
require 'webmock/minitest'

include Cinch::Test

$help_messages = [];  # mock the help messages
