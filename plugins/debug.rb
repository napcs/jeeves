# This is a debug plugin. It's useful for testing.

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
