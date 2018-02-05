require 'rubygems'
require 'yaml'
require 'pry'
require 'dotenv'
require_relative './mentor_registry'
require_relative './calendar'
require_relative './calendar_item'
require_relative './slack_for_notification'

Dotenv.overload

shifts_tomorrow = Calendar.shifts_tomorrow

if shifts_tomorrow.empty?
  # SlackForNotification.sends_no_shift_notification
else
  # SlackForNotification.sends_starter_notification

  shifts_tomorrow.each do |calendar_item|
    # if calendar_item.mentor.day_before_birthday?
    #   SlackForNotification.sends_birthday_notification(
    #     mention:       calendar_item.mentor.mention,
    #     calendar_name: calendar_item.calendar_name
    #   )
    # end

    if calendar_item.for_guidance?
      guidance_mentor_items = shifts_tomorrow.select{ |tomorrow_shift|
        calendar_item.guidance_mentor(tomorrow_shift)
      }

      guidance_mentor_items.each do |guidance_mentor_item|
        SlackForNotification.sends_birthday_notification(
          mention:       guidance_mentor_item.mentor.mention,
          calendar_name: guidance_mentor_item.calendar_name
        )
      end
    end
  end
end
