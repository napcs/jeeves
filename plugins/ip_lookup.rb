class IpFetcher
  require 'json'
  require 'open-uri'

  def self.fetchInfo(ipAddress)
    url = "http://www.telize.com/geoip/#{ipAddress}"
    begin
      raw_data = open(url).read
      ip_info = JSON.parse(raw_data)
      output = IpInfo.new(ip_info) 
    rescue SocketError => e 
      output = "Socket error #{e.message}"
    rescue OpenURI::HTTPError => e
      output = "Argument Error #{e.message}"
    rescue URI::InvalidURIError => e
      output = "Argument Error #{e.message}"
    end
    output
  end
end


class IpInfo
  attr_accessor :longitude, :latitude, 
    :ip, :area_code, :continent_code,
    :timezone, :isp, :country, :country_code4

  def initialize(ip_info)
    self.longitude = ip_info['longitude']
    self.latitude = ip_info['latitude']
    self.ip = ip_info['ip']
    self.area_code = ip_info['area_code']
    self.continent_code = ip_info['continent_code']
    self.timezone = ip_info['timezone']
    self.isp = ip_info['isp']
    self.country = ip_info['country']
    self.country_code4 = ip_info['country_code4']
  end
    
  def to_s
    "Longitude: #{self.longitude}, Latitude: #{self.latitude}, Ip: #{self.ip}, Area Code: #{self.area_code}, Continent: #{self.continent_code}, Timezone: #{self.timezone}, ISP: #{self.isp}, Country: #{self.country} #{self.country_code4}"
  end
end
    
class IpLookup

  $help_messages << "!ip_lookup <ip address>: displays information about IP"

  include Cinch::Plugin

  match /ip_lookup (.+)/

  def execute(m, ipAddress)
    m.reply(fetchInfo(ipAddress))
  end

  def fetchInfo(ipAddress)
    ipInfo = IpFetcher.fetchInfo(ipAddress)
    ipInfo.to_s
  end

end


     

