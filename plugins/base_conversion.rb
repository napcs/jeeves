class StringConverter
  attr_accessor :string_value

  def initialize(string_value)
    @string_value = string_value
  end

  def convert(base)
    output = Array.new
    @string_value.each_byte do|c|
      binary = c.to_s(base)
      output.push binary
    end
    output.join(' ')
  end

  def to_binary
    convert(2)
  end

  def to_hex
    convert(16)
  end
end


class BinaryConverter
  attr_accessor :binary_value

  def initialize(binary_value)
    @binary_value = binary_value
  end

  def to_int
    output = Array.new
    tempValue = @binary_value.split(' ')
    tempValue.each do |a|
      output.push a.to_i(2)
    end
    output.join(' ')
  end

  def to_string
    output = Array.new
    tempValue = @binary_value.delete(' ').scan(/.{8}|.+/).join(' ').split(' ')
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

  match /to_binary (.+)/, method: :string_to_binary
  match /to_hex (.+)/, method: :string_to_hex
  match /binary_to_integer (.+)/, method: :binary_to_integer
  match /binary_to_string (.+)/, method: :binary_to_string

  def string_to_binary(m, message)
    m.reply StringConverter.new(message).to_binary
  end

  def string_to_hex(m, message)
    m.reply StringConverter.new(message).to_hex
  end

  def binary_to_integer(m, message)
    m.reply BinaryConverter.new(message).to_int
  end

  def binary_to_string(m, message)
    m.reply BinaryConverter.new(message).to_string
  end
 end

