class IpFetcher
  require 'json'
  require 'open-uri'

  def self.fetch_info(ipAddress)
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
    @longitude = ip_info['longitude']
    @latitude = ip_info['latitude']
    @ip = ip_info['ip']
    @area_code = ip_info['area_code']
    @continent_code = ip_info['continent_code']
    @timezone = ip_info['timezone']
    @isp = ip_info['isp']
    @country = ip_info['country']
    @country_code4 = ip_info['country_code4']
  end
    
  def to_s
    "Longitude: #{@longitude}, Latitude: #{@latitude}, Ip: #{@ip}, Area Code: #{@area_code}, Continent: #{@continent_code}, Timezone: #{@timezone}, ISP: #{@isp}, Country: #{@country} #{@country_code4}"
  end
end
    
class IpLookup

  $help_messages << "!ip_lookup <ip address>  :displays information about IP"

  include Cinch::Plugin

  match /ip_lookup (.+)/, method: :fetch_info

  def fetch_info(m,ipAddress)
    m.reply IpFetcher.fetch_info(ipAddress).to_s
  end
end


     

