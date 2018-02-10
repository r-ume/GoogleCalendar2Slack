require 'rubygems'
require 'pry'
require 'date'
require './google_authentication.rb'
require './mentors.rb'
require './util/array_handler.rb'

class GoogleCalendar
  PRIMARY_CALENDAR_ID = ENV['GMAIL_ACCOUNT']
  APPLICATION_NAME    = 'Slack Notification From Calendar'

  def initialize
    @google_calendar                                 = GoogleAuthentication.access_to_calendar_service
    @google_calendar.authorization                   = GoogleAuthentication.authorize
    @google_calendar.client_options.application_name = APPLICATION_NAME
  end

  def today_shifts
    Util::ArrayHandler.select_tomorrow_elements(shifts_without_no_start_time)
  end

  def fetch_calendars
    @google_calendar.list_calendar_lists.items
  end

  protected
  def get_calendar_ids
    calendars = fetch_calendars.delete_if{ |calendar| calendar.id == PRIMARY_CALENDAR_ID }
    calendars.map{ |calendar| calendar.id }
  end

  def fetch_all_shifts
    all_shifts = get_calendar_ids.map do |calendar_id|
      @google_calendar.list_events(calendar_id).items.map do |event|
        {
            calendar_name: event.summary,
            start_time: event.start.date_time
        }
      end
    end
    all_shifts.flatten!
  end

  def shifts_without_no_start_time
    Util::ArrayHandler.remove_no_start_time_elements(fetch_all_shifts)
  end
end
