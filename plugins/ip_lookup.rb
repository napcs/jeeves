class IpLookup

  require 'json'
  require 'open-uri'

  include Cinch::Plugin

  $help_messages << "!ip_lookup <ip address>: displays information about IP"
  
  match /ip_lookup (.+)/


  def fetchInfo(ipAddress)
    url = "http://www.telize.com/geoip/#{ipAddress}"

    begin
      raw_data = open(url).read
      ipInfo = JSON.parse(raw_data)

      output =  "Longitude: #{ipInfo['longitude']}, Latitude: #{ipInfo['latitude']}, Ip: #{ipInfo['ip']}, Area Code: #{ipInfo['area_code']}, Continent: #{ipInfo['continent_code']}, Timezone: #{ipInfo['timezone']}, ISP: #{ipInfo['isp']}, Country: #{ipInfo['country']} #{ipInfo['country_code4']}"

    rescue SocketError => e 
      output = "Socket error"
    rescue OpenURI::HTTPError => e
      output = "Argument Error"
    end

    output
  end

  def execute(m, ipAddress)
    m.reply(fetchInfo(ipAddress))
  end

    private :fetchInfo
end
