require 'json'


# code for interacting with the data store to get and put the karma points
class KarmaStore
  attr_reader :key

  def initialize(data_store, key)
    raise "Please configure the data_store per instructions." unless data_store

    @key        = key
    @data_store = data_store

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

  PROPS_PHRASES = [
    "<nick> is apparently awesome.  +<points> karma points.",
    "<nick> earns <points> karma points for Gryffindor!",
    "Whoohoo! <nick> earns 10 karma points!"
  ]

  def valid_message(event, nick, options = {})
    errors = []
    errors << 'Do that in the channel please' if event.channel.pm?
    errors << "User doesn't exist" unless valid_user?(event, nick)

    if options[:check_restricted]
      errors << "That command is not allowed in this channel" unless $settings["karma"]["negative_channels"].include? event.channel.name
    end

    errors
  end

  def props(options)
    KARMA_STORE.add_points(options[:to], options[:points])
    phrases = PROPS_PHRASES
    phrases[rand(phrases.length)].gsub("<nick>", options[:to]).gsub("<points>", options[:points].to_s)
  end

  def point_message(nick, points)
    "#{nick} has #{points} karma points"
  end

  def element(nick)
    KARMA_STORE.reduce_points(nick, 20)
    "#{nick} is out of their element. -20 karma points."
  end

  def grammar(nick)
    KARMA_STORE.reduce_points(nick, 10)
    "#{nick} fails at grammar. -10 karma points."
  end

  def penalty(nick)
    KARMA_STORE.reduce_points(nick, 50)
    "#{nick} loses 50 karma points for trying to stuff the ballot box."
  end

  def points(nick)
    points = KARMA_STORE.get_record_for(nick)['points']
    if points
      point_message(nick, points)
    else
      "#{nick} isn't on the scoreboard yet."
    end
  end

  def scoreboard
    KARMA_STORE.karma_points.sort_by { |x| -x['points'] }.collect do |row|
      point_message(*row.values_at('nick', 'points'))
    end.join("\n")
  end
end

KARMA_STORE = KarmaStore.new($redis, "#{$settings["name"]}_karma")

$help_messages << "!props <nick>    Give props - award 10 karma points"
Jeeves.command :props do |event, nick|
  karma = Karma.new

  errors = karma.valid_message(event, nick)

  if errors.any?
    errors.join("\n")
  else
    if nick == event.author.username
      karma.penalty(event.author.username)
    else
      karma.props to: nick, points: 10
    end
  end
end

$help_messages << "!element <nick>  Out of element - deducts 20 karma points"
Jeeves.command :element do |event, nick|
  karma = Karma.new
  errors = karma.valid_message(event, nick, {check_restricted: true} )

  if errors.any?
    errors.join("\n")
  else
    karma.element(nick)
  end
end

$help_messages << "!grammar <nick>  Grammar violation - deducts 10 karma points"
Jeeves.command :grammar do |event, nick|

  karma = Karma.new
  errors = karma.valid_message(event, nick, {check_restricted: true} )

  if errors.any?
    errors.join("\n")
  else
    karma.grammar(nick)
  end
end

$help_messages << "!points <nick>   Shows score for a given user"
Jeeves.command :points do |event, nick|
  karma = Karma.new
  karma.points(nick)
end

$help_messages << "!scoreboard      Shows all scores"
Jeeves.command :scoreboard do |event|
  karma = Karma.new
  karma.scoreboard
end

