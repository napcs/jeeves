# Greet a user when they join the chat room
class GreetOnJoin

  include Cinch::Plugin
  listen_to :join

  def listen(message)
    return if message.user.nick == bot.nick
    text = %Q{#{message.user.nick}: Welcome to the chat. I'm #{bot.nick}, a bot. You can type "!help" (without the quotes) and I will send you my commands in a private chat. To greet everyone here, type something like "all: Hi there! What's up today?" (without the quotes.) This chat has busy times and quiet times. But stick around and someone will answer you eventually.}
    message.reply(text)
  end

end
