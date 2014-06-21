# Countdown plugin
class Countdown
  require 'active_support/core_ext'
  require 'tzinfo'

  # include the Cinch::Plugin mixin which 
  include Cinch::Plugin

  $help_messages << "!set_deadline  yyyy-mm-dd hh:mm:   Make Jeeves keep time."
  $help_messages << "!time_left           : How much time is left?"


  match /time_left$/

  match /set_deadline (.+)/
  def execute(message, date=nil)
    
    if date
      begin
        tz = TZInfo::Timezone.get('America/Chicago')
        time = date.to_time
        message.reply("Deadline set for #{time}")
        $countdown_end_date = tz.local_to_utc(time) 
      rescue ArgumentError => e
        message.reply("Please use the format #{Time.now.strftime("Y-m-d h:s")} for this.")
      end

    else
      message.reply(time_diff(Time.now, $countdown_end_date))
    end
   
  end

  private
    def time_diff(start_time, end_time)
      seconds_diff = (start_time - end_time).to_i.abs

      hours = seconds_diff / 3600
      seconds_diff -= hours * 3600

      minutes = seconds_diff / 60
      seconds_diff -= minutes * 60

      seconds = seconds_diff

      "#{hours.to_s.rjust(2, '0')} hours, #{minutes.to_s.rjust(2, '0')} minutes, and #{seconds.to_s.rjust(2, '0')} seconds to go!"
    end

end
