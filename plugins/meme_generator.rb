# Meme generator
# Uses apimeme.com.
require 'cgi'
class Meme

  def initialize generator_id, line1 = "", line2 = ""
    @generator_id = CGI.escape(generator_id)
    @line1 = CGI.escape(line1)
    @line2 = CGI.escape(line2)
  end

  def url
    "http://apimeme.com/meme?meme=#{@generator_id}&top=#{@line1}&bottom=#{@line2}"
  end
end

# MemeGenerator plugin
class MemeGenerator

  include Cinch::Plugin

  match %r{(.*) (ALL the .*)}i,                                     method: :meme_all_the
  match %r{(i don'?t always .*) (but when i do,? .*)}i,             method: :meme_i_dont_always
  match %r{(not sure if .*) (or .*)}i,                              method: :meme_not_sure
  match %r{(shut up and take my money!?)}i,                         method: :meme_shut_up
  match %r{(one does not simply) (.*)}i,                            method: :meme_simply
  match %r{(.*)(SUCCESS!?|NAILED IT.*)},                            method: :meme_success
  match %r{(THIS IS .*!)}i,                                         method: :meme_this_is
  match %r{(what if i told you) (.*)}i,                             method: :meme_what_if_i
  match %r{(oh,? .*) (tell me .*)}i,                                method: :meme_wonka
  match %r{(y u no) (.+)}i,                                         method: :meme_y_u_no
  match %r{(yo dawg,? .*) (so I put .*)}i,                          method: :meme_yo_dawg
  #match %r{(you are bad) (and you should feel bad!?)}i,             #method: :meme_you_are_bad                                     method: :meme_you_are_bad

  def meme_all_the(message, line1, line2)
    generate_meme(message, "X ALL THE Y", line1, line2)
  end

  def meme_i_dont_always(message, line1, line2)
    generate_meme(message, "The Most Interesting Man In The World", line1, line2)
  end

  def meme_not_sure(message, line1, line2)
    generate_meme(message, "Futurama Fry", line1, line2)
  end

  def meme_shut_up(message, _ignore)
    generate_meme(message, "Shut Up And Take My Money Fry", "SHUT UP AND", "TAKE MY MONEY!")
  end

  def meme_simply(message, line1, line2)
    generate_meme(message, "One Does Not Simply", line1, line2)
  end

  def meme_success(message, line1, line2)
    generate_meme(message, "Success Kid", line1, line2)
  end

  def meme_this_is(message, text)
    generate_meme(message, "Sparta Leonidas", "THIS IS", text)
  end

  def meme_what_if_i(message, line1, line2)
    generate_meme(message, "Matrix Morpheus", line1, line2)
  end

  def meme_wonka(message, line1, line2)
    generate_meme(message, "Condescending Wonka", line1, line2)
  end

  def meme_y_u_no(message, line1, line2)
    generate_meme(message, "Y U No", line1, line2)
  end

  def meme_yo_dawg(message, line1, line2)
    generate_meme(message, "Yo Dawg Heard You", line1, line2)
  end

  #def meme_you_are_bad(message, line1, line2)
  #  generate_meme(message, "You Should Feel Bad Zoidberg", line1, line2)
  #end

  private

    def generate_meme message, id, line1, line2
      result = Meme.new(id, line1, line2).url
      message.reply result
    end
end
