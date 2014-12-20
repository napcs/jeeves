class Rimshot

  include Cinch::Plugin

  match /rimshot$/

  def execute(message)
    message.reply("http://instantrimshot.com/classic/?sound=rimshot?play=true")
  end
end
