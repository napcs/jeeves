require 'test_helper.rb'
require 'imdb'

class ImdbTest < MiniTest::Test

  def test_imdb_returns_tv_show
    WebMock.allow_net_connect!
    output = Imdb.new.get("simpsons")
    assert output.include?("The Simpsons (1989)")
  end

  # def test_imdb_returns_single_word_movie
    # WebMock.allow_net_connect!
    # output = Imdb.new.get("deadpool")
    # assert output.include?("Deadpool (2016)")
  # end

  # def test_imdb_returns_multiple_word_movie
    # WebMock.allow_net_connect!
    # output = Imdb.new.get("last of the mohicans")
    # assert output.include?("The Last of the Mohicans (1992)")
 # end

  # def test_imdb_returns_video_game
    # WebMock.allow_net_connect!
    # output = Imdb.new.get("fallout 4")
    # assert output.include?("Fallout 4 (2015)")
  # end

  # def test_imdb_returns_short_film
    # WebMock.allow_net_connect!
    # output = Imdb.new.get("don cheadle")
    # assert output.include?("Don Cheadle Is Captain Planet (2011)")
  # end

  # def test_imdb_rated_with_hyphen
    # WebMock.allow_net_connect!
    # output = Imdb.new.get("captain america: civil war")
    # assert output.include?("PG-13")
  # end

  # def test_imdb_genre
    # WebMock.allow_net_connect!
    # output = Imdb.new.get("captain america: civil war")
    # assert output.include?("Action, Adventure, Sci-Fi, Thriller")
  # end

  # def test_imdb_description
    # WebMock.allow_net_connect!
    # output = Imdb.new.get("!imdb last samurai")
    # assert output.include?("An American military advisor embraces the Samurai culture he was hired to destroy after he is captured in battle.")
  # end

  # def test_imdb_duration
    # WebMock.allow_net_connect!
    # output = Imdb.new.get("!imdb last samurai")
    # assert output.include?("154 minutes")
  # end

  # def test_imdb_year
    # WebMock.allow_net_connect!
    # output = Imdb.new.get("!imdb last samurai")
    # assert output.include?("(2003)")
  # end

  # def test_imdb_user_rating
    # WebMock.allow_net_connect!
    # output = Imdb.new.get("!imdb last samurai")
    # assert output.include?("/10")
  # end

  # def test_imdb_starring
    # WebMock.allow_net_connect!
    # output = Imdb.new.get("!imdb last samurai")
    # assert output.include?("Starring ")
  # end

  # def test_imdb_error_page
    # WebMock.allow_net_connect!
    # output = Imdb.new.get("!imdb lst smuri")
    # assert.equals("IMDB encountered an error with this title.  Please refine your search or try again later.")
  # end
end
