require 'rubygems'
require 'pry'
require_relative './util/slack_notifier'
require_relative './calendar_item'

# Slack
class SlackForNotification

  # Constants
  GUIDANCE_STATEMENT                 = '明日ガイダンスがあるメンターはこちら！'
  NO_GUIDANCE_STATEMENT              = '明日のガイダンスはありません！'
  BIRTHDAY_STATEMENT                 = 'そして、なんと明日誕生日のメンターが!!! そのメンターは...!!!'
  CELERATION_ENCOURAGEMENT_STATEMENT = '明日会ったときに、「誕生日おめでとう」と言おう！'

  class << self
    # sends birthday notification
    # @return nil
    def sends_birthday_notification(mention:, calendar_name:)
      SlackNotifier.post(text: BIRTHDAY_STATEMENT)
      SlackNotifier.post(text: "<#{mention}>#{calendar_name}　:tada: :tada:")
      SlackNotifier.post(text: CELERATION_ENCOURAGEMENT_STATEMENT)
    end

    # sends guidance notification and the mentor in charged of the guidance.
    # @return nil
    def sends_guidance_notification(mention:, calendar_name:, guidance_name:, start_time:)
      SlackNotifier.post(text: GUIDANCE_STATEMENT)
      SlackNotifier.post(text: "#{guidance_name} : 担当メンター <#{mention}> #{calendar_name} : #{start_time}")
    end

    # sends no guidance notification, letting mentors know that there is no guidance held today.
    # @return nil
    def sends_no_guidance_notification
      SlackNotifier.post(text: NO_GUIDANCE_STATEMENT)
    end
  end
end
