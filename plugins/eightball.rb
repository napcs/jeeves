class Eightball

  include Cinch::Plugin

  $help_messages << "!8ball <ask your question>"

  match /8ball/


  def answer
    responses = [ 
      "Without question.", 
      "According to my calulations, yes.",
      "Rest assured.", 
      "Yup.", 
      "Looking great.", 
      "I am hearing 'yes'.", 
      "Count on it.",
      "I'm feeling an undeniable yes.",
      "Let me think.. No.", 
      "Question unclear, please refactor and ask again.",
      "Not looking so good.",
      "Sorry, I wasn't listening - ask again.",
      "You don't want to know.", 
      "I'm doubtful at best.",
      "Yes, absolutely.", 
      "Cannot tell at this moment.",
      "Very likely.",
      "Ask again soon.",
      "No",
      "I wouldn't count on it"
    ]
      output = responses.shuffle.first
  end
    

    
  def execute(message)
    message.reply(answer())
  end
      

end
