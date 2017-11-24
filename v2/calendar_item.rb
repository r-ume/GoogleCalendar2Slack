require '../v2/mentor_registry'

# Data object to wrap and carry an item originally from Google Calendar.
class CalendarItem

  # Constructor
  # @return CalendarItem
  def initialize(calendar_item)
    @calendar_item = calendar_item
  end

  # Return a mentor who is a participant of this calendar item.
  # @return Mentor
  def mentor
    MentorRegistry.instance.find_by_name(calendar_name)
  end

  # Return a calendar_name assigned to the item.
  # In this application, the calendar_name is always a name for a mentor.
  # @return String
  def calendar_name
    @calendar_item[:calendar_name]
  end

  # Return when the item starts.
  # @return String
  def start_time
    @calendar_item[:start_time].strftime('%m/%d %H:%M')
  end

  # Checks if calendar_item is a tomorrow_shift
  # @return Boolean
  def tomorrow_shift?
    start_time_nil? && between_today_and_tomorrow?
  end

  private
  # Checks if the calendar item object does not have any start_time in it.
  # @return Boolean
  def start_time_nil?
    !@calendar_item[:start_time].nil?
  end

  # Checks if the calendar item is from today to tomorrow.
  # @return Boolean
  def between_today_and_tomorrow?
    current_time = DateTime.now
    @calendar_item[:start_time].between?(current_time, current_time + 1)
  end
end
