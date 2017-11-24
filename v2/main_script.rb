require 'rubygems'
require 'yaml'
require 'pry'
require 'dotenv'
require '../v2/mentor_registry'
require '../v2/calendar'
require '../v2/calendar_item'
require '../v2/slack_for_notification'

shifts_tomorrow = Calendar.shifts_tomorrow

if shifts_tomorrow.empty?
  SlackForNotification.sends_no_shift_notification
else
  SlackForNotification.sends_starter_notification

  shifts_tomorrow.each do |calendar_item|
    SlackForNotification.sends_shift_notification(calendar_item)

    if calendar_item.mentor.day_before_birthday?
      SlackForNotification.sends_birthday_notification(calendar_item)
    end
  end
end
