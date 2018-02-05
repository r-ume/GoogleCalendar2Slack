require_relative './mentor_registry'

# Data object to wrap and carry an item originally from Google Calendar.
class CalendarItem
  attr_accessor :calendar_name, :start_time, :end_time

  TOMORROW           = Date.today + 1
  DAY_AFTER_TOMORROW = TOMORROW + 1

  # Constructor
  # @return CalendarItem
  def initialize(calendar_name:, start_time:, end_time:)
    @calendar_name = calendar_name
    @start_time    = start_time
    @end_time      = end_time
  end

  # Return a mentor who is a participant of this calendar item.
  # @return Mentor
  def mentor
    MentorRegistry.instance.find_by_name(@calendar_name)
  end

  # Checks if the calendar_item is for guidance
  # @return boolean
  def for_guidance?
    @calendar_name.include?('面談')
  end

  # Get the mentor who is in charged of the guidance item on the calendar.
  # This method rejects guidance item itself.
  # @return CalendarItem
  def guidance_mentor_item(calendar_item)
    @start_time.between?(calendar_item.start_time, calendar_item.end_time) && !for_guidance?
  end

  # Checks if calendar_item is a tomorrow_shift
  # @return Boolean
  def tomorrow_shift?
    start_time_nil? && between_tomorrow_and_the_day_after_tomorrow?
  end

  private
  # Checks if the calendar item object does not have any start_time in it.
  # @return Boolean
  def start_time_nil?
    !@start_time.nil?
  end

  # Checks if the calendar item is from today to tomorrow.
  # @return Boolean
  def between_tomorrow_and_the_day_after_tomorrow?
    @start_time.between?(TOMORROW, DAY_AFTER_TOMORROW)
  end
end
