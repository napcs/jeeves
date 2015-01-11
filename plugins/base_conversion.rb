#Author: Arrio Farugie
#
#BaseConversion: Converts strings into binary or hexadecimal!
#
#Special thanks to: amitchelbullard

class BaseConversion


  include Cinch::Plugin


  $help_messages << "!to_binary:  converts string to binary"
  $help_messages << "!to_hex:  converts string to hexadecimal"
  

  match /to_binary (.+)/, method: :displayBinary
  match /to_hex (.+)/, method: :displayHex


  #fixes rubys concatenated binary bytes, eg. 1 = 1, 2 = 10
  def setLength(binary)
    while binary.length % 8 != 0
      binary = '0' + binary
    end
    return binary  
  end

  
  #create extra spaces around space byte so user can easily see them
  def addSpace(value)
      value = '  ' + value + '  '
  end




  def convertToBinary(message)
    output = Array.new

    message.each_byte do |c| 
      binary = c.to_s(2)

      if binary.length % 8 != 0
        binary = setLength(binary)
      end

      #00100000 = space byte
      if binary == '00100000' 
        binary = addSpace(binary)
      end

      output.push binary
    end
      output.join(' ')
  end




  def convertToHex(message)
    output = Array.new

    message.each_byte do |c| 
      hex = c.to_s(16)

      #20 = space byte
      if hex == '20' 
        hex = addSpace(hex)
      end

      output.push hex
    end
     output.join(' ')
  end


  def displayBinary(m, message)
    m.reply convertToBinary(message)
  end

  def displayHex(m, message)
    m.reply convertToHex(message)
  end

end
