class IpLookup

  require 'json'
  require 'open-uri'

  include Cinch::Plugin

  $help_messages << "!ip_lookup <ip address> displays information about IP"
  
  match /ip_lookup (.+)/, method: :getInfo


  def getInfo(m, ipAddress)
    url = "http://www.telize.com/geoip/#{ipAddress}"

    begin
      raw_data = open(url).read
      ipInfo = JSON.parse(raw_data)

      output =  "Longitude: #{ipInfo['longitude']}, Latitude: #{ipInfo['latitude']}, Ip: #{ipInfo['ip']}, Area Code: #{ipInfo['area_code']}, Continent: #{ipInfo['continent_code']}, Timezone: #{ipInfo['timezone']}, ISP: #{ipInfo['isp']}, Country: #{ipInfo['country']} #{ipInfo['country_code3']}"

    rescue Exception => e
      output = "Something has gone wrong"
    end

    m.reply output

  end
end
