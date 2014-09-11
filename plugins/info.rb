# Info plugin
# Shows pre-made information.
# Create the file `info.yml` in the root of the bot.
# add a key and value to each line.
#
#     homepage: http://napcs.com/
#     hn: http://news.ycombinator.com/
#
# Then use !info hn   and the bot will display the link.
# Use !info reload if you change the yml file
# Use !info help   if you want to see all the keys.
class Info

  # include the Cinch::Plugin mixin which 
  # adds the behavior for plugins to this plain Ruby object.
  include Cinch::Plugin

  # Append a new message to the array of messages.
  $help_messages << "!info <key> : displays some static content. Try typing just !info"
  match /info (.+)/

  def execute(message, query=nil)
    
    if query
      # message.reply sends a message to the channel.
      # query is the captured value from the regular expression
      # in the matcher.
      if data[query]
        message.reply(data[query])
      else
        if query == "reload"
          load_from_file
          message.reply("Data refreshed.")
        elsif query == "help"
          message.reply("Choose from #{data.keys.join(", ")}")
        else
          message.reply("I don't know that")
        end
      end
    end
   
    # and that's it. The rest is up to you! Use any Ruby code
    # you want, including other objects, modules, Gems, whatever!
    # Make an awesome thing!

  end
  
  def data
    $data ||= read_from_file
  end

  def read_from_file
    begin
      YAML.load(File.read("info.yml")) 
    end
  end


end
