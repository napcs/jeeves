## Jeeves

Simple chat bot for my class chatroom using Cinch.

### Setup

Clone this repo.

Create the file `bot.yml` to configure the bot and the plugins you want to use.
Here's an example:

~~~
discord_token: YOUR_TOKEN
name: a_cool_bot_name
plugins:
  - "google"
  - "heartbeat"
~~~

Then run the command

`bundle`

to install dependencies.

Then use

```
bundle exec ruby jeeves.rb
```

to start the bot. The bot will connect to the network you specified with the nick you
specified and join the channel.

Press `Ctrl+C` to stop the bot.

### Using Plugins Backed By Redis (Karma plugin, etc)

Install Redis locally.

Add configuration to the `bot.yml` file.

```
redis:
  redis_host: localhost
  redis_port: 6380
  ... other stuff
```

Use Foreman to manage launching the bot and the Redis server.

```
foreman start
```

to launch the bot and Redis-server processes.

Press `Ctrl+C` to stop everything.

## Plugins

* codepad: Request a shared workspace
* dictionary: Get the definition of a word
* debug: a plugin that's helpful in debugging messages.
* digitalocean: Search DigitalOcean tutorials.
* eightball: A simple magic 8-ball plugin
* Google: From Cinch's default examples - searches Google and returns result.
* hacker_news: Grab top story from HN
* Heartbeat:  Tests a URL to see if it's up
* hello:  A simple greeting plugin that demonstrates how a plugin works. Use
this to build your own new plugin.
* info: A simple plugin that reads data strings from a file. Useful for quickly pulling up links in chat
* ip_lookup: Display information about IP
* karma: a simple points system that allows you to give or revoke karma points from people. Uses Redis to store scoreboard.
* lmgtfy: When someone is unable to Google, you can do it for that person.
* meme_generator: Generate a customized meme
* quotes: Get a random programming quote or add one of your own.
* rimshot: Link to rimshot sound.
* room: video and screen sharing with Room.co
* stack_overflow: Query StackOverflow for answers. Returns 3 results based on query.
* store_url: Store URLs from chat, list stored URLs, retrieve URLs
* sun_info: Get current day sunrise and sunset information
* trivia: A simple trivia question plugin
* weather: Gets the weather based on zip or city name
* word_of_the_day: Displays word of the day with definition

## Broken plugins
* base_conversion: Convert strings into binary or hexadecimal
* blackjack: Play a game of blackjack
* countdown: Sets a global timer and lets Jeeves tell you how much time is left till that deadline
* simp_qotd: Provide Simpsons quote of the day with an image from @SimpsonsQOTD on Twitter.
* moon_info: Get moon information for the current day
* language_mechanics: Grammar bot to correct poor grammar automatically
* imdb: Get information about a movie, tv show, or video game

## Making a plugin

Plugins are just files that include calls to `Jeeves.command` to define commands. 

Here's an example:

```
# The Hello plugin
# Shows how a basic plugin works.
#
# Define a standard class and put your logic in it.
class Hello

  def say(name)
    "Hi there, #{name}!"
  end
end


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


# Now look for commands that start with !greetings and use the name provided.
Jeeves.command :greetings do |event, username|
  Hello.new.say(username)
end
```



See the `hello` plugin for more details, or look at the other plugins to get ideas.
Make a plugin and contribute it!

## Contributing

Fork, send pull request. Keep commits small and organized. Don't add features
to `jeeves.rb` please. Use plugins for that.

### The Hello plugin

See `plugins/hello.rb` for how to write a basic plugin.

### Test your plugins

See `test/unit/hello_test.rb` for how to test a plugin. Plugins use the
Cinch-test library.

Use

    rake test

to run tests.

## License
MIT.


