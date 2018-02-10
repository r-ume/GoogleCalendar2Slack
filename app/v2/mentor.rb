require 'rubygems'
require 'active_support/all'

# Mentor
class Mentor
  attr_reader :mention, :birthday

  # Constructor
  # @param [Hash] data The hash variable that has mentor info in it.
  # @return Mentor
  def initialize(mention:, birthday:)
    @mention = mention
    @birthday = birthday
  end

  # Check if his/her birth day is a day before the given date.
  # @return boolean
  def day_before_birthday?
    return false unless @birthday.present?
    @birthday == (Date.today + 1).strftime('%m/%d')
  end
end
