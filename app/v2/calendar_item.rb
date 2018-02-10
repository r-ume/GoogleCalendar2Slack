require 'rubygems'
require 'active_support/all'
require_relative './mentor_registry'

# Data object to wrap and carry an item originally from Google Calendar.
class CalendarItem
  attr_accessor :calendar_name, :start_time, :end_time

  # Constructor
  # @return CalendarItem
  def initialize(calendar_name:, start_time:, end_time:)
    @calendar_name = calendar_name
    @start_time    = start_time
    @end_time      = end_time
  end

  # Return the formatted start time.
  # @return string
  def str_start_time
    @start_time.strftime('%Y:%m:%d %H-%M-%S') if @start_time.present?
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
  def guidance_mentor_item?(calendar_item:)
    calendar_item.start_time.between?(self.start_time, self.end_time) && !for_guidance?
  end

  # Checks if calendar_item is a tomorrow_shift
  # @return Boolean
  def tomorrow_shift?
    @start_time.present? && between_tomorrow_and_the_day_after_tomorrow?
  end

  private

  # Checks if the calendar item is from today to tomorrow.
  # @return Boolean
  def between_tomorrow_and_the_day_after_tomorrow?
    tomorrow = Date.today + 1
    day_after_tomorrow = Date.today + 2
    @start_time.between?(tomorrow, day_after_tomorrow)
  end
end
