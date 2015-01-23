require 'test_helper.rb'
require 'room'

class RoomTest < MiniTest::Test

  # To ensure things work, I need at least one test that hits
  # the real AppearIn API.
  def test_gets_random_room_with_real_request
    WebMock.allow_net_connect!
    bot = make_bot(Room)
    message = make_message(bot, '!room')
    replies = get_replies(message)

    assert_match /New Video Call starting. Join at(.*)/, replies.first
  end

  # must ensure return message is correct. And to do that I must fake out
  # the backend with something I know. So it can't be random.
  def test_gets_random_room_with_faked_request

    WebMock.disable_net_connect!
    stub_request(:any, "https://api.appear.in/random-room-name").
      to_return(:body => '{"roomName": "/hallowed-wasp"}' , :status => 200)


    bot = make_bot(Room)
    message = make_message(bot, '!room')
    replies = get_replies(message)
    assert_equal "New Video Call starting. Join at https://appear.in/hallowed-wasp", replies.first

  end

end
