class IpFetcher

  require 'json'
  require 'open-uri'

  attr_accessor :ip_address

  def initialize(ip_address)
    @ip_address = ip_address
  end

  def fetch_info
    url = "http://www.telize.com/geoip/#{ip_address}"
    begin
      raw_data = open(url).read
      ip_info = JSON.parse(raw_data)
      output = InfoParser.new(ip_info) 
    rescue SocketError => e 
      output = "Socket error"
    rescue OpenURI::HTTPError => e
      output = "HTTP Error(Is the IP Address formatted properly?)"
    rescue URI::InvalidURIError => e
      output = "Invalid URI Error"
    end
    output
  end
end


class InfoParser
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
    "Longitude: #{@longitude}, Latitude: #{@latitude}, Ip: #{@ip}," + 
    "Area Code: #{@area_code}, Continent: #{@continent_code}," +
    "Timezone: #{@timezone}, ISP: #{@isp}," +
    "Country: #{@country} #{@country_code4}"
  end
end

class IpLookup

  $help_messages << "!ip_lookup <ip address>  :displays information about IP"

  include Cinch::Plugin

  match /ip_lookup (.+)/, method: :fetch_info

  def fetch_info(m,ip_address)
    m.reply IpFetcher.new(ip_address).fetch_info
  end
end
