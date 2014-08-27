# Get the weather data from openweathermap.org.
class WeatherFetcher
  
  require 'cgi'
  require 'json'
  require 'open-uri'

  # Grab the weather data
  def self.fetch(query)
    query = CGI.escape(query)
    url = "http://api.openweathermap.org/data/2.5/weather?q=#{query}&units=imperial"
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
    :description, :condition

  def initialize(weather_data)
    self.temperature = weather_data["main"]["temp"]
    self.name = weather_data["name"]
    self.wind_speed = weather_data["wind"]["speed"]
    self.condition = weather_data["weather"].first["main"]
    self.description = weather_data["weather"].first["description"]
    self.wind_degrees = weather_data["wind"]["deg"]
  end

  def to_s
    "Current temp in #{self.name} is #{self.temperature} degrees. #{self.condition} - #{self.description}"
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




