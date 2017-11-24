# Mentor.
class Mentor
  attr_accessor :name, :birth_day_str

  # Check if his/her birth day is a day before the given date.
  # @return boolean
  def day_before_birthday?(today); end
end

# Singleton（シングルトンパターン)で実装する。
# List of Mentors
class MentorRegistry
  # Factory, setup registry
  # @return MentorRegistry
  def self.setup(config_file); end

  # Find mentors who has a specific name
  # @return Mentor
  def find_by_name(name); end
end

# Data object to wrap and carry an item originally from Google Calendar.
class CalendarItem
  # Return a mentor who is a participant of this calendar item.
  # @return Mentor
  def mentor; end
end

# Utility (static class) for retrieving data from Google calendar.
class Calendar
  # Get items
  # @return GoogleCalendarItem[]
  def self.shifts_tomorrow()
    items_from_google.map do |item|
      CalendarItem.new(item)
    end
  end
end

# Utility for send notification to Slack
class Slack
  # Send birthday message to Slack
  # @param Mentor mentor
  def self.send_birthday_notification(mentor); end
end

######################

# main

Calendar.shifts_tomorrow.each do |cal|
  if cal.mentor.day_before_birthday?
    Slack.send_birthday_notification cal.mentor
  end
end
