# Codepad plugin
# Generates a link to a collaborative code editor
# that can be used channel wide or in a private message.

class Pad
  BASE_URL = "https://pad.riseup.net/p/"

  def initialize(name)
    @prefix = name
  end

  def url
    "#{BASE_URL}#{@prefix}_#{slug}"
  end

  private
    def slug
      Digest::SHA1.hexdigest(Time.now.to_s).slice(0,10)
    end
end

$help_messages << "!codepad:   Create link to a codepad and display link in chat."

# Display the pad in the main room
Jeeves.command  :codepad do |event|
  Pad.new($settings["name"]).url
end

$help_messages << "!codepad_for <user>:   Create link to a codepad and send link to user and requester."
Jeeves.command(:codepad_for) do |event, username|
  url = Pad.new($settings["name"]).url
  user = find_user_by_username(event, username)
  if user
    event.user.pm "Hey #{event.user.username}! Here's the Codepad URL you requested: #{url}"
    user.pm "Hi #{user.username}! #{event.user.username} wants to collaborate with you privately. Visit #{url}"
  else
    event.user.pm "I can't find that user on this server."
  end
  # don't send anything back to the main channel!
  nil
end

