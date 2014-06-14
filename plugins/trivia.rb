require 'open-uri'
require 'nokogiri'
require 'cgi'

  $help_messages << "!trivia  :Displays a trivia question"

class Trivia
  include Cinch::Plugin

  match /trivia$/
  
    def start
      questions = []
      q = Nokogiri::HTML(open("http://thinkingdigitally.com/archive/computer-science-trivia-questions/"))
      q.at_css("body").traverse do |node|
        if node.text? && (node.parent.name == "strong")
          questions.push(CGI.unescape_html "#{node.content}")
        end
          question = questions.sample
          question
      end
    rescue
      "Houston, we have a problem."
    end

    def execute(m)
      m.reply(start)
    end
end

