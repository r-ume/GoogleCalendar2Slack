require 'rubygems'
require 'yaml'
require 'dotenv'
require_relative './mentor_registry'
require_relative './calendar'
require_relative './calendar_item'
require_relative './slack_for_notification'

Dotenv.overload

shifts_tomorrow = Calendar.shifts_tomorrow

if shifts_tomorrow.empty?
  SlackForNotification.sends_no_guidance_notification
else
  shifts_tomorrow.each do |calendar_item|
    unless calendar_item.mentor.mention.nil?
      SlackForNotification.sends_birthday_notification(
        mention:       calendar_item.mentor.mention,
        calendar_name: calendar_item.calendar_name
      ) if calendar_item.mentor.day_before_birthday?
    end

    if calendar_item.for_guidance?
      guidance_mentor_items = shifts_tomorrow.select{ |tomorrow_shift|
        tomorrow_shift.guidance_mentor_item?(calendar_item)
      }

      return SlackForNotification.sends_no_guidance_notification if guidance_mentor_items.empty?

      guidance_mentor_items.each do |guidance_mentor_item|
        SlackForNotification.sends_guidance_notification(
          mention:       guidance_mentor_item.mentor.mention,
          calendar_name: guidance_mentor_item.calendar_name,
          start_time:    guidance_mentor_item.start_time
        )
      end
    end
  end
end
