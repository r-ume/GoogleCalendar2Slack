require 'rubygems'
require 'pry'
require '../v2/util/slack_notifier'
require '../v2/calendar_item'

# Slack
class SlackForNotification

  STARTER_NOTIFICATION      = '明日のシフトはこちら！'
  HOPING_REACTION_STATEMENT = '`こちらにメンションがついている方は今日23時までに必ず本通知にリアクション` をお願いします!'
  NO_SHIFT_STATEMENT        = '明日のシフトはありません！'
  BIRTHDAY_STATEMENT        = 'そして、なんと明日誕生日のメンターが!!! そのメンターは...!!!'
  CELERATION_ENCOURAGEMENT_STATEMENT = '明日会ったときに、「誕生日おめでとう」と言おう！'

  class << self
    def sends_starter_notification
      SlackNotifier.notifier_instance.post(text: STARTER_NOTIFICATION)
      SlackNotifier.notifier_instance.post(text: HOPING_REACTION_STATEMENT)
    end

    def sends_shift_notification(calendar_item)
      notification = "<#{calendar_item.mentor.mention}> : #{calendar_item.calendar_name} : #{calendar_item.start_time}"
      SlackNotifier.notifier_instance.post(text: notification)
    end

    def sends_birthday_notification(calendar_item)
      SlackNotifier.notifier_instance.post(text: BIRTHDAY_STATEMENT)
      SlackNotifier.notifier_instance.post(text: "<#{calendar_item.mentor.mention}>#{calendar_item.calendar_name}")
      SlackNotifier.notifier_instance.post(text: CELERATION_ENCOURAGEMENT_STATEMENT)
    end

    def sends_no_shift_notification
      SlackNotifier.notifier_instance.post(text: NO_SHIFT_STATEMENT)
    end
  end
end
