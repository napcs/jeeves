require 'cgi'

$help_messages << "!lmgtfy <query>    : When someone is unable to Google, you can do it for that person"

class Lmgtfy
  include Cinch::Plugin
  match /lmgtfy (.+)/

  def execute(m, query)
    query << ""
    url = "http://lmgtfy.com/?q=#{CGI.escape(query)}"
    m.reply(url)
  end
end