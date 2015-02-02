class String
  attr_accessor :string
  def initialize(string)
    @string = string
  end
  def convert(base)
    output = Array.new
    @string.each_byte do|c|
      binary = c.to_s(base)
      output.push binary
    end
    output.join(' ')
  end
  def toBinary
    convert(2)
  end
  def toHex
    convert(16)
  end
end

class Binary
  attr_accessor :value
  def initialize(value)
    @value = value
  end
  def toInt
    output = Array.new
    tempValue = @value.split(' ')
    tempValue.each do |a|
      output.push a.to_i(2)
    end
    output.join(' ')
  end
  def toString
    output = Array.new
    tempValue = @value.scan(/.{8}|.+/).join(' ').split(' ')
    tempValue.each do |a|
      output.push a.to_i(2).chr
    end
    output.join
  end
end

class BaseConversion
  include Cinch::Plugin
  $help_messages << "!to_binary   :converts string to binary"
  $help_messages << "!to_hex :converts string to hex"
  $help_messages << "!binary_to_integer :converts binary to integer"
  $help_messages << "!binary_to_string  :converts binary to string"

  match /to_binary (.+)/, method: :toBinary
  match /to_hex (.+)/, method: :toHex
  match /binary_to_integer (.+)/, method: :binaryToInteger
  match /binary_to_string (.+)/, method: :binaryToString

  def toBinary(m, message)
    m.reply String.new(message).toBinary
  end
  def toHex(m, message)
    m.reply String.new(message).toHex
  end
  def binaryToInteger(m, message)
    m.reply Binary.new(message).toInt
  end
  def binaryToString(m, message)
    m.reply Binary.new(message).toString
  end
end

