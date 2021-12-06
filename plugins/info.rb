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

  def data
    @data ||= read_from_file
  end

  def refresh_data
    @data = read_from_file
  end

  def display_help
    "Choose from #{data.keys.join(", ")}"
  end

  private
    def read_from_file
      begin
        YAML.load(File.read("info.yml"))
      end
    end

end

$help_messages << "!info <key> : displays some static content. Try typing just !info"

Jeeves.command :info do |event, query|
  info = Info.new
  result = if query

            if info.data[query]
              info.data[query]
            else
              if query == "reload"
                refresh_data
                "Data refreshed."
              elsif query == "help"
                display_help
              else
                "I don't know that"
              end
            end
          else
            info.display_help
          end
end
