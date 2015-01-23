# Room.co plugin
# generate a url for a chatroom on appear.in
require 'json'
require 'net/http'
require 'uri'

class AppearIn

  API_ROOT = "https://api.appear.in"
  ROOM_ROOT = "https://appear.in"
  HEADERS = {
    'Content-Type' =>'application/json',
    'accept' => 'application/json, text/plain, */*'
  }

  def get_random_room_url
    # POST to /random-room-name
    # returns {"roomName": "some-crazything"}
    puts "******* MAKING REQUEST *********"
    endpoint = '/random-room-name'
    uri = URI("#{API_ROOT}#{endpoint}")
    req = Net::HTTP::Post.new(uri, HEADERS)
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) {|http| http.request(req) }
    data = JSON.parse response.body
    "#{ ROOM_ROOT }#{ data['roomName'] }"
  end

end

class Room

  include Cinch::Plugin

  $help_messages << "!room:\tStart screenshare and video chat session"

  match "room"

  def execute(message)
    message.reply "New Video Call starting. Join at #{get_room_url}"
  end

  private
    def get_room_url
      room = AppearIn.new
      room.get_random_room_url
    end

end
