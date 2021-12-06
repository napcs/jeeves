require 'test_helper.rb'
require 'room'

class RoomTest < MiniTest::Test

  # To ensure things work, I need at least one test that hits
  # the real endpoint.
  def test_gets_random_room_with_real_request
    WebMock.allow_net_connect!

    url = Room.new.get_random_room_url

    assert_match /jump\.chat\/c\/(.*)/, url
  end

  # commented out cos there's no bot testing framework

  # must ensure return message is correct. And to do that I must fake out
  # the backend with something I know. So it can't be random.
  # def test_gets_random_room_with_faked_request

    # WebMock.disable_net_connect!
    # stub_request(:any, "https://jump.chat/c/").
      # to_return(:body => '{"roomName": "/hallowed-wasp"}' , :status => 200)


    # assert_equal "New Video Call starting. Join at https://appear.in/hallowed-wasp", result

  # end

end
