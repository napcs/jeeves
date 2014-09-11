
# JS_Sandbox plugin
# Allows us to exec javascript code in the chat room safely.
class JsSandbox

  # include the Cinch::Plugin mixin which 
  # adds the behavior for plugins to this plain Ruby object.
  include Cinch::Plugin

  # Append a new message to the array of messages.
  $help_messages << "!js var a = 1; var b = 2; a + b:   Make Jeeves eval some JS and return answer to you."

  match /js (.+)/

  def execute(message, query)
    
    # if the query parameter was sent in
    if query
      puts "######## Raw query = #{query}"
      query = quote(query)
      puts "######## #{query} #######"
      cmd = %Q{node plugins/js_sandbox/js_sandbox.js "#{query}"}
      puts "######## #{cmd} ########"
      result = `#{cmd}`
      message.reply(result.chop)
    end
   
  end
  private

    def quote (str)
      str.gsub!(/[\u201a\u201b]/, "'")
      str.gsub!(/[\u201c\u201d]/, '"')
      str.gsub!(/[\u2018\u2019]/, "'")
      str.gsub!(/\\|"/) { |c| "\\#{c}" }
      str
    end

end
