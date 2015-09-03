require 'json'

# code for interacting with the data store to get and put the karma points
class KarmaStore
  attr_reader :key

  def initialize(data_store, key)
    @key        = key
    @data_store = data_store

    raise "Please configure the data_store per instructions." unless data_store
  end

  def karma_points
    @karma_points ||= parsed_read_store
  end

  # Retrieves record for a user. If user doesn't exist yet, create a 0 points entry for the user.
  def get_record_for(nick)
    karma_points.detect { |record| record['nick'] == nick } || (karma_points << { 'nick' => nick, 'points' => 0 }).last
  end

  def add_points(nick, points)
    get_record_for(nick)['points'] += points
    save
  end

  def reduce_points(nick, points)
    get_record_for(nick)['points'] -= points
    save
  end

  def save
    data_store.set key, karma_points.to_json   # post to the data_store
    data_store.bgsave # TODO: can't seem to get the data to persist after a restart any other way.
  end

  private

  attr_reader :data_store

  def parsed_read_store
    return [] unless raw_data = read_store

    JSON.parse(raw_data)
  end

  def read_store
    data_store.get(key)
  end

end

class Karma
  include Cinch::Plugin
  private

  attr_reader :karma_store

  public

  PROPS_PHRASES = [
    "<nick> is apparently awesome.  +<points> karma points.",
    "<nick> earns <points> karma points for Gryffindor!",
    "Whoohoo! <nick> earns 10 karma points!"
  ]

  $help_messages << "!props <nick>    Give props - award 10 karma points"
  match /props (.+)/,                 method: :props

  $help_messages << "!element <nick>  Out of element - deducts 20 karma points"
  match /element (.+)/,               method: :element

  $help_messages << "!grammar <nick>  Grammar violation - deducts 10 karma points"
  match /grammar (.+)/,               method: :grammar

  $help_messages << "!points <nick>   Shows score for a given user"
  match /points (.+)/,                method: :points

  $help_messages << "!scoreboard      Shows all scores"
  match /scoreboard$/,                method: :scoreboard

  def initialize(bot)
    super
    # new instance of karma store
    @karma_store = KarmaStore.new($redis, plugin_key)
  end

  def plugin_key
    # bot.nick doesn't seem to have a value here. Get nick from config.
    "#{$settings["settings"]["nick"]}_karma"
  end

  def userlist(m)
    m.channel.users.collect { |u| u.first.nick }
  end

  def valid_message(m, nick)
    return warn(m, 'Do that in the channel please') unless m.channel
    return warn(m, 'User not here') unless user_online?(m, nick)

    return true
  end

  def user_online?(m, nick)
    userlist(m).include?(nick)
  end

  def warn(m, msg)
    m.reply(msg) and return false
  end

  def props(m, nick)
    return unless valid_message(m, nick)

    if nick == m.user.nick
      karma_store.reduce_points(m.user.nick, 50)
      m.reply "#{m.user.nick} loses 50 karma points for trying to stuff the ballot box."
    else
      karma_store.add_points(nick, 10)
      m.reply witty_reply :to => nick, :points => 10
    end
  end

  def element(m, nick)
    return unless valid_message(m, nick)

    karma_store.reduce_points(nick, 20)
    m.reply "#{nick} is out of their element. -20 karma points."
  end

  def grammar(m, nick)
    return unless valid_message(m, nick)

    karma_store.reduce_points(nick, 10)
    m.reply "#{nick} fails at grammar. -10 karma points."
  end

  def points(m, nick)
    points = karma_store.get_record_for(nick)['points']
    m.reply point_message(nick, points)
  end

  def scoreboard(m)
    karma_store.karma_points.sort_by { |x| -x['points'] }.each do |row|
      m.reply point_message(*row.values_at('nick', 'points'))
    end
  end

  def point_message(nick, points)
    "#{nick} has #{points} karma points"
  end

  def witty_reply(options = {})
    phrases = PROPS_PHRASES
    phrases[rand(phrases.length)].gsub("<nick>", options[:to]).gsub("<points>", options[:points].to_s)
  end
end
