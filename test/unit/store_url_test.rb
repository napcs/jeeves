require 'test_helper.rb'
require 'store_url'

class StoreUrlTest < MiniTest::Test

	def test_store_imdb_dot_com
		bot = make_bot(StoreUrl)
		message = make_message(bot, "!store_url www.imdb.com")
		replies = get_replies(message)
		assert_equal = "URL is stored", replies.first
	end

	def test_store_already_existing_url
		bot = make_bot(StoreUrl)
		message = make_message(bot, "!store_url www.imdb.com")
		replies = get_replies(message)
		assert_equal = "That URL is already stored", replies.first
	end

	def test_list_url
		bot = make_bot(StoreUrl)
		message = make_message(bot, "!list_url")
		replies = get_replies(message)
		assert_equal = "0 www.bphogan.com", replies.first
	end

	def test_retrieve_index_zero
		bot = make_bot(StoreUrl)
		message = make_message(bot, "!retrieve_url 0")
		replies = get_replies(message)
		assert_equal = "www.bphogan.com", replies.first
	end

	def test_remove_non_existent_url
		bot = make_bot(StoreUrl)
		message = make_message(bot, "!remove_url everythingisawesome")
		replies = get_replies(message)
		assert_equal = "That URL does not exist", replies.first
	end

	def test_remove_imdb_dot_com
		bot = make_bot(StoreUrl)
		message = make_message(bot, "!remove_url www.imdb.com")
		replies = get_replies(message)
		assert_equal = "The URL has been removed", replies.first
	end

end