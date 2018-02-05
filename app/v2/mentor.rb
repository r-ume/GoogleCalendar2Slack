# Mentor
class Mentor

  # Constructor
  # @param [Hash] data The hash variable that has mentor info in it.
  # @return Mentor
  def initialize(data)
    @data = data
  end

  # Return the mention on slack in data instance variable.
  # @return String
  def mention
    @data['mention']
  end

  # Check if his/her birth day is a day before the given date.
  # @return boolean
  def day_before_birthday?
    @data['birthday'] == (Date.today+1).strftime('%m/%d')
  end
end
