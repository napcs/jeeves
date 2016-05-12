#Store URL
require 'cgi'
require 'open-uri'
require 'yaml'

$help_messages << "!store_url <url>  :  Store a URL."
$help_messages << "!list_url  :  List of the stored URLs and their IDs."
$help_messages << "!retrieve_url <url_id>  :  Retrieve a URL by ID."
$help_messages << "!remove_url <url>  :  Remove a URL using the URL."

class StoreUrl

  include Cinch::Plugin

  URL_FILE_PATH = "config/store_url/store_url.yml"

  match /store_url (.*)/, method: :store_url
  match /list_url$/, method: :list_url
  match /retrieve_url (.*)/, method: :retrieve_url
  match /remove_url (.*)/, method: :remove_url

  @@url_array = []

  def write_file
    File.open(URL_FILE_PATH, "w") do |f|
      f << @@url_array.to_yaml
    end
  end

  def store_url(m, url)
    if @@url_array.include?(url) == false
      @@url_array << url
      write_file
      m.reply "URL is stored"
    else
      m.reply "That URL is already stored"
    end
  end

  def list_url(m)
    @@url_array.each_with_index {|url, index| m.reply "#{index} #{url}\n"}
  end

  def retrieve_url(m, url_id)
    m.reply "#{@@url_array[url_id.to_i]}"
  end

  # Remove URL by full URL, not the index, to prevent typos removing the wrong URL
  def remove_url(m, url)
    if @@url_array.include?(url) == true
      @@url_array.delete(url)
      m.reply "The URL has been removed"
    else
      m.reply "That URL does not exist"
    end
  end

  def initialize(bot)
    super
    @@url_array = YAML.load(File.read(URL_FILE_PATH))
  end

end
