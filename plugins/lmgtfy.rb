require 'cgi'

class Lmgtfy

  def run(query)
    url = "http://lmgtfy.com/?q=#{CGI.escape(query)}"
  end
end

$help_messages << "!lmgtfy <query>    : When someone is unable to Google, you can do it for that person"
Jeeves.command(:lmgtfy) { |_event, *query| lmgtfy.new.run(query.join(" ")) }
