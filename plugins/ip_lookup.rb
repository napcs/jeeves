class IPLookup
  require 'json'
  require 'open-uri'

  def fetchInfo(ipAddress)
    url = "http://ip-api.com/json/#{ipAddress}"

    begin
      raw_data = URI.open(url).read
      ipInfo = JSON.parse(raw_data)


    # {"status"=>"success",
    #  "country"=>"United States",
    #  "countryCode"=>"US",
    #  "region"=>"VA",
    #  "regionName"=>"Virginia",
    #  "city"=>"Ashburn",
    #  "zip"=>"20149",
    #  "lat"=>39.03,
    #  "lon"=>-77.5,
    #  "timezone"=>"America/New_York",
    #  "isp"=>"Google LLC",
    #  "org"=>"Google Public DNS",
    #  "as"=>"AS15169 Google LLC",
    #  "query"=>"8.8.8.8"}

      output = "Results for #{ipInfo['query']}:\n"
      output << "Organization: #{ipInfo['org']}\n"
      output << "ISP: #{ipInfo['isp']}\n"
      output << "Latitude: #{ipInfo['lat']}\n"
      output << "Longitude: #{ipInfo['lon']}\n"
      output << "ZIP: #{ipInfo['zip']}\n"
      output << "Region: #{ipInfo['regionName']}\n"
      output << "Country: #{ipInfo['country']}\n"
      output << "Timezone: #{ipInfo['timezone']}"

    rescue SocketError => e
      output = "Socket error"
    rescue OpenURI::HTTPError => e
      output = "Argument Error"
    end

    output
  end
end

$help_messages << "!ip_lookup <ip address>: displays information about IP"

Jeeves.command :ip_lookup do |event, ip|
  IPLookup.new.fetchInfo(ip)
end

