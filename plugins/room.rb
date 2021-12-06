# Room.co plugin
# generate a url for a chatroom on appear.in
require 'json'
require 'net/http'
require 'uri'

class Room

  API_ROOT = "https://jump.chat/c/"

  def get_random_room_url
    res = Net::HTTP.get_response(URI(API_ROOT))
    res['location']
  end

end

  $help_messages << "!room:\tStart screenshare and video chat session"

  Jeeves.command :room do |event|
    room = Room.new.get_random_room_url
    "New Video Call starting. Join at #{room}"
  end


