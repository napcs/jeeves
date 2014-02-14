# Hello plugin
# Shows how a basic plugin works. Every Cinch plugin
# follows this approach.
#
# Define a standard class
class Hello

  # include the Cinch::Plugin mixin which 
  # adds the behavior for plugins to this plain Ruby object.
  include Cinch::Plugin

  # Append a new message to the array of messages.
  $help_messages << "!hello:   Make Jeeves greet you."


  # look for commands that start with "!hi"
  # This will run the "execute" method and pass
  # it the chat message object.
  # This uses a regular expression. 
  match /hi$/

  # this looks for commands that start with !greet and have something after them
  # like "!greet bphogan"
  # Still sends the command to the 
  match /greetings (.+)/

  # Called when something matches the "match" rule above.
  # Execute any code you want here.
  # the message is the message object from the chat. It's a way
  # to reply or get info about the message that the bot is responding
  # to, including the user and the channel the message came from.
  #
  # The query is anything that was captured after the matcher
  #
  # The query may or may not be there. - if the match didn't capture anything
  # then there will be no query - it'll be nil. If there was a capture, it'll
  # be in the query variable.
  #
  # For example, the !greetings command captures some user input 
  # after the phrase. So its value is in the query. But the !hi command
  # does not.
  def execute(message, query)
    
    # if the query parameter was sent in
    if query
      # message.reply sends a message to the channel.
      # query is the captured value from the regular expression
      # in the matcher.
      message.reply(query)
    else
      # message.user.nick gets the username of the person who sent the 
      # original message.
      message.reply("hi there #{message.user.nick}!")
    end
   
    # and that's it. The rest is up to you! Use any Ruby code
    # you want, including other objects, modules, Gems, whatever!
    # Make an awesome thing!

  end

end
