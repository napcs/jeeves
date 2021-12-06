# Hello plugin
# Shows how a basic plugin works.
#
# Define a standard class and put your logic in it.

class Hello

  def say(name)
    "Hi there, #{name}!"
  end

end


# now define the help message
# Append a new message to the array of messages.
$help_messages << "!hello:   Make Jeeves greet you."

# look for commands that start with "!hello"
# This will run the "execute" method and pass
# it the chat message object.
Jeeves.command :hello do |event|
  # event.user.username gets the username of the person who sent the
  # original message, so Jeeves greets you.
  Hello.new.say(event.user.username)
end


# Now look for commands that start with !greetings and use the name.
Jeeves.command :greetings do |event, username|
  Hello.new.say(username)
end


# and that's it. The rest is up to you! Use any Ruby code
# you want, including other objects, modules, Gems, whatever!
# Make an awesome thing!
