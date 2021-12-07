# This is a debug plugin. It's useful for testing.
require 'pry'

Jeeves.command :message_info do |event|
  out = "Debug info:\n"
  out << "Initiated by: #{event.author.username}\n"
  out << "Channel: #{event.channel.name}\n"
  out << "Private message: #{event.channel.pm?}\n"
  if event.channel.pm?
    out << "PM sent to #{event.channel.recipient.username}"
  end

  out
end

Jeeves.command :echo do |event, query|
  query
end

Jeeves.command :user_info do |event, query| 
  regex = /<@!(.*)>/

  if query =~ regex
    id = $1.to_i
    user = event.server.members.find {|user| user.id == id}
  else
    user = event.server.members.find {|user| user.username == query}
  end

  if user
    result = "Username: #{user.username}\n"
    result << "ID: #{user.id}\n"
    result << "Joined: #{user.joined_at}\n"
  else
    "#{query} was not found"
  end
end
