#Store URL
require 'cgi'
require 'yaml'

# TODO: move this to the config file.
URL_FILE_PATH = "config/store_url/store_url.yml"

class StoreUrl

  attr_reader :path

  def initialize(path)
    @path = path
    @url_array = YAML.load_file(@path)
    @url_array = [] if @url_array == false
  end

  def write_file
    File.open(self.path, "w") do |f|
      f << url_array.to_yaml
    end
  end

  def add_url(url)
    unless url_array.include?(url)
      url_array << url
      write_file
      "#{url} is stored"
    else
      "#{url} is already stored"
    end
  end

  def list_url
    url_array.collect.with_index {|url, index| "#{index} #{url}\n"}.join("\n")
  end

  def retrieve_url(url_id)
    "#{url_array[url_id.to_i]}"
  end

  # Remove URL by full URL, not the index, to prevent typos removing the wrong URL
  def remove_url(url)
    if url_array.include?(url) == true
      url_array.delete(url)
      'The URL has been removed'
    else
      'That URL does not exist'
    end
  end

  private

  def url_array
    @url_array
  end

end



$help_messages << '!add_url <url>  :  Store a URL.'
$help_messages << '!list_url  :  List of the stored URLs and their IDs.'
$help_messages << '!retrieve_url <url_id>  :  Retrieve a URL by ID.'
$help_messages << '!remove_url <url>  :  Remove a URL using the URL.'

urls = StoreUrl.new(URL_FILE_PATH)

Jeeves.command(:add_url) { |_event, url| urls.add_url(url) }
Jeeves.command(:list_url) { urls.list_url }
Jeeves.command(:retrieve_url) { |_event, query| urls.retrieve_url(query) }
Jeeves.command(:remove_url) { |_event, query| urls.remove_url(query) }

