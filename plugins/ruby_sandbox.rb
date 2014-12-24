class RubySandbox

  include Cinch::Plugin

  require 'sicuro'

  $help_messages << "!ruby a = 2; b = 4; puts a + b     Make Jeeves eval some Ruby and return answer to you."
  match /ruby (.+)/

  def execute(message, code)
    result = Sicuro.eval quote(code)
    message.reply result.to_s
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
