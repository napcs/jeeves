require 'test_helper.rb'
require 'imdb'

class ImdbTest < MiniTest::Test

	def test_imdb_returns_tv_show
		bot = make_bot(Imdb)
    message = make_message(bot, "!imdb simpsons")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("The Simpsons (1989)")
	end

	def test_imdb_returns_single_word_movie
		bot = make_bot(Imdb)
    message = make_message(bot, "!imdb deadpool")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("Deadpool (2016)")
	end

	def test_imdb_returns_multiple_word_movie
		bot = make_bot(Imdb)
    message = make_message(bot, "!imdb last of the mohicans")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("The Last of the Mohicans (1992)")
	end

	def test_imdb_returns_video_game
		bot = make_bot(Imdb)
    message = make_message(bot, "!imdb fallout 4")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("Fallout 4 (2015)")
	end

	def test_imdb_returns_short_film
		bot = make_bot(Imdb)
    message = make_message(bot, "!imdb don cheadle")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("Don Cheadle Is Captain Planet (2011)")
	end

	def test_imdb_rated_with_hyphen
		bot = make_bot(Imdb)
    message = make_message(bot, "!imdb captain america: civil war")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("PG-13")
	end

	def test_imdb_genre
		bot = make_bot(Imdb)
    message = make_message(bot, "!imdb captain america: civil war")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("Action, Adventure, Sci-Fi, Thriller")
	end

	def test_imdb_description
		bot = make_bot(Imdb)
    message = make_message(bot, "!imdb last samurai")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("An American military advisor embraces the Samurai culture he was hired to destroy after he is captured in battle.")
	end

	def test_imdb_duration
		bot = make_bot(Imdb)
    message = make_message(bot, "!imdb last samurai")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("154 minutes")
	end

	def test_imdb_year
		bot = make_bot(Imdb)
    message = make_message(bot, "!imdb last samurai")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("(2003)")
	end

	def test_imdb_user_rating
		bot = make_bot(Imdb)
    message = make_message(bot, "!imdb last samurai")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("/10")
	end

	def test_imdb_starring
		bot = make_bot(Imdb)
    message = make_message(bot, "!imdb last samurai")
    replies = get_replies(message)
    output = get_replies(message).first
    assert output.include?("Starring ")
	end

		def test_imdb_error_page
		bot = make_bot(Imdb)
    message = make_message(bot, "!imdb lst smuri")
    replies = get_replies(message)
    assert.equals("IMDB encountered an error with this title.  Please refine your search or try again later.")
	end
end