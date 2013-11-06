## Jeeves

Simple chat bot for my class chatroom using Cinch.

### Setup

Clone this repo.

Create `bot.yml`.

~~~
settings:
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

* Heartbeat:  Tests a URL to see if it's up
* Google: From Cinch's default examples - searches Google and returns result.
* seen: From Cinch's defaults, tells you the last time someone was seen.
* repeater: Pings everyone - watches for a message starting with `all:` 


## Contributing

Fork, send pull request. Keep commits small and organized. Don't add features
to `jeeves.rb` please. Use the plugins.
## License
MIT.


