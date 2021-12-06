class Expressions

  EXPRESSIONS = {
   shrug: "¯\\_(ツ)_/¯",
   tableflip: "(╯°□°）╯︵ ┻━┻",
   wut: "ಠ_ಠ",
   yeaaah: "( •_•) ( •_•)>⌐■-■ (⌐■_■)"
  }

  EXPRESSIONS.each do |k,v|
    define_method k do
      v
    end
  end
end

Expressions::EXPRESSIONS.each do |k, v|
  $help_messages << "!#{k}\t#{v}"
  Jeeves.command k.to_sym do |event|
    Expressions.new.send k.to_sym
  end
end
