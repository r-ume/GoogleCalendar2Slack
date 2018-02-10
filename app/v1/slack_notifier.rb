require 'rubygems'
require 'pry'
require 'dotenv/load'
require 'slack-notifier'
require './util/hash_handler.rb'

class SlackNotifier

  STARTER_NOTIFICATION      = '明日のシフトはこちら！'
  HOPING_REACTION_STATEMENT = '`こちらにメンションがついている方は今日23時までに必ず本通知にリアクション` をお願いします!'
  NO_SHIFT_STATEMENT        = '明日のシフトはありません！'
  BIRTHDAY_STATEMENT        = 'そして、なんと明日誕生日のメンターが!!! そのメンターは...!!!'

  def initialize
    @notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'], username: 'TECH::CAMP WASEDA SHIFT REMINDER')
  end

  def sends_notification(notification)
    @notifier.post(text: notification)
  end

  def sends_tomorrow_shifts(shifts_with_mentions)
    self.sends_notification(STARTER_NOTIFICATION)
    self.sends_notification(HOPING_REACTION_STATEMENT)

    shifts_with_mentions.each do |shift_with_mention|
      notification = "<#{shift_with_mention[:mention]}> : #{shift_with_mention[:calendar_name]} : #{shift_with_mention[:start_time]}"
      self.sends_notification(notification)
      self.sends_birthday_notification(notification) if Util::HashHandler.hash_has_birthday_tomorrow?(shift_with_mention)
    end
  end

  def sends_birthday_notification(notification)
    self.sends_notification(BIRTHDAY_STATEMENT)
    self.sends_notification("お誕生日おめでとう! #{notification[:mention]} : #{notification[:calendar_name]}")
  end

end
