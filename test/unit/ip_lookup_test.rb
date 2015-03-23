#require 'test_helper.rb'

#require 'ip_lookup'

#class IpLookupTest < MiniTest::Test

  #def test_ip_lookup

    #WebMock.allow_net_connect!

    #bot = make_bot(IpLookup)
    #message = make_message(bot, '!ip_lookup 46.19.37.108')
    #replies = get_replies(message)

    #assert_equal "Longitude: 4.9, Latitude: 52.3667, Ip: 46.19.37.108,Area Code: 0, Continent: EU,Timezone: Europe/Amsterdam, ISP: Tilaa B.V.,Country: Netherlands ", replies.first.to_s
  #end

  #def test_ip_address_too_short
    #WebMock.allow_net_connect!

    #bot = make_bot(IpLookup)
    #message = make_message(bot, '!ip_lookup 46.19.37')
    #replies = get_replies(message)

    #assert_equal "HTTP Error(Is the IP Address formatted properly?)", replies.first
  #end

  #def test_ip_address_too_many_sets_of_numbers
    #WebMock.allow_net_connect!

    #bot = make_bot(IpLookup)
    #message = make_message(bot, '!ip_lookup 46.19.37.100.1')
    #replies = get_replies(message)

    #assert_equal "HTTP Error(Is the IP Address formatted properly?)", replies.first
  #end
  
  #def test_ip_address_with_too_many_numbers_in_set
    #WebMock.allow_net_connect!

    #bot = make_bot(IpLookup)
    #message = make_message(bot, '!ip_lookup 46.19.37.1001')
    #replies = get_replies(message)

    #assert_equal "HTTP Error(Is the IP Address formatted properly?)", replies.first
  #end


  ##stub_request(:get, "http://www.telize.com/geoip/46.19.37.108").
  ##with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
  ##to_return(:status => 200, :body => "", :headers => {})

#end
