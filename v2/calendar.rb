require 'rubygems'
require 'dotenv'
require 'pry'
require './util/google_authentication'
require '../v2/calendar_item'

Dotenv.overload

# Utility (static class) for retrieving data from Google calendar.
class Calendar
  @@calendar = GoogleAuthentication.access_to_calendar_service

  # Get items
  # @return GoogleCalendarItem[]
  class << self
    def shifts_tomorrow
      tomorrow_shifts = []
      ids.each { |calendar_id|
        @@calendar.list_events(calendar_id).items.each { |event|
          calendar_item = CalendarItem.new( { calendar_name: event.summary, start_time: event.start.date_time } )
          tomorrow_shifts.push(calendar_item) if calendar_item.tomorrow_shift?
        }
      }
      tomorrow_shifts
    end

    private
    def ids
      @@calendar.list_calendar_lists.items.reject{ |calendar| calendar.id == ENV['GMAIL_ACCOUNT'] }.map(&:id)
    end
  end

end
