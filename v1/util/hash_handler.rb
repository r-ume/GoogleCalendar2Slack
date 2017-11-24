module Util
  class HashHandler
    TOMORROW = (Date.today + 1).strftime('%m/%d')

    class << self
      def hash_has_birthday_tomorrow?(hash)
        hash[:birthday] == TOMORROW
      end
    end

  end
end
