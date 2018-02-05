require 'rubygems'
require 'dotenv'
require 'pry'
require_relative './util/google_authentication'
require_relative './calendar_item'

Dotenv.overload

# Utility (static class) for retrieving data from Google calendar.
class Calendar
  @@calendar = GoogleAuthentication.access_to_calendar_service

  # Get items
  # @return GoogleCalendarItem[]
  class << self
    def shifts_tomorrow
      events.map { |event|
        CalendarItem.new(calendar_name: event.summary,
                         start_time: event.start.date_time, end_time: event.end.date_time)
      }.select(&:tomorrow_shift?)
    end

    private

    # Get the id of all calendars other than the one registered by the account.
    # @return string[]
    def ids
      @@calendar.list_calendar_lists.items.reject{ |calendar| calendar.id == ENV['GMAIL_ACCOUNT'] }.map(&:id)
    end

    # Get all the events registered on each calendar.
    # @return Google::Apis::CalendarV3::Event[]
    def events
      ids.flat_map { |calendar_id| @@calendar.list_events(calendar_id).items }
    end
  end

end
