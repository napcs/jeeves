require 'test_helper.rb'
require 'store_url'

class StoreUrlTest < MiniTest::Test

  URL_FILE_PATH = "test/test_resources/store_url.yml"

  def test_store_imdb_dot_com
    s = StoreUrl.new(URL_FILE_PATH)
    result =  s.add_url "www.imdb.com"
    assert_equal = "www.imdb.com is stored", result
   end

  def test_store_already_existing_url
    s = StoreUrl.new(URL_FILE_PATH)
    s.add_url "www.imdb.com"
    result =  s.add_url "www.imdb.com"
    assert_equal = "That URL is already stored", result
  end

  def test_list_url
    s = StoreUrl.new(URL_FILE_PATH)
    s.add_url "www.imdb.com"
    result = s.list_url
    assert_equal = "0 www.imdb.com", result
  end

  def test_retrieve_index_zero
    s = StoreUrl.new(URL_FILE_PATH)
    s.add_url "www.imdb.com"
    result = s.retrieve_url 0
    assert_equal = "0 www.imdb.com", result
  end

  def test_remove_non_existent_url
    s = StoreUrl.new(URL_FILE_PATH)
    result = s.remove_url 'everythingisawesome'
    assert_equal = "That URL does not exist", result
  end

  def test_remove_imdb_dot_com
    s = StoreUrl.new(URL_FILE_PATH)
    s.add_url "www.imdb.com"
    result = s.remove_url 'www.imdb.com'
    assert_equal = "The URL has been removed", result
  end

end
