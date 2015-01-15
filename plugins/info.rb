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

  include Cinch::Plugin

  $help_messages << "!info <key> : displays some static content. Try typing just !info"
  match /info (.+)/

  def execute(message, query=nil)

    if query

      if data[query]
        message.reply(data[query])
      else
        if query == "reload"
          refresh_data
          message.reply("Data refreshed.")
        elsif query == "help"
          display_help
        else
          message.reply("I don't know that")
        end
      end
    else
      display_help
    end

  end

  def data
    $data ||= read_from_file
  end

  def refresh_data
    $data = read_from_file
  end

  private
    def read_from_file
      begin
        YAML.load(File.read("info.yml"))
      end
    end

    def display_help
      message.reply("Choose from #{data.keys.join(", ")}")
    end

end
