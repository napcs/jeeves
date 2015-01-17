# Room.co plugin
# generate a url for a chatroom on room.co
class Room

  include Cinch::Plugin

  $help_messages << "!room:\tStart screenshare and video chat session"

  match /room$/

  def execute(message, query=nil)
    message.reply "Video call starting at #{get_room_url}"
  end

  private
    def get_room_url

      # Apparently room.co just generates code for the url on the client
      # side and doesn't bother to check it. So we'll do the same thing.
      # Their algorithm:
      # 1. Generate random number
      # 2. Convert to string with radix of 36
      # 3. substring(2) to get just the number part.
      #
      # We'll use whole numbers
      "https://room.co/#/#{ (rand * 1e16).ceil.to_s(36) }"
    end
end
