
# Look for horrible grammar used in the chat.
class LanguageMechanics

  # Array to include memes from meme_generator.rb in responses
  #typos = {
  #  "wtf" => {
  #    :simply => ["One Does Not Simply", "One Does Not Simply", "Abbreviate Anger"]
  #  }
  #}


  #This outputs twice for some reason
  def comma_outside_double_quote(message)
    message.reply("It is correct to keep the punctuation inside of the quotations, not outside of them.")
  end

  def ellipsis_outside_double_quote(message)
    message.reply("It is correct to keep the punctuation inside of the quotations, not outside of them.")
  end

  def ellipsis_outside_double_quote_with_space(message)
    message.reply("It is correct to keep the punctuation inside of the quotations, not outside of them.")
  end
  #This outputs twice for some reason
  def exclamation_point_outside_double_quote(message)
    message.reply("It is correct to keep the punctuation inside of the quotations, not outside of them.")
  end

  def period_outside_double_quote(message)
    message.reply("It is correct to keep the punctuation inside of the quotations, not outside of them.")
  end

  def period_outside_double_quote_with_space_after_the_period(message)
    message.reply("It is correct to keep the punctuation inside of the quotations, not outside of them.")
  end

  def period_outside_double_quote_with_space_ending_the_quote(message)
    message.reply("It is correct to keep the punctuation inside of the quotations, not outside of them.")
  end
  #This outputs twice for some reason
  def question_mark_outside_double_quote(message)
    message.reply("It is correct to keep the punctuation inside of the quotations, not outside of them.")
  end

  def alot(message)
    message.reply("To refer to many of something please use \"a lot.\"  To refer to setting aside money please use \"allot.\"")
  end

  def ass(message)
    message.reply("Unless you're referring to a donkey, please use a more courteous word. Options include \"arse\" and \"bum.\"")
  end

  def coulda(message)
    message.reply("Please use \"could have\" or \"could've.\"")
  end

  def couldve(message)
    message.reply("Don't forget your apostrophe!")
  end

  def fuck(message)
    message.reply("I think you meant \"fudge.\"")
  end

  def if_i_was(message)
    message.reply("Please use the subjunctive.  The correct way to say this is \"if I were.\"")
  end

  def irregardless(message)
    message.reply("\"Irregardless\" is not a word. Please use \"regardless.\"")
  end

  def l8r(message)
    message.reply("Please type as if you were writing a professional email to a colleague.")
  end

  def peaked_my(message)
    message.reply("The word is \"piqued.\"")
  end

  def peeked_my(message)
    message.reply("The word is \"piqued.\"")
  end

  def shit(message)
    message.reply("I think you meant \"shiitake.\"")
  end

  def shoulda(message)
    message.reply("Please use \"should have\" or \"should\'ve.\"")
  end

  def shouldve(message)
    message.reply("Don\'t forget your apostrophe!")
  end

  def sneakpeak(message)
    message.reply("Sneak peek, not sneak peak. Please visit https://twitter.com/stealthmountain for more information on this.")
  end

  def sneekpeak(message)
    message.reply("Sneak peek, not sneek peak. Please visit https://twitter.com/stealthmountain for more information on this.")
  end

  def sneekpeek(message)
    message.reply("Sneak peek, not sneek peek. Please visit https://twitter.com/stealthmountain for more information on this.")
  end

  def whos_is(message)
    message.reply("\"Who\'s is\" refers to \"Who is.\"  You'll want to use \"whose.\"")
  end

  def wtf(message)
    message.reply("What does this even mean? Please type it out in full.")
    meme = Meme.new("One Does Not Simply", "One Does Not Simply", "Abbreviate Anger").url
    message.reply(meme)
    message.action_reply("would like you to review this website https://www.grammarly.com")
  end

end
  # look for poor grammar
  # This uses a regular expression.

#TODO: rework this to use event watches.
=begin

  match /\b",(\s)?/, method: :comma_outside_double_quote, use_prefix: false
  match /(\b|\s)?"!(\s|$)?/, method: :exclamation_point_outside_double_quote, use_prefix: false
  match /\b". (\s|$)?/, method: :period_outside_double_quote_with_space_after_the_period, use_prefix: false
  match /\b ".(\s|$)?/, method: :period_outside_double_quote_with_space_ending_the_quote, use_prefix: false
  match /\b".$/, method: :period_outside_double_quote, use_prefix: false
  match /\b".\s/, method: :period_outside_double_quote, use_prefix: false
  match /(\b|\s)?"\?(\s|$)?/, method: :question_mark_outside_double_quote, use_prefix: false
  match /\balot\b/i, method: :alot, use_prefix: false
  match /\bass\b/i, method: :ass, use_prefix: false
  match /coulda/i, method: :coulda, use_prefix: false
  match /couldve/i, method: :couldve, use_prefix: false
  match /\bfuck\b/i, method: :fuck, use_prefix: false
  match /if i was/i, method: :if_i_was, use_prefix: false
  match /irregardless/i, method: :irregardless, use_prefix: false
  match /l8r/i, method: :l8r, use_prefix: false
  match /peaked my/i, method: :peaked_my, use_prefix: false
  match /peeked my/i, method: :peeked_my, use_prefix: false
  match /shouldve/i, method: :shouldve, use_prefix: false
  match /shoulda/i, method: :shoulda, use_prefix: false
  match /sneak peak/i, method: :sneakpeak, use_prefix: false
  match /sneek peak/i, method: :sneekpeak, use_prefix: false
  match /sneek peek/i, method: :sneekpeek, use_prefix: false
  match /\bshit\b/i, method: :shit, use_prefix: false
  match /who's is/i, method: :whos_is, use_prefix: false
  match /wtf/i, method: :wtf, use_prefix: false

=end


