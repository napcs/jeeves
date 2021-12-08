module JeevesHelpers

  module Utilities
    # This method is taken from rails core
    # (didn't want to load the entire lib for one method)
    # http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-constantize
    def constantize(camel_cased_word)
      names = camel_cased_word.split('::')
      names.shift if names.empty? || names.first.empty?

      constant = Object
      names.each do |name|
        constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
      end
      constant
    end
  end

  module UserHelper

    def find_user_by_username(event, username)
      user = event.server.members.find{|user| user.username == username}
    end

    def find_user_by_id(event, id)
      user = event.server.members.find{|user| user.id == id}
    end

    # Messages from users, if done via the client, may be sent
    # using autocomplete. This doesn't send the username. It sends
    # a special representation of the ID like this:
    #
    #    <@!1234512345>
    #
    # You have to convert this to an integer to look up the user
    # by id.
    def get_user(event, query)
      user = Jeeves.parse_mention(query)

      unless user
        user = find_user_by_username(event, query)
      end

      user
    end

    def valid_user?(event, query)
      !!get_user(event, query)
    end
  end

end
