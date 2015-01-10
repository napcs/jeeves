class IpLookup

  require 'json'
  require 'open-uri'

  include Cinch::Plugin

  match /ip_lookup (.+)/, method: :getInfo


  def getInfo(m, ipAddress)
    url = "http://www.telize.com/geoip/#{ipAddress}"

    begin
      raw_data = open(url).read
      ipInfo = JSON.parse(raw_data)

      output =  "#{ipInfo['longitude']} #{ipInfo['latitude']} #{ipInfo['ip']} #{ipInfo['area_code']} #{ipInfo['continent_code']}  #{ipInfo['timezone']} #{ipInfo['country_code']} #{ipInfo['isp']} #{ipInfo['country']} #{ipInfo['country_code3']}"

    rescue Exception => e
      output = "Something has gone wrong"
    end

    m.reply output

  end
end
