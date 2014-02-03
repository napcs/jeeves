
class Weather
  
  $help_messages << "!weather <zipcode or city,state>    : Displays the weather."
  require 'open-uri'
  require 'json'
  require 'CGI'

  include Cinch::Plugin

  # watch for !weather in the chat
  match /weather (.+)/

  def execute(m, query)
    m.reply(fetch(query))
  end

  def fetch(query)
    url = "http://api.openweathermap.org/data/2.5/weather?q=#{query}&units=imperial"
    begin
      raw_data = open(url).read
      weather_data = JSON.parse(raw_data)
      weather = WeatherData.new(weather_data)
      weather.to_s
    rescue
      "I don't seem to be able to grab the weather for you."
    end

  end

end

class WeatherData
  attr_accessor :city, :temperature, 
    :name, :wind_speed, :wind_degrees,
    :description, :condition

  def initialize(weather_data)
    self.city = weather_data["main"]["temp"]
    self.name = weather_data["name"]
    self.wind_speed = weather_data["wind"]["speed"]
    self.condition = weather_data["weather"]["main"]
    self.description = weather_data["weather"]["description"]
    self.wind_degrees = weather_data["wind"]["deg"]
  end

  def to_s
    "Current temp in #{self.city} is #{self.temperature} degrees."
  end
  

end



