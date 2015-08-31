# Codepad plugin
# Generates a link to a collaborative code editor
# that can be used channel wide or in a private message.

class Pad
  BASE_URL = "https://pad.riseup.net/p/"

  def initialize(prefix)
    @prefix = prefix
  end

  def url
    "#{BASE_URL}#{@prefix}_#{slug}"
  end

  private
    def slug
      Digest::SHA1.hexdigest(Time.now.to_s).slice(0,10)
    end

end

class Codepad

  include Cinch::Plugin

  $help_messages << "!codepad:   Create link to a codepad and display link in chat."
  $help_messages << "!codepad for <user>:   Create link to a codepad and send link to user and requester."

  match /codepad$/, method: :public_pad
  match /codepad for (.+)/, method: :private_pad

  # Display the pad in the main room
  def public_pad(message)
    url = Pad.new(bot.nick).url
    message.reply(url)
  end

  def private_pad(message, user)
    url = Pad.new(bot.nick).url
    message.user.send "#{message.user}: Here's the Codepad URL you requested: #{url}"
    User(user).send("#{user}: #{message.user} wants to collaborate with you privately. Visit #{url}") unless message.user == user
  end

end
