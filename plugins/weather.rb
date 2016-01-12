# Get the weather data from openweathermap.org.
class WeatherFetcher

  require 'cgi'
  require 'json'
  require 'open-uri'

  # Grab the weather data
  def self.fetch(query)
    query = CGI.escape(query)
    key = $settings["settings"]["open_weather_key"]
    url = "http://api.openweathermap.org/data/2.5/weather?q=#{query}&units=imperial&appid=#{key}"
    begin
      raw_data = open(url).read
      weather_data = JSON.parse(raw_data)
      result = WeatherData.new(weather_data)
    rescue Exception => e
      result = "I don't seem to be able to grab the weather for you. #{e.message}"
    end
    result
  end

end

# represent,  parse, and interpret/present the weather data
class WeatherData
  attr_accessor :city, :temperature,
    :name, :wind_speed, :wind_degrees,
    :description, :condition, :wind_cardinal

  def initialize(weather_data)
    self.temperature = weather_data["main"]["temp"]
    self.name = weather_data["name"]
    self.wind_speed = weather_data["wind"]["speed"]
    self.condition = weather_data["weather"].first["main"]
    self.description = weather_data["weather"].first["description"]
    self.wind_degrees = weather_data["wind"]["deg"]
    self.wind_cardinal = get_cardinal(self.wind_degrees)
  end

  def to_s
    "Current temp in #{self.name} is #{self.temperature} degrees. The wind is blowing #{self.wind_cardinal} at #{self.wind_speed} mps. #{self.condition} - #{self.description}"
  end

  def get_cardinal(wind_degrees)
    case wind_degrees
      when 348.75..11.26 then "N"
      when 11.25..33.76 then "NNE"
      when 33.75..56.26 then "NE"
      when 56.25..78.76 then "ENE"
      when 78.75..101.26 then "E"
      when 101.25..123.76 then "ESE"
      when 123.75..146.26 then "SE"
      when 146.25..168.76 then "SSE"
      when 168.75..191.26 then "S"
      when 191.25..213.76 then "SSW"
      when 213.75..236.26 then "SW"
      when 236.25..258.76 then "WSW"
      when 258.75..281.26 then "W"
      when 281.25..303.76 then "WNW"
      when 303.75..326.26 then "NW"
      when 326.25..348.76 then "NNW"
    end
 end


end
# The plugin
class Weather

  $help_messages << "!weather <zipcode or city,state>    : Displays the weather."

  include Cinch::Plugin

  # watch for !weather in the chat
  match /weather (.+)/

  def execute(m, query)
    m.reply(fetch(query))
  end

  def fetch(query)
    weather = WeatherFetcher.fetch(query)
    weather.to_s
  end

end



