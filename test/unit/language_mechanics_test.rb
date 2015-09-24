# Include the test setup:
require 'test_helper.rb'

# include the plugin you are testing
require 'language_mechanics'

# Define the test class
class LanguageMechanicsTest < MiniTest::Test

  # Define your first test case.
  
  def test_comma_inside_of_quotation
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, '"hello,"')
    replies = get_replies(message)
    assert_equal nil, replies.first
  end

  def test_comma_outside_of_quotation
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, '"hello",')
    replies = get_replies(message)
    assert_equal "It is correct to keep the punctuation inside of the quotations, not outside of them.", replies.first
  end

  def test_comma_outside_of_quotation_with_space_ending_the_quote
   bot = make_bot(LanguageMechanics)
   message = make_message(bot, '"hello ",')
   replies = get_replies(message)
   assert_equal "It is correct to keep the punctuation inside of the quotations, not outside of them.", replies.first
  end

  def test_ellipses_inside_of_quotation_begin
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, '"...ok"')
    replies = get_replies(message)
    assert_equal nil, replies.first
  end

  def test_ellipses_inside_of_quotation_end
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, '"ok..."')
    replies = get_replies(message)
    assert_equal nil, replies.first
  end

  def test_ellipses_outside_of_quotation
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, '"ok"...')
    replies = get_replies(message)
    assert_equal nil, replies.first
  end

  def test_ellipses_outside_of_quotation_with_space_between_outside_quotes
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, '"ok" ...')
    replies = get_replies(message)
    assert_equal nil, replies.first
  end

  def test_exclamation_point_inside_of_quotation
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, '"hello!"')
    replies = get_replies(message)
    assert_equal nil, replies.first
  end

  def test_exclamation_point_outside_of_quotation
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, '"hello"!')
    replies = get_replies(message)
    assert_equal "It is correct to keep the punctuation inside of the quotations, not outside of them.", replies.first
  end

  def test_exclamation_point_outside_of_quotation_with_space_ending_the_quote
   bot = make_bot(LanguageMechanics)
   message = make_message(bot, '"hello "!')
   replies = get_replies(message)
   assert_equal "It is correct to keep the punctuation inside of the quotations, not outside of them.", replies.first
  end

  def test_period_inside_of_quotation
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, '"hello."')
    replies = get_replies(message)
    assert_equal nil, replies.first
  end

  def test_period_outside_of_quotation
   bot = make_bot(LanguageMechanics)
   message = make_message(bot, '"hello".')
   replies = get_replies(message)
   assert_equal "It is correct to keep the punctuation inside of the quotations, not outside of them.", replies.first
  end

  def test_period_outside_of_quotation_with_space_after_period
   bot = make_bot(LanguageMechanics)
   message = make_message(bot, '"hello". ')
   replies = get_replies(message)
   assert_equal "It is correct to keep the punctuation inside of the quotations, not outside of them.", replies.first
  end

  def test_period_outside_of_quotation_with_space_ending_the_quote
   bot = make_bot(LanguageMechanics)
   message = make_message(bot, '"hello ".')
   replies = get_replies(message)
   assert_equal "It is correct to keep the punctuation inside of the quotations, not outside of them.", replies.first
  end

  def test_question_mark_inside_of_quotation
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, '"hello?"')
    replies = get_replies(message)
    assert_equal nil, replies.first
  end

  def test_question_mark_outside_of_quotation
   bot = make_bot(LanguageMechanics)
   message = make_message(bot, '"hello"?')
   replies = get_replies(message)
   assert_equal "It is correct to keep the punctuation inside of the quotations, not outside of them.", replies.first
  end

  def test_question_mark_outside_of_quotation_with_space_ending_the_quote
   bot = make_bot(LanguageMechanics)
   message = make_message(bot, '"hello "?')
   replies = get_replies(message)
   assert_equal "It is correct to keep the punctuation inside of the quotations, not outside of them.", replies.first
  end

  def test_quotation_no_punctuation
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, '"hello"')
    replies = get_replies(message)
    assert_equal nil, replies.first
  end

  def test_alot
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, 'alot')
    replies = get_replies(message)
    assert_equal "To refer to many of something please use \"a lot.\"  To refer to setting aside money please use \"allot.\"", replies.first
  end

  def test_ass
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, 'ass')
    replies = get_replies(message)
    assert_equal "Unless you're referring to a donkey, please use a more courteous word. Options include \"arse\" and \"bum.\"", replies.first
  end

  def test_ass_in_assassin
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, 'assassin')
    replies = get_replies(message)
    assert_equal nil, replies.first
  end

  def test_ass_in_asshat
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, 'asshat')
    replies = get_replies(message)
    assert_equal nil, replies.first
  end

  def test_ass_in_assface
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, 'assface')
    replies = get_replies(message)
    assert_equal nil, replies.first
  end

  def test_ass_in_class
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, 'class')
    replies = get_replies(message)
    assert_equal nil, replies.first
  end

  def test_ass_in_classes
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, 'classes')
    replies = get_replies(message)
    assert_equal nil, replies.first
  end

  def test_ass_in_sentence_beginning
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, 'Ass hole')
    replies = get_replies(message)
    assert_equal "Unless you're referring to a donkey, please use a more courteous word. Options include \"arse\" and \"bum.\"", replies.first
  end

  def test_ass_in_sentence_ending
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, 'You are an ass')
    replies = get_replies(message)
    assert_equal "Unless you're referring to a donkey, please use a more courteous word. Options include \"arse\" and \"bum.\"", replies.first
  end

  def test_ass_in_sentence_middle
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, 'You are an ass hole')
    replies = get_replies(message)
    assert_equal "Unless you're referring to a donkey, please use a more courteous word. Options include \"arse\" and \"bum.\"", replies.first
  end

  def test_coulda

    # Create a bot. Pass the class name of your plugin
    bot = make_bot(LanguageMechanics)

    # Send the bot a message
    message = make_message(bot, 'coulda')

    # Get the response
    replies = get_replies(message)

    # now do your assertion
    # Your username is 'test'
    assert_equal "Please use \"could have\" or \"could've.\"", replies.first

  end

  def test_couldve

    # Create a bot. Pass the class name of your plugin
    bot = make_bot(LanguageMechanics)

    # Send the bot a message
    message = make_message(bot, 'couldve')

    # Get the response
    replies = get_replies(message)

    # now do your assertion
    # Your username is 'test'
    assert_equal "Don't forget your apostrophe!", replies.first

  end

  def test_fuck

    # Create a bot. Pass the class name of your plugin
    bot = make_bot(LanguageMechanics)

    # Send the bot a message
    message = make_message(bot, 'fuck')

    # Get the response
    replies = get_replies(message)

    # now do your assertion
    # Your username is 'test'
    assert_equal "I think you meant \"fudge.\"", replies.first

  end

  def test_if_i_was

    bot = make_bot(LanguageMechanics)
    message = make_message(bot, 'if i was')
    replies = get_replies(message)
    assert_equal "Please use the subjunctive.  The correct way to say this is \"if I were.\"", replies.first

  end

  def test_irregardless
    bot = make_bot(LanguageMechanics)
    message = make_message(bot, 'irregardless')
    replies = get_replies(message)
    assert_equal "\"Irregardless\" is not a word. Please use \"regardless.\"", replies.first
  end

  def test_l8r

    # Create a bot. Pass the class name of your plugin
    bot = make_bot(LanguageMechanics)

    # Send the bot a message
    message = make_message(bot, 'l8r')

    # Get the response
    replies = get_replies(message)

    # now do your assertion
    # Your username is 'test'
    assert_equal "Please type as if you were writing a professional email to a colleague.", replies.first

  end

  def test_peaked_my

    # Create a bot. Pass the class name of your plugin
    bot = make_bot(LanguageMechanics)

    # Send the bot a message
    message = make_message(bot, 'peaked my')

    # Get the response
    replies = get_replies(message)

    # now do your assertion
    # Your username is 'test'
    assert_equal "The word is \"piqued.\"", replies.first

  end

  def test_peeked_my

    # Create a bot. Pass the class name of your plugin
    bot = make_bot(LanguageMechanics)

    # Send the bot a message
    message = make_message(bot, 'peeked my')

    # Get the response
    replies = get_replies(message)

    # now do your assertion
    # Your username is 'test'
    assert_equal "The word is \"piqued.\"", replies.first

  end

  def test_shit

    # Create a bot. Pass the class name of your plugin
    bot = make_bot(LanguageMechanics)

    # Send the bot a message
    message = make_message(bot, 'shit')

    # Get the response
    replies = get_replies(message)

    # now do your assertion
    # Your username is 'test'
    assert_equal "I think you meant \"shiitake.\"", replies.first

  end

  def test_shoulda

    # Create a bot. Pass the class name of your plugin
    bot = make_bot(LanguageMechanics)

    # Send the bot a message
    message = make_message(bot, 'You shoulda come over')

    # Get the response
    replies = get_replies(message)

    # now do your assertion
    # Your username is 'test'
    assert_equal "Please use \"should have\" or \"should've.\"", replies.first

  end

  def test_shouldve

    # Create a bot. Pass the class name of your plugin
    bot = make_bot(LanguageMechanics)

    # Send the bot a message
    message = make_message(bot, 'You shouldve come over')

    # Get the response
    replies = get_replies(message)

    # now do your assertion
    # Your username is 'test'
    assert_equal "Don't forget your apostrophe!", replies.first

  end

  def test_sneak_peak

    # Create a bot. Pass the class name of your plugin
    bot = make_bot(LanguageMechanics)

    # Send the bot a message
    message = make_message(bot, 'Sneak peak')

    # Get the response
    replies = get_replies(message)

    # now do your assertion
    # Your username is 'test'
    assert_equal "Sneak peek, not sneak peak. Please visit https://twitter.com/stealthmountain for more information on this.", replies.first

  end

  def test_sneek_peak

    # Create a bot. Pass the class name of your plugin
    bot = make_bot(LanguageMechanics)

    # Send the bot a message
    message = make_message(bot, 'Sneek peak')

    # Get the response
    replies = get_replies(message)

    # now do your assertion
    # Your username is 'test'
    assert_equal "Sneak peek, not sneek peak. Please visit https://twitter.com/stealthmountain for more information on this.", replies.first

  end

  def test_sneek_peek

    # Create a bot. Pass the class name of your plugin
    bot = make_bot(LanguageMechanics)

    # Send the bot a message
    message = make_message(bot, 'Sneek peek')

    # Get the response
    replies = get_replies(message)

    # now do your assertion
    # Your username is 'test'
    assert_equal "Sneak peek, not sneek peek. Please visit https://twitter.com/stealthmountain for more information on this.", replies.first

  end

  def test_whos_is
    bot=make_bot(LanguageMechanics)
    message=make_message(bot, 'who\'s is')
    replies=get_replies(message)
    assert_equal "\"Who\'s is\" refers to \"Who is.\"  You'll want to use \"whose.\"", replies.first
  end

  def test_wtf

    # Create a bot. Pass the class name of your plugin
    bot = make_bot(LanguageMechanics)

    # Send the bot a message
    message = make_message(bot, 'wtf')

    # Get the response
    replies = get_replies(message)

    # now do your assertion
    # Your username is 'test'
    #
    # THIS IS FAILING BECAUSE RAKE TEST IS ALSO RUNNING THE MEME GENERATOR TEST, WHICH IS NOT WORKING
    assert_equal "What does this even mean? Please type it out in full.", replies.first
    #assert_equal "http://apimeme.com/meme?meme=One+Does+Not+Simply&top=One+Does+Not+Simply&bottom=Abbreviate+Anger", replies.first
    #assert_equal "* grammar_snob would like you to review this website https://www.grammarly.com", replies.first

  end


end