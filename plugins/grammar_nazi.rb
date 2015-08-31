
# Look for horrible grammar used in the chat.
class GrammarNazi

  # include the Cinch::Plugin mixin which
  # adds the behavior for plugins to this plain Ruby object.
  include Cinch::Plugin

  # look for poor grammar
  # i means
  # This uses a regular expression.
  match /shouldve/i, method: :shouldve, use_prefix: false
  match /sneak peak/i, method: :sneakpeak, use_prefix: false
  match /couldve/i, method: :couldve, use_prefix: false


  def shouldve(message)
    message.reply("It's \"should have\", you idiot!")
  end

  def sneakpeak(message)
    message.reply("Sneak PEEK!")
  end

  def couldve(message)
    message.reply("Could HAVE moron!")
  end

end
