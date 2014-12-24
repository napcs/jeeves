## Jeeves

Simple chat bot for my class chatroom using Cinch.

### Setup

Clone this repo.

Create `bot.yml`.

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

Then use

`bundle`

Then launch it with

`bundle exec ruby jeeves.rb`

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
to `jeeves.rb` please. Use the plugins.
## License
MIT.


