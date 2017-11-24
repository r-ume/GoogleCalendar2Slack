require 'rubygems'
require 'pry'
require './google_authentication.rb'
require './google_calendar.rb'
require './slack_notifier.rb'
require './mentors.rb'
require './util/array_handler.rb'
require './util/hash_handler.rb'

google_calendar = GoogleCalendar.new
shifts = google_calendar.today_shifts
shifts_with_mentions = Mentors.add_their_mentions_into(shifts)
slack_notifier = SlackNotifier.new

if google_calendar.fetch_calendars.empty?
  slack_notifier.sends_notification(SlackNotifier::NO_SHIFT_STATEMENT)
else
  slack_notifier.sends_tomorrow_shifts(shifts_with_mentions)
end
