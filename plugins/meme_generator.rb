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
  REGEX_ALL_THE = /!(.*) (ALL the .*)/i
  REGEX_I_DONT_ALWAYS = /!(i don'?’?t always .*) (but when i do,? .*)/i
  REGEX_NOT_SURE_IF = /!(not sure if .*) (or .*)/i
  REGEX_SHUT_UP = /!(shut up and take my money!?)/i
  REGEX_YOU_ARE_BAD = /!(you are bad and you should feel bad!?)/i
  REGEX_THIS_IS = /!THIS IS (.*!)/i
  REGEX_WONKA = /!(oh,? .*) (tell me .*)/i
  REGEX_Y_U_NO = /!y u no (.+)/i
  REGEX_SIMPLY = /!one does not simply (.*)/i
  REGEX_YO_DAWG = /!(yo dawg,? .*) (so I put .*)/i
  REGEX_WHAT_IF_I = /!what if i told you (.*)/i
  REGEX_BAD_TIME = /!(.*),? (you're going to have a bad time.?)/i
  REGEX_SUCCESS = /!(.*)(SUCCESS!?|NAILED IT!?)/i

  def meme_bad_time(line1)
    generate_meme("Super Cool Ski Instructor", line1, "you're going to have a bad time")
  end

  def meme_all_the(line1, line2)
    generate_meme("X All The Y", line1, line2)
  end

  def meme_i_dont_always(line1, line2)
    generate_meme("The Most Interesting Man In The World", line1, line2)
  end

  def meme_not_sure(line1, line2)
    generate_meme("Futurama Fry", line1, line2)
  end

  def meme_shut_up()
    generate_meme("Shut Up And Take My Money Fry", "SHUT UP AND", "TAKE MY MONEY!")
  end

  def meme_simply(line2)
    generate_meme("One Does Not Simply", "One does not simply", line2)
  end

  def meme_success(line1, line2)
    generate_meme("Success Kid", line1, line2)
  end

  def meme_this_is(line2)
    generate_meme("Sparta Leonidas", "THIS IS", line2)
  end

  def meme_what_if_i(line2)
    generate_meme("Matrix Morpheus", "What if I told you", line2)
  end

  def meme_wonka(line1, line2)
    generate_meme("Condescending Wonka", line1, line2)
  end

  def meme_y_u_no(line2)
    generate_meme("Y U No", "Y U NO", line2)
  end

  def meme_yo_dawg(line1, line2)
    generate_meme("Yo Dawg Heard You", line1, line2)
  end

  def meme_you_are_bad()
    generate_meme("You Should Feel Bad Zoidberg", "You are bad", "and you should feel bad!")
  end

  private

    def generate_meme id, line1, line2
      line1.gsub!("’", "'")
      line2.gsub!("’", "'")
      result = Meme.new(id, line1, line2).url
    end
end



# TODO: rebuild with watchers
#
# !X ALL the ys"
Jeeves.message(contains: MemeGenerator::REGEX_ALL_THE) do |event|
  MemeGenerator::REGEX_ALL_THE.match(event.content)
  line1 = $1
  line2 = $2
  event.respond MemeGenerator.new.meme_all_the(line1, line2)
end

# !I don't always test code, but when I do, it's in production
Jeeves.message(contains: MemeGenerator::REGEX_I_DONT_ALWAYS) do |event|
  MemeGenerator::REGEX_I_DONT_ALWAYS.match(event.content)
  line1 = $1
  line2 = $2
  event.respond MemeGenerator.new.meme_i_dont_always(line1, line2)
end

# !not sure if drunk or sober
Jeeves.message(contains: MemeGenerator::REGEX_NOT_SURE_IF) do |event|
  MemeGenerator::REGEX_NOT_SURE_IF.match(event.content)
  line1 = $1
  line2 = $2
  event.respond MemeGenerator.new.meme_not_sure(line1, line2)
end

# !shut up and take my money
Jeeves.message(contains: MemeGenerator::REGEX_SHUT_UP) do |event|
  event.respond MemeGenerator.new.meme_shut_up
end

Jeeves.message(contains: MemeGenerator::REGEX_YOU_ARE_BAD) do |event|
  event.respond MemeGenerator.new.meme_you_are_bad
end

# !THIS IS DEVOPS!
Jeeves.message(contains: MemeGenerator::REGEX_THIS_IS) do |event|
  MemeGenerator::REGEX_THIS_IS.match(event.content)
  line2 = $1
  event.respond MemeGenerator.new.meme_this_is(line2)
end

# !Oh, you play Call Of Duty? Tell me more about modern warfare.
Jeeves.message(contains: MemeGenerator::REGEX_WONKA) do |event|
  MemeGenerator::REGEX_WONKA.match(event.content)
  line1 = $1
  line2 = $2
  event.respond MemeGenerator.new.meme_wonka(line1, line2)
end


Jeeves.message(contains: MemeGenerator::REGEX_Y_U_NO) do |event|
  MemeGenerator::REGEX_Y_U_NO.match(event.content)
  line2 = $1
  event.respond MemeGenerator.new.meme_y_u_no(line2)
end


# !one does not simply deploy servers
Jeeves.message(contains: MemeGenerator::REGEX_SIMPLY) do |event|
  MemeGenerator::REGEX_SIMPLY.match(event.content)
  line2 = $1
  event.respond MemeGenerator.new.meme_simply(line2)
end

# !Yo dawg, I heard you like terminals so I put a terminal in your terminal so you can terminal while you terminal

Jeeves.message(contains: MemeGenerator::REGEX_YO_DAWG) do |event|
  MemeGenerator::REGEX_YO_DAWG.match(event.content)
  line1 = $1
  line2 = $2
  event.respond MemeGenerator.new.meme_yo_dawg(line1, line2)
end

# "!What if I told you none of this is real?"
Jeeves.message(contains: MemeGenerator::REGEX_WHAT_IF_I) do |event|
  MemeGenerator::REGEX_WHAT_IF_I.match(event.content)
  line2 = $1
  event.respond MemeGenerator.new.meme_what_if_i(line2)
end

#"!If you add two integers before converting them to numbers, you're going to have a bad time"

Jeeves.message(contains: MemeGenerator::REGEX_BAD_TIME) do |event|
  MemeGenerator::REGEX_BAD_TIME.match(event.content)
  line1 = $1
  event.respond MemeGenerator.new.meme_bad_time(line1)
end

# !Tests pass. SUCCESS!
Jeeves.message(contains: MemeGenerator::REGEX_SUCCESS) do |event|
  MemeGenerator::REGEX_SUCCESS.match(event.content)
  line1 = $1
  line2 = $2
  event.respond MemeGenerator.new.meme_success(line1, line2)
end

=begin
  match %r{(.*)(SUCCESS!?|NAILED IT.*)},                            method: :meme_success
=end
