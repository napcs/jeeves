class Expressions

  include Cinch::Plugin

  EXPRESSIONS = {
   shrug: "¯\\_(ツ)_/¯",
   tableflip: "(╯°□°）╯︵ ┻━┻",
   wut: "ಠ_ಠ",
   yeaaah: "( •_•) ( •_•)>⌐■-■ (⌐■_■)"
  }

  EXPRESSIONS.each do |k,v|
    define_method k do |message|
      message.reply v
    end

    $help_messages << "!#{k}\t#{v}"
    match /#{k}/, method: k
  end


end
