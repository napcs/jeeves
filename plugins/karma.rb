require 'json'

# code for interacting with the data store to get and put the karma points
class KarmaStore
  attr_accessor :karma_points

  def initialize(redis, key)
    @key = key
    if redis
      @redis = redis
      get
    else
      raise "Please configure Redis per instructions."
    end
  end

  def get
    data = $redis.get(@key)
    if data
      @karma_points = JSON.parse(data)
    else
      @karma_points = []
    end
  end

  def save
    @redis.set @key, @karma_points.to_json   # post to Redis
    @redis.bgsave # TODO: can't seem to get the data to persist after a restart any other way.
  end

  # Retrieves record for a user. If user doesn't exist yet, create a 0 points entry for the user.
  def get_record_for(nick)
    @karma_points.select{|record| record['nick'] == nick}[0] || (@karma_points << {'nick' => nick, 'points' => 0}).last
  end

  def add_points(nick, points)
    get_record_for(nick)['points'] += points
    save
  end

  def reduce_points(nick, points)
    get_record_for(nick)['points'] -= points
    save
  end

end

class Karma
  include Cinch::Plugin

  PROPS_PHRASES = [
    "<nick> is apparently awesome.  +<points> points.",
    "<nick> earns <points> for Gryffindor!",
    "Whoohoo! <nick> earns 10 points!"
  ]

  $help_messages << "!props <nick>    Give props"
  match /props (.+)/,                 method: :props

  $help_messages << "!element <nick>  Out of element"
  match /element (.+)/,               method: :element

  $help_messages << "!grammar <nick>  Grammar violation"
  match /grammar (.+)/,               method: :grammar

  $help_messages << "!points <nick>   Shows score for a given user"
  match /points (.+)/,                     method: :points

  $help_messages << "!scoreboard      Shows all scores"
  match /scoreboard$/,                 method: :scoreboard

  def initialize(bot)
    super
    # bot.nick doesn't seem to have a value here. Get nick from config.
    nick = $settings["settings"]["nick"]

    # new instance of karma store
    @karma_store = KarmaStore.new($redis, "#{nick}_karma")
  end

  def userlist(m)
    m.channel.users.collect{|u| u.first.nick}
  end

  def valid_message(m, nick)
    result = false
    if m.channel
      if userlist(m).include? nick
        result = true
      else
        m.reply "User not here"
      end
    else
      m.reply "Do that in the channel please"
    end
    result
  end

  def props(m, nick)
    if valid_message(m, nick)

      if nick == m.user.nick
        @karma_store.reduce_points(m.user.nick, 50)
        m.reply "#{m.user.nick} loses 50 points for trying to stuff the ballot box."
      else
        @karma_store.add_points(nick, 10)
        m.reply witty_reply :to => nick, :points => 10
      end
    end
  end

  def element(m, nick)
    if valid_message(m, nick)
      @karma_store.reduce_points(nick, 20)
      m.reply "#{nick} is out of their element. -20 points."
    end
  end

  def grammar(m, nick)
    if valid_message(m, nick)
      @karma_store.reduce_points(nick, 10)
      m.reply "#{nick} fails at grammar. -10 points."
    end
  end

  def points(m, nick)
    points = @karma_store.get_record_for(nick)['points']
    m.reply "#{nick} has #{points} points"
  end

  def scoreboard(m)
    @karma_store.karma_points.sort_by{ |x| x['points']}.reverse.each do |row|
      m.reply "#{row['nick']} has #{row['points']} points"
    end
  end

  def witty_reply(options = {})
    phrases = PROPS_PHRASES
    phrases[rand(phrases.length)].gsub("<nick>", options[:to]).gsub("<points>", options[:points].to_s)
  end

end
