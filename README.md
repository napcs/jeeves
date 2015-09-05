## Jeeves

Simple chat bot for my class chatroom using Cinch.

### Setup

Clone this repo.

Create the file `bot.yml` to configure the bot and the plugins you want to use.
Here's an example:

~~~
settings:
  server: chat.freenode.net
  nick: a_cool_bot_name
  channel: "#some_channel"
  plugins:
    - "repeater"
    - "seen"
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
settings:
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

* hello:  A simple greeting plugin that demonstrates how a plugin works. Use
this to build your own new plugin.
* Heartbeat:  Tests a URL to see if it's up
* Google: From Cinch's default examples - searches Google and returns result.
* seen: From Cinch's defaults, tells you the last time someone was seen.
* repeater: Pings everyone - watches for a message starting with `all:`
* weather: Gets the weather based on zip or city name
* countdown: Sets a global timer and lets Jeeves tell you how much time is left till that deadline
* js_sandbox: Lets you run some JS code and have Jeeves eval it. Uses Node.
* info: A simple plugin that reads data strings from a file. Useful for quickly pulling up links in chat
* hacker_news: Grab top story from HN
* trivia: A simple trivia question plugin
* eightball: A simple magic 8-ball plugin
* rimshot: Link to rimshot sound.
* ruby_sandbox: Lets you run some Ruby code and have Jeeves evaluate it.
* room: video and screen sharing with Room.co
* codepad: Request a shared workspace
* karma: a simple points system that allows you to give or revoke karma points from people. Uses Redis to store scoreboard.
* quotes: Get a random programming quote or add one of your own.

## Making a plugin

Plugins are just Ruby classes that include the Cinch::Plugin module. A plugin
has a `match` directive and an `execute()` method. Everything else is just
Ruby code.

    match /hello/   # This calls the execute() method whenever the bot sees !hello

    # this is called from the matcher.
    # message.reply sends a message to the channel that the message
    # originated from.
    # message.user gets the user that sent the message.
    # message.user.nick gets the nick of the user that sent the message.
    def execute(message)
      message.reply("Hello #{message.user.nick}
    end


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


